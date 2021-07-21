

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

    # roomId[$in][]=2



    # values_in_var_vec <- values_in_var %>%
    #     glue::glue("$sort[{sort_by}]")

    # roomId[$in][]=2


    input_list <- list(country = country,
                       party = party,
                       '$select[]' = selects,
                       '$limit' = limit,
                       '$skip' = skip)

    fin <- input_list %>%
        imap(~url_form(.x, .y)) %>%
        purrr::flatten()


    if(!is.null(sort_by) | !is.null(values_in_var) |
       !is.null(values_in_var) | !is.null(gt) |
       !is.null(gte) | !is.null(lt) | !is.null(lte) |
       !is.null(ne) | !is.null(or)){

        ###### sort by ####
        if(!is.null(sort_by)){

            if(length(sort_by) != length(sort_dir)){
                warning(glue::glue("length of sort_by does not match sort_dir. Will use default direction: `{sort_dir}`"))
                sort_dir <- rep(sort_dir, length(sort_by))
            }

            sort_by_vec <- glue::glue("$sort[{sort_by}]")

            sort_append <- list(sort_dir) %>%
                purrr::flatten() %>%
                purrr::set_names(sort_by_vec) %>%
                purrr::imap(~url_form(.x, .y)) %>%
                purrr::flatten()

            fin <- fin %>%
                rlist::list.append(sort_append) %>%
                purrr::flatten()
        }

        if(!is.null(values_in_var) | !is.null(values_nin_var)){
            ###### in ####

            we <- list(values_in_var, values_nin_var, gt) %>%
                # purrr::flatten() %>%
                set_names(c("values_in_var", "values_nin_var", "gt"))

            we

            wrap_it <- function(yx, we_names) {

                # yx <- we[[1]]

                yx_names <- names(yx)
                # we_names <- names(we)[[1]]

                 sd <- case_when(
                    we_names == "values_in_var" ~ "[$in][]",
                    we_names == "values_nin_var" ~ "[$nin][]",
                    T ~ as.character(glue::glue("[${we_names}]"))
                )


                vec <- glue::glue("{yx_names}{sd}")

                in_append <- flatten_it(yx,
                                        vec)

                # fin <- fin %>%
                #     rlist::list.append(in_append) %>%
                #     purrr::flatten()

                return(in_append)

            }

            out_append <- we %>%
                imap(wrap_it) %>%
                purrr::flatten()

            fin <- fin %>%
                rlist::list.append(out_append) %>%
                purrr::flatten()


            if(!is.null(values_in_var)){

            values_in_var_vec <- glue::glue("{names(values_in_var)}[$in][]")

            in_append <- flatten_it(values_in_var,
                                    values_in_var_vec)

            fin <- fin %>%
                rlist::list.append(in_append) %>%
                purrr::flatten()

            }

            if(!is.null(values_nin_var)){

                values_nin_var_vec <- glue::glue("{names(values_nin_var)}[$nin][]")

                nin_append <- flatten_it(values_nin_var,
                                         values_nin_var_vec)

                fin <- fin %>%
                    rlist::list.append(nin_append) %>%
                    purrr::flatten()
            }

        }

        if(!is.null(gt) | !is.null(gte)){
            ###### gt ####


            if(!is.null(gt)){


                vec <- glue::glue("{names(gt)}[$gt]")

                append_list <- flatten_it(gt,
                                          vec)

                fin <- fin %>%
                    rlist::list.append(append_list) %>%
                    purrr::flatten()

            }

            if(!is.null(gte)){

                vec <- glue::glue("{names(gte)}[$gte]")

                append_list <- flatten_it(gte,
                                          vec)

                fin <- fin %>%
                    rlist::list.append(append_list) %>%
                    purrr::flatten()

            }

        }

        if(!is.null(lt) | !is.null(lte)){
            ###### lt ####


            if(!is.null(lt)){

                vec <- glue::glue("{names(lt)}[$lt]")

                append_list <- flatten_it(lt,
                                          vec)

                fin <- fin %>%
                    rlist::list.append(append_list) %>%
                    purrr::flatten()

            }

            if(!is.null(lte)){

                vec <- glue::glue("{names(lte)}[$lte]")

                append_list <- flatten_it(lte,
                                          vec)

                fin <- fin %>%
                    rlist::list.append(append_list) %>%
                    purrr::flatten()

            }

        }


        if(!is.null(ne)){
            ###### ne ####


           vec <- glue::glue("{names(ne)}[$ne]")

           append_list <- flatten_it(ne,
                                     vec)

           fin <- fin %>%
               rlist::list.append(append_list) %>%
               purrr::flatten()

        }

        if(!is.null(or)){
            ###### or ####
            # GET /messages?$or[0][archived][$ne]=true&$or[1][roomId]=2


            vec <- glue::glue("$or[0]{names(or)}[$ne]")

            append_list <- flatten_it(ne,
                                      vec)

            fin <- fin %>%
                rlist::list.append(append_list) %>%
                purrr::flatten()

        }

    }


    res <- httr::GET(
        url = glue::glue("https://data-api.whotargets.me/{endpoint}"),
        query = fin
    )

    con <- httr::content(res)

    return(res)
}

debugonce(wtm_get)

values_in_var <- list(impressions = c(3, 4),
                      date = c("2021-07-20", "2021-07-19"))

asd <- wtm_get(endpoint = "candidates-impressions",
               sort_by = c("impressions", "date"),
               sort_dir =  -1,
               values_nin_var = list(
                   facebookName = c("wirBerlin", "PETA Deutschland"),
                   date = c("2021-06-20", "2021-06-19")),
               values_in_var = list(
                   facebookName = c("wirBerlin", "PETA Deutschland"),
                   date = c("2021-06-20", "2021-06-19")),
               gt = list(impressions = 20))
httr::content(asd)


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
