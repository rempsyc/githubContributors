
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
#> DominiqueMakowski, strengejacke, IndrajeetPatil, rempsyc, mattansb, bwiernik
#>             username  added deleted commit  score
#> 3  DominiqueMakowski 203778  148154    325 351932
#> 18      strengejacke   5129   38164    223  43293
#> 10    IndrajeetPatil  15082   10513    159  25595
#> 17           rempsyc   3926    3355     15   7281
#> 14          mattansb   1009     603     14   1612
#> 1           bwiernik   1371     156     11   1527

datawizard <- get_contributions("datawizard", user = "easystats")
order_authors(datawizard)
#> IndrajeetPatil, strengejacke, etiennebacher, bwiernik, DominiqueMakowski, rempsyc, mattansb
#>            username added deleted commit score
#> 4    IndrajeetPatil 44763   28771    318 73534
#> 7      strengejacke 30293    9818    460 40111
#> 3     etiennebacher 13463    4925    136 18388
#> 1          bwiernik  4276    2072     11  6348
#> 2 DominiqueMakowski  3108     733     26  3841
#> 6           rempsyc  1657     149      5  1806
#> 5          mattansb  1331     329     16  1660

performance <- get_contributions("performance", user = "easystats")
order_authors(performance)
#> strengejacke, DominiqueMakowski, IndrajeetPatil, mattansb, rempsyc, bwiernik
#>             username added deleted commit  score
#> 15      strengejacke 59298   57470   1392 116768
#> 4  DominiqueMakowski 43718   23001    138  66719
#> 6     IndrajeetPatil 12893    7481    146  20374
#> 9           mattansb  1481     355     57   1836
#> 14           rempsyc  1357     414     13   1771
#> 2           bwiernik  1127     476     40   1603

performance <- get_contributions("lavaan", user = "yrosseel")
order_authors(performance)
#> yrosseel, TDJorgensen
#>       username  added deleted commit  score
#> 14    yrosseel 200833  116423   1591 317256
#> 13 TDJorgensen   1574     691     58   2265

performance <- get_contributions("dplyr", user = "tidyverse")
order_authors(performance)
#> romainfrancois, hadley, krlmlr, lionel-, DavisVaughan, batpigandme, hannes, zeehio, jennybc
#>           username  added deleted commit   score
#> 80  romainfrancois 895054  901061   2737 1796115
#> 37          hadley 198496  216481   1981  414977
#> 56          krlmlr 163389  107396    737  270785
#> 59         lionel-  45315   20400    623   65715
#> 24    DavisVaughan  42291   13859    213   56150
#> 8      batpigandme  10467    7808     37   18275
#> 38          hannes   1364     153     16    1517
#> 100         zeehio    883     252      8    1135
#> 46         jennybc    876     145     11    1021

performance <- get_contributions("ggplot2", user = "tidyverse")
order_authors(performance)
#> hadley, topepo, thomasp85, lionel-, wch, clauswilke, krlmlr, dpseidel, karawoo, kohske, paleolimbot, yutannihilation, teunbrand, mine-cetinkaya-rundel, jiho, hrbrmstr, JakeRuss
#>                  username  added deleted commit  score
#> 36                 hadley 344336  253389   2274 597725
#> 95                 topepo  97837  111710     10 209547
#> 90              thomasp85  88531   79349    287 167880
#> 62                lionel-  81805   44588     59 126393
#> 97                    wch  32728   35042    589  67770
#> 16             clauswilke  33090   28134    102  61224
#> 60                 krlmlr  27218   17516      7  44734
#> 28               dpseidel  17923   16615      7  34538
#> 53                karawoo  12246    8578     54  20824
#> 59                 kohske   6970    4065    194  11035
#> 79            paleolimbot   7579    2777     47  10356
#> 100       yutannihilation   5437    4158    154   9595
#> 89              teunbrand   2156    1236     66   3392
#> 72  mine-cetinkaya-rundel   2116      40      6   2156
#> 46                   jiho   1291     756     62   2047
#> 38               hrbrmstr   1057     651     14   1708
#> 41               JakeRuss   1325     374     19   1699
```

## Troubleshooting

If you get the following error:

    Error in `resp_body_raw()`:
    ! Can not retrieve empty body

Please visit the GitHub page on a browser to manually update the data.
Once the new data is loaded, try again, it should work.
