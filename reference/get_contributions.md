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
#> Error in resp_body_raw(resp): Can't retrieve empty body.
```
