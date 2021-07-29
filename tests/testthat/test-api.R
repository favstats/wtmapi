test_that("less than works", {
    impressions_dat <- wtm_get(endpoint = "candidates-impressions",
                               country = "DE",
                               party = "CDU",
                               lt = list(impressions = 20)) %>%
        dplyr::mutate(impressions = as.numeric(impressions))

    nrows <- nrow(impressions_dat)

    testthat::expect_false(nrows == 0)

    nrows2 <- impressions_dat %>%
        dplyr::filter(impressions > 20) %>%
        nrow()

    testthat::expect_true(nrows2== 0)

})

test_that("less than works", {
    impressions_dat <- wtm_get(endpoint = "candidates-impressions",
                               country = "DE",
                               party = "CDU",
                               lt = list(impressions = 20)) %>%
        dplyr::mutate(impressions = as.numeric(impressions))

    nrows <- nrow(impressions_dat)

    testthat::expect_false(nrows == 0)

    nrows2 <- impressions_dat %>%
        dplyr::filter(impressions > 20) %>%
        nrow()

    testthat::expect_true(nrows2== 0)

})
