#' wtm_get
#'
#'
#' The goal of `wtm_get` is to provide access to the [public data API](https://data-api.whotargets.me/docs/) of [Who Targets Me](https://whotargets.me/en/).
#'
#' @param endpoint the API endpoint you want to retrieve. currently supports: `candidates-impressions`, `candidates-targeting-methods` and `impressions-daily-totals`.
#' @param country which country to retrieve data from (ISO2). Examples: `"DE"`, `"US"` etc.
#' @param party which party to retrieve data from. Examples: `"CDU"`, `"Biden"` etc.
#' @param limit will return only the number of results you specify
#' @param skip will skip the specified number of results
#' @param selects allows to pick which fields to include in the result, chr or vector of chrs
#' @param sort_by  will sort based on the variable you provide (chr)
#' @param sort_dir  sort direction (`1` ascending, `-1` descending) (default = `1`)
#' @param values_in_var  find all records where the property does (`$in`) match any of the given values. Input is a list: `list(variable = c(1:3))`.
#' @param values_nin_var  find all records where the property does not (`$nin`) match any of the given values.  Input is a list: `list(variable = c(1:3))`.
#' @param lt  find all records where the value is less (`$lt`) to a given value. Input is a list: `list(variable = c(1:3))`.
#' @param lte  find all records where the value is less and equal (`$lte`) to a given value. Input is a list: `list(variable = c(1:3))`.
#' @param gt  find all records where the value is more (`$gt`) to a given value. Input is a list: `list(variable = c(1:3))`.
#' @param gte  find all records where the value is more and equal (`$gte`) to a given value. Input is a list: `list(variable = c(1:3))`.
#' @param ne  find all records that do not equal the given property value. Input is a list: `list(variable = c(1:3))`.
#' @param or find all records that match any of the given criteria. Specify the params as chr (vector) that should be combined with an `$or` statement. Example: `c("values_in_var", "gt")`.
#' @param ...  additional arguments you can pass to test for equality. Example = `facebookName = PragerU` retrieves all entries by advertiser `PragerU`.
#' @param raw  whether to return the raw `GET` request or a tidy data frame (defaults to `FALSE`)
#' @examples
#' # retrieve all advertiser targeting methods in the use
#' # that have a greater or equal value of `bct = 1`.
#' wtm_get(endpoint = "candidates-targeting-methods",
#'         country = "US",
#'         gte = list(bct = 1))
#'
#'
#' # retrieve all advertiser targeting methods in the use
#' # that have a greater or equal value of `bct = 1` OR
#' # `custom_audiences_lookalike = 20`.
#' wtm_get(endpoint = "candidates-targeting-methods",
#'         country = "US",
#'         gte = list(bct = 1),
#'         value_in_var = list(custom_audiences_lookalike = 20),
#'         or = c("gte", "value_in_var"))
#' @export
wtm_get <- function(endpoint,
                    country = NULL,
                    party = NULL,
                    limit = NULL,
                    skip = NULL,
                    selects = NULL,
                    sort_by = NULL,
                    sort_dir = 1,
                    values_in_var = NULL,
                    values_nin_var = NULL,
                    lt = NULL,
                    lte = NULL,
                    gt = NULL,
                    gte = NULL,
                    ne = NULL,
                    or = NULL,
                    ...,
                    raw = F) {


    params <- list(...)

    input_list <- list(country = country,
                       party = party,
                       '$select[]' = selects,
                       '$limit' = limit,
                       '$skip' = skip)

    if(length(params)!=0){
        input_list <- rlist::list.append(input_list, params) %>%
            purrr::flatten()
    }

    fin <- input_list %>%
        purrr::imap(~url_form(.x, .y)) %>%
        purrr::flatten()


    ###### sort by ####
    if(!is.null(sort_by)){

        if(length(sort_by) != length(sort_dir)){
            warning(glue::glue("length of sort_by does not match sort_dir. Will use default direction: `{sort_dir}`"))
            sort_dir <- rep(sort_dir, length(sort_by))
        }

        sort_by_vec <- glue::glue("$sort[{sort_by}]")

        sort_append <- flatten_it(sort_dir,
                                sort_by_vec)

        fin <- fin %>%
            rlist::list.append(sort_append) %>%
            purrr::flatten()
    }

    if(any(!is.null(values_in_var), !is.null(values_in_var),
       !is.null(gt), !is.null(gte), !is.null(lt),
       !is.null(lte), !is.null(ne))){

        args <- list(values_in_var,
                     values_nin_var,
                     gt, gte,
                     lt, lte,
                     ne) %>%
            purrr::set_names(c("values_in_var",
                        "values_nin_var",
                        "gt", "gte",
                        "lt", "lte",
                        "ne"
                        ))


        out_append <- args %>%
            purrr::imap(wrap_it) %>%
            purrr::flatten()

        if(!is.null(or)){
            op <- dplyr::case_when(
                or == "values_in_var" ~ "\\$in",
                or == "values_nin_var" ~ "\\$nin",
                T ~ as.character(glue::glue("\\${or}"))
            )

            or_list_raw <- out_append[stringr::str_detect(names(out_append), paste0(op, collapse = "|"))]

            or_list <- list(`$or` = or_list_raw)

            or_list_flatten <- rlist::list.flatten(or_list)
            or_list_names <- rlist::list.names(or_list_flatten) %>%
                stringr::str_replace("\\[", "][") %>%
                stringr::str_replace("\\.", ".[") %>%
                stringr::str_replace("\\.", glue::glue("[{1:length(or_list_flatten)-1}]"))

            or_list_complete <- or_list_flatten %>%
                purrr::set_names(or_list_names)

            out_append <- out_append[!stringr::str_detect(names(out_append), paste0(op, collapse = "|"))]

            out_append <- out_append %>%
                rlist::list.append(or_list_complete) %>%
                purrr::flatten()

        }


        fin <- fin %>%
            rlist::list.append(out_append) %>%
            purrr::flatten()

    }


    res <- httr::GET(
        url = glue::glue("https://data-api.whotargets.me/{endpoint}"),
        query = fin
    )


    if(raw){

        return(res)

    } else {

        con <- httr::content(res)

        con <- con$data %>%
            dplyr::bind_rows()

        return(con)
    }

}


# values_in_var <- list(impressions = c(3, 4),
#                       date = c("2021-07-20", "2021-07-19"))
#
# asd <- wtm_get(endpoint = "candidates-impressions",
#                country = "DE",
#                sort_by = c("impressions", "date"),
#                sort_dir =  -1,
#                values_in_var = list(facebookName = c("wirBerlin", "PETA Deutschland"),
#                                     date = c("2021-06-20", "2021-06-19")),
#                gt = list(impressions = 20),
#                or = c("values_in_var"), raw = F)
# asd
# httr::content(asd) %>% View
