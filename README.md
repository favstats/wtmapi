
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

### Retrieve candidates impressions

``` r
ads <- wtm_get(endpoint = "candidates-impressions", country = "DE", party = "CDU")

ads
#> # A tibble: 25 x 7
#>    id          facebookId   facebookName         party country date  impressions
#>    <chr>       <chr>        <chr>                <chr> <chr>   <chr> <chr>      
#>  1 cc0ebc83e3~ 20125673290~ Michael Sack         CDU   DE      2021~ 1          
#>  2 1cf0b67696~ 49090666776~ Sven Schulze         CDU   DE      2021~ 1          
#>  3 a1e91ad19f~ 78749130807~ Stadt.Land.Main Wür~ CDU   DE      2021~ 1          
#>  4 97b3c430d2~ 108826898029 Uwe Feiler           CDU   DE      2021~ 1          
#>  5 525db46633~ 17909200009~ CDU CSU Europa       CDU   DE      2021~ 1          
#>  6 08b4ddd518~ 12112161461~ Konrad Adenauer Sti~ CDU   DE      2021~ 1          
#>  7 33aa9dcbf4~ 16358148377~ Konrad-Adenauer-Sti~ CDU   DE      2021~ 1          
#>  8 20b950a4ce~ 12695290398~ CDU Berlin           CDU   DE      2021~ 1          
#>  9 318bda56ff~ 78749130807~ Stadt.Land.Main Wür~ CDU   DE      2021~ 1          
#> 10 1b241ca4c2~ 32786287400~ Anja Karliczek       CDU   DE      2021~ 1          
#> # ... with 15 more rows
```

### Retrieve impressions

``` r
impressions_dat <- wtm_get(endpoint = "candidates-impressions", country = "DE", party = "CDU")

impressions_dat
#> # A tibble: 25 x 7
#>    id          facebookId   facebookName         party country date  impressions
#>    <chr>       <chr>        <chr>                <chr> <chr>   <chr> <chr>      
#>  1 cc0ebc83e3~ 20125673290~ Michael Sack         CDU   DE      2021~ 1          
#>  2 1cf0b67696~ 49090666776~ Sven Schulze         CDU   DE      2021~ 1          
#>  3 a1e91ad19f~ 78749130807~ Stadt.Land.Main Wür~ CDU   DE      2021~ 1          
#>  4 97b3c430d2~ 108826898029 Uwe Feiler           CDU   DE      2021~ 1          
#>  5 525db46633~ 17909200009~ CDU CSU Europa       CDU   DE      2021~ 1          
#>  6 08b4ddd518~ 12112161461~ Konrad Adenauer Sti~ CDU   DE      2021~ 1          
#>  7 33aa9dcbf4~ 16358148377~ Konrad-Adenauer-Sti~ CDU   DE      2021~ 1          
#>  8 20b950a4ce~ 12695290398~ CDU Berlin           CDU   DE      2021~ 1          
#>  9 318bda56ff~ 78749130807~ Stadt.Land.Main Wür~ CDU   DE      2021~ 1          
#> 10 1b241ca4c2~ 32786287400~ Anja Karliczek       CDU   DE      2021~ 1          
#> # ... with 15 more rows
```

### Retrieve targeting methods

``` r
targeting_dat <- wtm_get(endpoint = "candidates-targeting-methods", country = "DE", party = "SPD")

targeting_dat
#> # A tibble: 25 x 36
#>    id       facebookId  facebookName    party country total_ads actionable_insi~
#>    <chr>    <chr>       <chr>           <chr> <chr>   <chr>     <chr>           
#>  1 fbfcb85~ 1003777185~ Takis Mehmet A~ SPD   DE      4         0               
#>  2 ccfe53a~ 1003895020~ Kai Koeser      SPD   DE      3         0               
#>  3 b7991ec~ 1005084388~ Philipp Siever~ SPD   DE      1         0               
#>  4 953c3a4~ 1007559819~ Seija Knorr-Kö~ SPD   DE      13        0               
#>  5 e7e7302~ 1008127920~ Claudio Proven~ SPD   DE      1         0               
#>  6 500f802~ 1008923747~ Lennard Oehl -~ SPD   DE      2         0               
#>  7 84470c9~ 1019100717~ Dr. Carolin Wa~ SPD   DE      1         0               
#>  8 89330f1~ 1019681316~ Andreas Larem ~ SPD   DE      15        0               
#>  9 23587e4~ 1021607684~ Lina Seitzl     SPD   DE      7         0               
#> 10 a23bc37~ 1023433218~ Jakob Blankenb~ SPD   DE      1         0               
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
daily_totals <- wtm_get(endpoint = "impressions-daily-totals", country = "DE")

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
