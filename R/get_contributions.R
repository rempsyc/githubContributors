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
  contributors_url <- paste0(
    "https://github.com/",
    user,
    "/",
    repo,
    "/graphs/contributors"
  )

  manual_attempt <- paste0(
    "Please visit the following URL in your browser to manually trigger a data refresh:\n\n  ",
    contributors_url,
    "\n\nOnce the page finishes loading, run this function again."
  )

  # First attempt: direct JSON
  resp <- paste0(contributors_url, "-data") |>
    httr2::request() |>
    httr2::req_headers(
      "x-requested-with" = "XMLHttpRequest",
      accept = "application/json"
    ) |>
    httr2::req_perform()

  refreshed <- FALSE

  body <- tryCatch(
    httr2::resp_body_json(resp, simplifyVector = TRUE, check_type = FALSE),
    error = function(e) {
      if (!grepl("empty body", e$message, ignore.case = TRUE)) {
        stop(e, call. = FALSE)
      }

      message(
        "GitHub returned an empty response. Attempting automatic refresh using Chromote..."
      )

      refreshed <<- tryCatch(
        refresh_with_chromote(contributors_url),
        error = function(chromote_error) {
          message("Chromote failed: ", chromote_error$message)
          FALSE
        }
      )

      # Signal to caller: "no JSON yet"
      NULL
    }
  )

  # If body is NULL *and* refresh was attempted, retry once after a short delay
  if (is.null(body) && isTRUE(refreshed)) {
    message(
      "Retrying GitHub contributors-data request after automatic refresh..."
    )
    Sys.sleep(5) # give GitHub some time to regenerate the JSON endpoint

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
          "GitHub returned an empty response even after automatic refresh.\n\n",
          manual_attempt,
          call. = FALSE
        )
      }
    )
  }

  # If still NULL and we didn’t refresh (e.g., chromote not installed), fail nicely
  if (is.null(body)) {
    stop(
      "GitHub returned an empty response and automatic refresh was not possible.\n\n",
      manual_attempt,
      call. = FALSE
    )
  }

  body |>
    tidyr::unnest(dplyr::everything()) |>
    dplyr::group_by(username = stringr::str_remove(path, "/")) |>
    dplyr::summarise(dplyr::across("a":"c", sum), .groups = "drop") |>
    dplyr::arrange(
      dplyr::desc(.data$a),
      dplyr::desc(.data$d),
      dplyr::desc(.data$c)
    ) |>
    dplyr::rename(added = "a", deleted = "d", commit = "c") |>
    as.data.frame()
}


refresh_with_chromote <- function(url, max_wait = 15, check_every = 0.3) {
  if (!requireNamespace("chromote", quietly = TRUE)) {
    message("chromote is not installed; cannot auto-refresh via browser.")
    return(FALSE)
  }

  b <- chromote::ChromoteSession$new()
  on.exit(try(b$close(), silent = TRUE), add = TRUE)

  b$Page$navigate(url)
  b$Page$loadEventFired()

  # Wait until the page height stops changing (handles long contributor pages)
  message(
    "Waiting for GitHub contributors page to finish loading in Chromote..."
  )
  last_h <- -1
  stable <- 0
  t0 <- Sys.time()

  repeat {
    h <- try(
      b$Runtime$evaluate("document.body.scrollHeight")$result$value,
      silent = TRUE
    )

    if (inherits(h, "try-error")) {
      # if the session dies unexpectedly, bail out
      break
    }

    if (is.numeric(h) && h == last_h) {
      stable <- stable + 1
    } else {
      stable <- 0
      last_h <- h
    }

    # 5 consecutive stable checks ≈ "page finished expanding"
    if (stable >= 5) {
      break
    }
    if (as.numeric(Sys.time() - t0, units = "secs") > max_wait) {
      break
    }

    Sys.sleep(check_every)
  }

  message("Refresh triggered via Chromote; GitHub page appears fully loaded.")
  TRUE
}
