
<!-- README.md is generated from README.Rmd. Please edit that file -->

# wtmapi

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

The goal of `wtmapi` is to provide access to the [public data
API](https://data-api.whotargets.me/docs/) of [Who Targets
Me](https://whotargets.me/en/).

## Installation

You can install the released version of wtmapi from
[GitHub](https://github.com/favstats/wtmapi) with:

``` r
# install.packages("remotes")
remotes::install_github("favstats/wtmapi")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(wtmapi)
```

### Retrieve impressions

``` r
impressions_dat <- wtm_get(endpoint = "candidates-impressions", 
               country = "DE", 
               party = "CDU",
               lt = list(impressions = 20))

impressions_dat
#> # A tibble: 25 x 7
#>    id          facebookId  facebookName         party country date   impressions
#>    <chr>       <chr>       <chr>                <chr> <chr>   <chr>  <chr>      
#>  1 b7b322302e~ 1921302241~ CDU Nottuln          CDU   DE      2021-~ 1          
#>  2 4b846f92a4~ 78502295414 CDU                  CDU   DE      2021-~ 14         
#>  3 85a568249b~ 1269529039~ CDU Berlin           CDU   DE      2021-~ 2          
#>  4 2a7e7ca5aa~ 1838260483~ CDU Dortmund         CDU   DE      2021-~ 1          
#>  5 4604b6a48a~ 1095525111~ Axel Kaufmann        CDU   DE      2021-~ 1          
#>  6 b364e5418d~ 3952926511~ Working Group Inter~ CDU   DE      2021-~ 2          
#>  7 b58575fe85~ 1095525111~ Axel Kaufmann        CDU   DE      2021-~ 1          
#>  8 fbfb548077~ 78502295414 CDU                  CDU   DE      2021-~ 9          
#>  9 d3ef49a544~ 1095525111~ Axel Kaufmann        CDU   DE      2021-~ 1          
#> 10 32591e3624~ 78502295414 CDU                  CDU   DE      2021-~ 5          
#> # ... with 15 more rows
```

### Retrieve targeting methods

``` r
targeting_dat <- wtm_get(endpoint = "candidates-targeting-methods", 
                         country = "US",
                         gte = list(bct = 1))

targeting_dat
#> # A tibble: 25 x 36
#>    id        facebookId  facebookName   party country total_ads actionable_insi~
#>    <chr>     <chr>       <chr>          <chr> <chr>   <chr>     <chr>           
#>  1 0dd4aacc~ 1061240530~ Joe Collins    GOP   US      71        0               
#>  2 d5d0d159~ 1124023587~ PopSugar       Biden US      393       0               
#>  3 6b108eb6~ 1228396643~ Michelle Steel GOP   US      12        0               
#>  4 4dbb3b4b~ 12301006942 Democratic Pa~ DemP~ US      53        0               
#>  5 2819c7b6~ 1272259106~ PragerU        Oth   US      321       0               
#>  6 ecc4bc9a~ 1316372698~ Alexandria Oc~ Dems  US      283       0               
#>  7 015c0299~ 1593518174~ Candace Owens  RepP~ US      14        0               
#>  8 64f600b8~ 2116141045~ Mike Garcia f~ GOP   US      7         0               
#>  9 e59d6093~ 2281325372~ Tammy Duckwor~ Dems  US      10        0               
#> 10 3ec7fa0b~ 23790541544 Democrats      Dems  US      6         0               
#> # ... with 15 more rows, and 29 more variables: age_gender <chr>, bct <chr>,
#> #   collaborative_ad <chr>, collaborative_ads_category_targeting <chr>,
#> #   collaborative_ads_store_visits <chr>, connection <chr>,
#> #   custom_audiences_datafile <chr>, custom_audiences_engagement_canvas <chr>,
#> #   custom_audiences_engagement_event <chr>,
#> #   custom_audiences_engagement_ig <chr>,
#> #   custom_audiences_engagement_lead_gen <chr>,
#> #   custom_audiences_engagement_page <chr>,
#> #   custom_audiences_engagement_video <chr>, custom_audiences_lookalike <chr>,
#> #   custom_audiences_mobile_app <chr>, custom_audiences_offline <chr>,
#> #   custom_audiences_store_visits <chr>, custom_audiences_website <chr>,
#> #   dynamic_rule <chr>, ed_status <chr>, edu_schools <chr>,
#> #   friends_of_connection <chr>, interests <chr>, local_reach <chr>,
#> #   locale <chr>, location <chr>, relationship_status <chr>,
#> #   work_employers <chr>, work_job_titles <chr>
```

### Retrieve daily totals

``` r
daily_totals <- wtm_get(endpoint = "impressions-daily-totals", 
                        country = "DE")

daily_totals
#> # A tibble: 25 x 7
#>    id    country date  advertisers impressions political_adver~ political_impre~
#>    <chr> <chr>   <chr> <chr>       <chr>       <chr>            <chr>           
#>  1 e533~ DE      2021~ 6056        41071       97               590             
#>  2 d814~ DE      2021~ 5310        34515       87               493             
#>  3 c69b~ DE      2021~ 6563        42499       94               696             
#>  4 020d~ DE      2021~ 6555        39867       90               609             
#>  5 f886~ DE      2021~ 7050        48501       91               603             
#>  6 4297~ DE      2021~ 6745        46372       110              892             
#>  7 a21b~ DE      2021~ 6697        49373       98               996             
#>  8 726f~ DE      2021~ 5525        37936       83               787             
#>  9 5202~ DE      2021~ 5260        32409       88               611             
#> 10 3306~ DE      2021~ 6108        41850       86               746             
#> # ... with 15 more rows
```
