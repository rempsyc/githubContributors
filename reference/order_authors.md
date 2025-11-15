# Order GitHub authors

Order GitHub authors based on contributions (obtained from
[`get_contributions()`](https://rempsyc.github.io/githubContributors/reference/get_contributions.md)).

## Usage

``` r
order_authors(data, commit.weight = 0, cutoff = 1000)
```

## Arguments

- data:

  data

- commit.weight:

  A multiplication constant representing the weight the number of
  commits should have (setting it to 0, the default, will make it have
  no impact).

- cutoff:

  Cutoff score under which to exclude contributors from the filtered
  list.

## Value

A data frame with username of contributor, number of added lines of
code, deleted lines of code, number of commits, and a total 'score'
column representing the sum of the other columns.

## Examples

``` r
x <- get_contributions("report")
order_authors(x)
#> DominiqueMakowski, strengejacke, rempsyc, IndrajeetPatil, apps/copilot-swe-agent, apps/copilot-pull-request-reviewer, mattansb, bwiernik 
#> 
#>                              username  added deleted commit  score
#> 1                   DominiqueMakowski 204185  148413    328 352598
#> 26                       strengejacke   7978   38980    267  46958
#> 25                            rempsyc  20427   10215    127  30642
#> 2                      IndrajeetPatil  15387   10883    192  26270
#> 7              apps/copilot-swe-agent   6011    1958     35   7969
#> 6  apps/copilot-pull-request-reviewer   2561     956      1   3517
#> 22                           mattansb   1350     892     22   2242
#> 10                           bwiernik   1793     241     15   2034
```
