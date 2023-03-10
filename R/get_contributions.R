#' Get GitHub contributions
#'
#' Get GitHub contributions, which can then be ordered with `order_authors()`.
#'
#' @param repo repository
#' @param user username
#' @return A data frame with username of contributor, number of added lines of code,
#' deleted lines of code, and number of commits.
#' @source https://stackoverflow.com/a/75277425/9370662
#'
#' @examples
#' head(get_contributions("report"))
#' @export

get_contributions <- function(repo, user = "easystats") {
  path <- NULL
  paste0("https://github.com/", user, "/", repo, "/graphs/contributors-data") |>
    httr2::request() |>
    httr2::req_headers("x-requested-with" = "XMLHttpRequest",
                       accept = "appliacation/json") |>
    httr2::req_perform() |>
    httr2::resp_body_json(simplifyVector = TRUE, check_type = FALSE) |>
    tidyr::unnest(dplyr::everything()) |>
    dplyr::group_by(username = stringr::str_remove(path, "/")) |>
    dplyr::summarise(dplyr::across("a":"c", sum)) |>
    dplyr::arrange(dplyr::desc("a"), dplyr::desc("d"), dplyr::desc("c")) |>
    dplyr::rename(added = "a", deleted = "d", commit = "c") |>
    as.data.frame()
}
