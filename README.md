
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
#>    id          facebookId   facebookName         party country date  impressions
#>    <chr>       <chr>        <chr>                <chr> <chr>   <chr> <chr>      
#>  1 a1e91ad19f~ 78749130807~ Stadt.Land.Main Wür~ CDU   DE      2021~ 1          
#>  2 cc0ebc83e3~ 20125673290~ Michael Sack         CDU   DE      2021~ 1          
#>  3 1cf0b67696~ 49090666776~ Sven Schulze         CDU   DE      2021~ 1          
#>  4 525db46633~ 17909200009~ CDU CSU Europa       CDU   DE      2021~ 1          
#>  5 08b4ddd518~ 12112161461~ Konrad Adenauer Sti~ CDU   DE      2021~ 1          
#>  6 630c35cad4~ 33467267022~ CDU Göttingen        CDU   DE      2021~ 1          
#>  7 1b241ca4c2~ 32786287400~ Anja Karliczek       CDU   DE      2021~ 1          
#>  8 20b950a4ce~ 12695290398~ CDU Berlin           CDU   DE      2021~ 1          
#>  9 33aa9dcbf4~ 16358148377~ Konrad-Adenauer-Sti~ CDU   DE      2021~ 1          
#> 10 318bda56ff~ 78749130807~ Stadt.Land.Main Wür~ CDU   DE      2021~ 1          
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
#>  1 0dd4aacc~ 1061240530~ Joe Collins    GOP   US      70        0               
#>  2 d5d0d159~ 1124023587~ PopSugar       Biden US      387       0               
#>  3 6b108eb6~ 1228396643~ Michelle Steel GOP   US      12        0               
#>  4 4dbb3b4b~ 12301006942 Democratic Pa~ DemP~ US      52        0               
#>  5 2819c7b6~ 1272259106~ PragerU        Oth   US      309       0               
#>  6 ecc4bc9a~ 1316372698~ Alexandria Oc~ Dems  US      283       0               
#>  7 015c0299~ 1593518174~ Candace Owens  RepP~ US      12        0               
#>  8 64f600b8~ 2116141045~ Mike Garcia f~ GOP   US      7         0               
#>  9 3ec7fa0b~ 23790541544 Democrats      Dems  US      5         0               
#> 10 263fb797~ 24330467048 Americans for~ RepP~ US      86        0               
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
#>  1 7fd3~ DE      2021~ 8401        63949       86               761             
#>  2 4756~ DE      2021~ 7085        49463       73               498             
#>  3 820c~ DE      2021~ 6622        45081       78               484             
#>  4 3fb8~ DE      2021~ 7568        56321       81               510             
#>  5 8d81~ DE      2021~ 7633        57133       79               555             
#>  6 0c2a~ DE      2021~ 7528        56715       72               637             
#>  7 cddc~ DE      2021~ 7795        59471       88               635             
#>  8 4547~ DE      2021~ 7911        59894       86               605             
#>  9 f626~ DE      2021~ 6829        47829       86               499             
#> 10 5701~ DE      2021~ 6406        42660       77               530             
#> # ... with 15 more rows
```
