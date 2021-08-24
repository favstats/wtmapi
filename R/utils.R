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

    val <- dplyr::case_when(
        arg_names == "values_in_var" ~ "[$in][]",
        arg_names == "values_nin_var" ~ "[$nin][]",
        T ~ as.character(glue::glue("[${arg_names}]"))
    )


    vec <- glue::glue("{var_names}{val}")

    in_append <- flatten_it(arg,
                            vec)


    return(in_append)

}
