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
  contributors_url <- paste0("https://github.com/", user, "/", repo, "/graphs/contributors")

  resp <- paste0(contributors_url, "-data") |>
    httr2::request() |>
    httr2::req_headers("x-requested-with" = "XMLHttpRequest",
                       accept = "appliacation/json") |>
    httr2::req_perform()

  body <- tryCatch(
    httr2::resp_body_json(resp, simplifyVector = TRUE, check_type = FALSE),
    error = function(e) {
      if (grepl("empty body", e$message, ignore.case = TRUE)) {
        # Try to trigger refresh using chromote if available
        if (requireNamespace("chromote", quietly = TRUE)) {
          message("GitHub returned an empty response. Attempting automatic refresh using chromote...")
          b <- NULL
          tryCatch({
            b <- chromote::ChromoteSession$new()
            b$Page$navigate(contributors_url)
            b$Page$loadEventFired()
            Sys.sleep(5)  
            message("Refresh triggered. Retrying request...")
            return(NULL)  
          }, error = function(chromote_error) {
            message("Chromote failed: ", chromote_error$message)
          }, finally = {
            if (!is.null(b)) {
              tryCatch(b$close(), error = function(e) NULL)
            }
          })
        }
        stop(
          "GitHub returned an empty response. Please visit the following URL in ",
          "your browser to manually trigger a data refresh:\n\n  ",
          contributors_url,
          "\n\nOnce the page finishes loading, run this function again.",
          call. = FALSE
        )
      } else {
        stop(e)
      }
    }
  )

  # If body is NULL (chromote triggered refresh), retry the request
  if (is.null(body)) {
    resp <- paste0(contributors_url, "-data") |>
      httr2::request() |>
      httr2::req_headers("x-requested-with" = "XMLHttpRequest",
                         accept = "appliacation/json") |>
      httr2::req_perform()

    body <- tryCatch(
      httr2::resp_body_json(resp, simplifyVector = TRUE, check_type = FALSE),
      error = function(e) {
        stop(
          "GitHub returned an empty response. Please visit the following URL in ",
          "your browser to manually trigger a data refresh:\n\n  ",
          contributors_url,
          "\n\nOnce the page finishes loading, run this function again.",
          call. = FALSE
        )
      }
    )
  }

  body |>
    tidyr::unnest(dplyr::everything()) |>
    dplyr::group_by(username = stringr::str_remove(path, "/")) |>
    dplyr::summarise(dplyr::across("a":"c", sum)) |>
    dplyr::arrange(dplyr::desc("a"), dplyr::desc("d"), dplyr::desc("c")) |>
    dplyr::rename(added = "a", deleted = "d", commit = "c") |>
    as.data.frame()
}
