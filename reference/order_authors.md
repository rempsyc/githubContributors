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
#> Error in resp_body_raw(resp): Can't retrieve empty body.
order_authors(x)
#> Error: object 'x' not found
```
