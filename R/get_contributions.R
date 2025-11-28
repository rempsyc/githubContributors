#' Get GitHub contributions
#'
#' Get GitHub contributions, which can then be ordered with `order_authors()`.
#'
#' @param repo A character vector of one or more repository names. When multiple
#'   repositories are provided (e.g., `c("report", "insight")`), the function
#'   returns a named list of data frames.
#' @param user username
#' @return When a single repository is provided, a data frame with username of
#'   contributor, number of added lines of code, deleted lines of code, and
#'   number of commits. When multiple repositories are provided, a named list
#'   of data frames, one for each repository.
#' @source https://stackoverflow.com/a/75277425/9370662
#'
#' @examples
#' head(get_contributions("report"))
#' @export

get_contributions <- function(repo, user = "easystats") {
  # Input validation
  if (length(repo) == 0) {
    stop("'repo' must contain at least one repository name.", call. = FALSE)
  }

  if (any(is.na(repo))) {
    stop(
      "'repo' contains NA values. Please provide valid repository names.",
      call. = FALSE
    )
  }
  if (any(repo == "")) {
    stop(
      "'repo' contains empty strings. Please provide valid repository names.",
      call. = FALSE
    )
  }

  if (length(repo) > 1) {
    results <- lapply(repo, function(r) get_contributions_single(r, user))
    names(results) <- repo
    return(results)
  }

  get_contributions_single(repo, user)
}

#' Get contributions for a single repository (internal helper)
#' @noRd
get_contributions_single <- function(repo, user) {
  path <- NULL
  contributors_url <- paste0(
    "https://github.com/",
    user,
    "/",
    repo,
    "/graphs/contributors"
  )

  resp <- paste0(contributors_url, "-data") |>
    httr2::request() |>
    httr2::req_headers(
      "x-requested-with" = "XMLHttpRequest",
      accept = "appliacation/json"
    ) |>
    httr2::req_perform()

  manual_attempt <- paste(
    "Please visit the following URL in ",
    "your browser to manually trigger a data refresh:\n\n  ",
    contributors_url,
    "\n\nOnce the page finishes loading, run this function again."
  )

  # helper defined earlier (from previous message)
  # refresh_with_chromote <- function(contributors_url) ...

  refreshed <- FALSE

  body <- tryCatch(
    httr2::resp_body_json(resp, simplifyVector = TRUE, check_type = FALSE),
    error = function(e) {
      if (!grepl("empty body", e$message, ignore.case = TRUE)) {
        stop(e, call. = FALSE)
      }
      message(
        "GitHub returned an empty response. Attempting automatic refresh using chromote..."
      )
      refreshed <<- tryCatch(
        refresh_with_chromote(contributors_url),
        error = function(chromote_error) {
          message("Chromote failed: ", chromote_error$message)
          FALSE
        }
      )
      # signal to caller: "I tried to refresh"
      NULL
    }
  )

  # If body is NULL *and* we actually attempted a refresh, retry once
  if (is.null(body) && refreshed) {
    message("Retrying GitHub request after automatic refresh...")
    Sys.sleep(5)
    resp <- paste0(contributors_url, "-data") |>
      httr2::request() |>
      httr2::req_headers(
        "x-requested-with" = "XMLHttpRequest",
        accept = "application/json"
      ) |>
      httr2::req_perform()

    body <- tryCatch(
      httr2::resp_body_json(resp, simplifyVector = TRUE, check_type = FALSE),
      error = function(e) {
        stop(
          "GitHub returned an empty response even after automatic refresh. ",
          "Please visit the following URL in your browser to manually trigger a data refresh:\n\n  ",
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

refresh_with_chromote <- function(
  url,
  idle_timeout = 5,
  poll_every = 0.1,
  extra_wait = 1
) {
  b <- chromote::ChromoteSession$new()
  on.exit(try(b$close(), silent = TRUE), add = TRUE)
  b$Network$enable()
  b$Page$navigate(url)
  b$Page$loadEventFired()
  idle <- FALSE
  b$Network$loadingFinished(function(...) idle <<- TRUE)
  t0 <- Sys.time()
  while (!idle && as.numeric(Sys.time() - t0) < idle_timeout) {
    Sys.sleep(poll_every)
  }
  Sys.sleep(extra_wait)
  message("Refresh triggered. Please wait a minute and try again.")
  invisible(TRUE)
}
