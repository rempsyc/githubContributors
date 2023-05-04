
<!-- README.md is generated from README.Rmd. Please edit that file -->

# githubContributors

<!-- badges: start -->
<!-- badges: end -->

The goal of githubContributors is to help obtain and order GitHub user
contributions, which can be used for example to determine or inform
authorship order for R packages.

## Installation

You can install the development version of githubContributors like so:

``` r
# If package `remotes` isn't already installed, install it with `install.packages("remotes")`
remotes::install_github("rempsyc/githubContributors")
```

## Example

Here are a few examples for easystats or other teams:

``` r
library(githubContributors)

report <- get_contributions("report", user = "easystats")
order_authors(report)
#> DominiqueMakowski, strengejacke, IndrajeetPatil, rempsyc, bwiernik, mattansb
#>             username  added deleted commit  score
#> 1  DominiqueMakowski 203778  148154    325 351932
#> 18      strengejacke   5798   38360    234  44158
#> 2     IndrajeetPatil  15198   10565    168  25763
#> 17           rempsyc   4404    3803     25   8207
#> 4           bwiernik   1561     240     12   1801
#> 14          mattansb   1009     603     14   1612

datawizard <- get_contributions("datawizard", user = "easystats")
order_authors(datawizard)
#> IndrajeetPatil, strengejacke, etiennebacher, bwiernik, DominiqueMakowski, rempsyc, mattansb
#>            username added deleted commit score
#> 2    IndrajeetPatil 47402   30891    336 78293
#> 7      strengejacke 34002   10809    503 44811
#> 4     etiennebacher 16539    7346    161 23885
#> 3          bwiernik  4276    2072     11  6348
#> 1 DominiqueMakowski  3108     733     26  3841
#> 6           rempsyc  1657     149      5  1806
#> 5          mattansb  1353     339     17  1692

performance <- get_contributions("performance", user = "easystats")
order_authors(performance)
#> strengejacke, DominiqueMakowski, IndrajeetPatil, rempsyc, mattansb, bwiernik, etiennebacher
#>             username added deleted commit  score
#> 15      strengejacke 67884   61034   1426 128918
#> 2  DominiqueMakowski 50278   25317    141  75595
#> 3     IndrajeetPatil 21182   11440    163  32622
#> 14           rempsyc  9201    4023     26  13224
#> 10          mattansb  8036    2670     60  10706
#> 6           bwiernik  7406    2543     41   9949
#> 7      etiennebacher  1553    1371      7   2924

lavaan <- get_contributions("lavaan", user = "yrosseel")
order_authors(lavaan)
#> yrosseel, TDJorgensen
#>       username  added deleted commit  score
#> 14    yrosseel 202551  116950   1608 319501
#> 3  TDJorgensen   1627     697     61   2324

dplyr <- get_contributions("dplyr", user = "tidyverse")
order_authors(dplyr)
#> romainfrancois, hadley, krlmlr, DavisVaughan, lionel-, batpigandme, hannes, zeehio, jennybc
#>           username  added deleted commit   score
#> 81  romainfrancois 895054  901061   2737 1796115
#> 41          hadley 198717  216820   1987  415537
#> 60          krlmlr 163514  107406    741  270920
#> 1     DavisVaughan  62423   28392    288   90815
#> 63         lionel-  45315   20400    623   65715
#> 13     batpigandme  10469    7808     38   18277
#> 42          hannes   1364     153     16    1517
#> 100         zeehio    883     252      8    1135
#> 50         jennybc    876     145     11    1021

ggplot2 <- get_contributions("ggplot2", user = "tidyverse")
order_authors(ggplot2)
#> hadley, thomasp85, topepo, lionel-, wch, clauswilke, krlmlr, dpseidel, karawoo, teunbrand, kohske, paleolimbot, yutannihilation, mine-cetinkaya-rundel, jiho, hrbrmstr, JakeRuss, batpigandme
#>                  username  added deleted commit  score
#> 41                 hadley 344336  253389   2274 597725
#> 90              thomasp85 127149  118915    296 246064
#> 95                 topepo  97837  111710     10 209547
#> 64                lionel-  81805   44588     59 126393
#> 97                    wch  32728   35042    589  67770
#> 21             clauswilke  33090   28134    102  61224
#> 62                 krlmlr  27218   17516      7  44734
#> 33               dpseidel  17923   16615      7  34538
#> 56                karawoo  12246    8578     54  20824
#> 89              teunbrand  10333    5787    118  16120
#> 61                 kohske   6970    4065    194  11035
#> 79            paleolimbot   7579    2777     47  10356
#> 100       yutannihilation   5438    4161    157   9599
#> 72  mine-cetinkaya-rundel   2116      40      6   2156
#> 50                   jiho   1291     756     62   2047
#> 43               hrbrmstr   1057     651     14   1708
#> 6                JakeRuss   1325     374     19   1699
#> 15            batpigandme   1144     143     15   1287
```

## Troubleshooting

If you get the following error:

    Error in `resp_body_raw()`:
    ! Can not retrieve empty body

Please visit the GitHub page on a browser to manually update the data.
Once the new data is loaded, try again, it should work.
