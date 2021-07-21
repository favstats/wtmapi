

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
                    raw = F) {

    input_list <- list(country = country,
                       party = party,
                       '$select[]' = selects,
                       '$limit' = limit,
                       '$skip' = skip)

    fin <- input_list %>%
        imap(~url_form(.x, .y)) %>%
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
            set_names(c("values_in_var",
                        "values_nin_var",
                        "gt", "gte",
                        "lt", "lte",
                        "ne"
                        ))

        if(!is.null(or)){
            op <- case_when(
                or == "values_in_var" ~ "\\$in",
                or == "values_nin_var" ~ "\\$nin",
                T ~ as.character(glue::glue("\\${or}"))
            )

            out_append <- args %>%
                purrr::imap(wrap_it) %>%
                purrr::flatten()

            or_list_raw <- out_append[str_detect(names(out_append), paste0(op, collapse = "|"))]

            or_list <- list(`$or` = or_list_raw)

            or_list_flatten <- rlist::list.flatten(or_list)
            or_list_names <- rlist::list.names(or_list_flatten) %>%
                stringr::str_replace("\\[", "][") %>%
                stringr::str_replace("\\.", ".[") %>%
                stringr::str_replace("\\.", glue::glue("[{1:length(or_list_flatten)-1}]"))

            or_list_complete <- or_list_flatten %>%
                purrr::set_names(or_list_names)


            out_append <- out_append[!str_detect(names(out_append), paste0(op, collapse = "|"))]

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
            bind_rows()

        return(con)
    }

}



debugonce(wtm_get)


url_form <- function(x, listname) {

    formed_url <- x %>%
        purrr::map(
            ~{listname = .x }
        ) %>%
        purrr::set_names(rep(listname, length(x)))


    return(formed_url)
}


flatten_it <- function(val, nam) {
    list(val) %>%
        purrr::flatten() %>%
        purrr::set_names(nam) %>%
        purrr::imap(~url_form(.x, .y)) %>%
        purrr::flatten()
}


wrap_it <- function(arg, arg_names) {

    var_names <- names(arg)

    val <- case_when(
        arg_names == "values_in_var" ~ "[$in][]",
        arg_names == "values_nin_var" ~ "[$nin][]",
        T ~ as.character(glue::glue("[${arg_names}]"))
    )


    vec <- glue::glue("{var_names}{val}")

    in_append <- flatten_it(arg,
                            vec)


    return(in_append)

}


# values_in_var <- list(impressions = c(3, 4),
#                       date = c("2021-07-20", "2021-07-19"))
#
# asd <- wtm_get(endpoint = "candidates-impressions",
#                sort_by = c("impressions", "date"),
#                sort_dir =  -1,
#                values_in_var = list(facebookName = c("wirBerlin", "PETA Deutschland"),
#                                     date = c("2021-06-20", "2021-06-19")),
#                gt = list(impressions = 20),
#                or = c("values_in_var"), raw = F)
