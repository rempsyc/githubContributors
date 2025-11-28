
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
#> DominiqueMakowski, strengejacke, rempsyc, IndrajeetPatil,
#>   apps/copilot-swe-agent, apps/copilot-pull-request-reviewer, mattansb,
#>   bwiernik
#>                              username  added deleted commit  score
#> 1                   DominiqueMakowski 204185  148413    328 352598
#> 26                       strengejacke   7978   38980    267  46958
#> 25                            rempsyc  20427   10215    127  30642
#> 2                      IndrajeetPatil  15387   10883    192  26270
#> 7              apps/copilot-swe-agent   6011    1958     35   7969
#> 6  apps/copilot-pull-request-reviewer   2561     956      1   3517
#> 22                           mattansb   1350     892     22   2242
#> 10                           bwiernik   1793     241     15   2034

datawizard <- get_contributions("datawizard", user = "easystats")
order_authors(datawizard)
#> IndrajeetPatil, strengejacke, etiennebacher, bwiernik,
#>   DominiqueMakowski, mattansb, rempsyc
#>            username added deleted commit score
#> 2    IndrajeetPatil 49356   32684    376 82040
#> 9      strengejacke 56957   19010    659 75967
#> 6     etiennebacher 42394   20143    258 62537
#> 5          bwiernik  4337    2114     14  6451
#> 1 DominiqueMakowski  3136     748     28  3884
#> 7          mattansb  1796     471     32  2267
#> 8           rempsyc  1659     150      6  1809

performance <- get_contributions("performance", user = "easystats")
order_authors(performance)
#> strengejacke, DominiqueMakowski, IndrajeetPatil, rempsyc, mattansb,
#>   bwiernik, etiennebacher, mccarthy-m-g
#>             username added deleted commit  score
#> 23      strengejacke 94873   72847   1732 167720
#> 3  DominiqueMakowski 56459   30116    146  86575
#> 4     IndrajeetPatil 22009   11784    213  33793
#> 22           rempsyc 14987    9062     33  24049
#> 17          mattansb  9227    3060     73  12287
#> 11          bwiernik  7516    2595     43  10111
#> 13     etiennebacher  1583    1372      9   2955
#> 19      mccarthy-m-g  1623     166      1   1789

dplyr <- get_contributions("dplyr", user = "tidyverse")
order_authors(dplyr)
#> romainfrancois, hadley, krlmlr, DavisVaughan, lionel-, batpigandme,
#>   gaborcsardi, zeehio, jennybc
#>           username  added deleted commit   score
#> 84  romainfrancois 895054  901061   2737 1796115
#> 42          hadley 198740  216821   1988  415561
#> 60          krlmlr 166960  117581    757  284541
#> 1     DavisVaughan 113255   71019    420  184274
#> 64         lionel-  45341   20422    624   65763
#> 14     batpigandme  10469    7808     38   18277
#> 40     gaborcsardi   2412    2424      2    4836
#> 100         zeehio    883     252      8    1135
#> 50         jennybc    877     146     12    1023

ggplot2 <- get_contributions("ggplot2", user = "tidyverse")
order_authors(ggplot2)
#> hadley, thomasp85, teunbrand, topepo, lionel-, wch, clauswilke, krlmlr,
#>   dpseidel, karawoo, yutannihilation, kohske, paleolimbot, yjunechoe,
#>   mine-cetinkaya-rundel, jiho, hrbrmstr, JakeRuss, batpigandme, olivroy
#>                 username  added deleted commit  score
#> 41                hadley 344358  253391   2276 597749
#> 89             thomasp85 294963  233862    354 528825
#> 88             teunbrand 179957  121987    593 301944
#> 94                topepo  98079  111710     11 209789
#> 62               lionel-  81805   44588     59 126393
#> 96                   wch  32728   35042    589  67770
#> 25            clauswilke  33090   28134    102  61224
#> 61                krlmlr  27218   17516      7  44734
#> 33              dpseidel  17923   16615      7  34538
#> 56               karawoo  12246    8578     54  20824
#> 99       yutannihilation   8970    6258    173  15228
#> 60                kohske   6970    4065    194  11035
#> 77           paleolimbot   7579    2777     47  10356
#> 98             yjunechoe   2456    3102      4   5558
#> 70 mine-cetinkaya-rundel   2324      40      7   2364
#> 50                  jiho   1291     756     62   2047
#> 43              hrbrmstr   1057     651     14   1708
#> 5               JakeRuss   1325     374     19   1699
#> 19           batpigandme   1144     143     15   1287
#> 75               olivroy    518     491      9   1009
```

## Troubleshooting

If you get an error, please visit the GitHub page on a browser to
manually update the data. Once the new data is loaded, try again, it
should work.

## Credits

Most of the code for this package was contributed by [StackOverFlow user
Chamkrai](https://stackoverflow.com/questions/75277192/how-can-i-web-scrape-github-project-contributor-information-in-r/75277425#75277425).
