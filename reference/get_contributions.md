# Get GitHub contributions

Get GitHub contributions, which can then be ordered with
[`order_authors()`](https://rempsyc.github.io/githubContributors/reference/order_authors.md).

## Usage

``` r
get_contributions(repo, user = "easystats")
```

## Source

https://stackoverflow.com/a/75277425/9370662

## Arguments

- repo:

  repository

- user:

  username

## Value

A data frame with username of contributor, number of added lines of
code, deleted lines of code, and number of commits.

## Examples

``` r
head(get_contributions("report"))
#>                             username  added deleted commit
#> 1                  DominiqueMakowski 204185  148413    328
#> 2                     IndrajeetPatil  15387   10883    192
#> 3                      LukasWallrich      1       1      1
#> 4                           M-Colley      3       3      1
#> 5                         Olexandr88      1       1      1
#> 6 apps/copilot-pull-request-reviewer   2561     956      1
```
