
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

## Examples

``` r
library(wtmapi)
```

The main function in `wtmapi` to use is **`wtm_get`**. With it you can
access the API endpoints:

-   `candidates-impressions`
-   `candidates-targeting-methods`
-   `impressions-daily-totals`

Here are some basic examples which show you how to solve a common
problems. If you have questions, refer to the
[docs](https://data-api.whotargets.me/docs/) which will help you with
the query parameter.

### Retrieve impressions

Let’s say we want to retrieve all ads with 20 impressions from the party
“CDU” in Germany:

``` r
impressions_dat <- wtm_get(endpoint = "candidates-impressions", 
               country = "DE", 
               party = "CDU",
               lt = list(impressions = 20))

impressions_dat
#> # A tibble: 25 x 7
#>    id            facebookId  facebookName       party country date   impressions
#>    <chr>         <chr>       <chr>              <chr> <chr>   <chr>  <chr>      
#>  1 35619e79b4da~ 3494522951~ Peter Stein, Bund~ CDU   DE      2021-~ 1          
#>  2 537216fb99e8~ 9429490791~ Dr. Jan-Marco Luc~ CDU   DE      2021-~ 2          
#>  3 196c02df42a2~ 3278628740~ Anja Karliczek     CDU   DE      2021-~ 1          
#>  4 41cff31f14f2~ 5426055824~ Christian Hirte    CDU   DE      2021-~ 1          
#>  5 385ef49d23df~ 1088268980~ Uwe Feiler         CDU   DE      2021-~ 1          
#>  6 25e29121f1dc~ 1009180653~ Klaus Mack         CDU   DE      2021-~ 1          
#>  7 49764ad28326~ 1370190563~ Felix Schreiner    CDU   DE      2021-~ 4          
#>  8 1b236ba43279~ 1027685716~ Dr. Ehsan Kangara~ CDU   DE      2021-~ 1          
#>  9 7dc56dc23c40~ 1023862819~ Ariturel Hack      CDU   DE      2021-~ 1          
#> 10 445a3371831f~ 4670977199~ Ingo Wellenreuther CDU   DE      2021-~ 3          
#> # ... with 15 more rows
```

### Retrieve targeting methods

Let’s say we want to retrieve all ads which have greater than or equal
to one `bct` (which is the behavioural targeting method) in the US:

``` r
targeting_dat <- wtm_get(endpoint = "candidates-targeting-methods", 
                         country = "US",
                         gte = list(bct = 1))

targeting_dat
#> # A tibble: 25 x 36
#>    id        facebookId  facebookName   party country total_ads actionable_insi~
#>    <chr>     <chr>       <chr>          <chr> <chr>   <chr>     <chr>           
#>  1 0dd4aacc~ 1061240530~ Joe Collins    GOP   US      71        0               
#>  2 d5d0d159~ 1124023587~ PopSugar       Biden US      397       0               
#>  3 3874dbe0~ 1165462883~ Heritage Acti~ RepP~ US      6         0               
#>  4 6b108eb6~ 1228396643~ Michelle Steel GOP   US      12        0               
#>  5 4dbb3b4b~ 12301006942 Democratic Pa~ DemP~ US      53        0               
#>  6 2819c7b6~ 1272259106~ PragerU        Oth   US      335       0               
#>  7 ecc4bc9a~ 1316372698~ Alexandria Oc~ Dems  US      285       0               
#>  8 015c0299~ 1593518174~ Candace Owens  RepP~ US      15        0               
#>  9 64f600b8~ 2116141045~ Mike Garcia f~ GOP   US      7         0               
#> 10 e59d6093~ 2281325372~ Tammy Duckwor~ Dems  US      10        0               
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

Retrieve the daily total impressions for a country (in this case
germany):

``` r
daily_totals <- wtm_get(endpoint = "impressions-daily-totals", 
                        country = "DE")

daily_totals
#> # A tibble: 25 x 7
#>    id    country date  advertisers impressions political_adver~ political_impre~
#>    <chr> <chr>   <chr> <chr>       <chr>       <chr>            <chr>           
#>  1 54d5~ DE      2021~ 3887        32700       143              721             
#>  2 e738~ DE      2021~ 3730        29563       137              629             
#>  3 156f~ DE      2021~ 4546        38873       164              892             
#>  4 2179~ DE      2021~ 6331        47513       147              706             
#>  5 200e~ DE      2021~ 6766        50113       150              821             
#>  6 e6e2~ DE      2021~ 7273        54130       142              805             
#>  7 0680~ DE      2021~ 7406        55850       164              943             
#>  8 e7cc~ DE      2021~ 6165        42536       116              599             
#>  9 09e2~ DE      2021~ 5758        39692       103              535             
#> 10 44db~ DE      2021~ 6820        46951       119              826             
#> # ... with 15 more rows
```

## TODO

-   Include pagination
-   Improve documentation
