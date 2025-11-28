#' Order GitHub authors
#'
#' Order GitHub authors based on contributions (obtained from `get_contributions()`).
#'
#' @param data A data frame or a named list of data frames (as returned by
#'   `get_contributions()` when multiple repositories are provided).
#' @param commit.weight A multiplication constant representing the weight the
#' number of commits should have (setting it to 0, the default, will make it
#' have no impact).
#' @param cutoff Cutoff score under which to exclude contributors from the
#' filtered list.
#' @return When a single data frame is provided, a data frame with username of
#'   contributor, number of added lines of code, deleted lines of code, number
#'   of commits, and a total 'score' column representing the sum of the other
#'   columns. When a list of data frames is provided, a named list of data
#'   frames with the same structure.
#'
#' @examples
#' x <- get_contributions("report")
#' order_authors(x)
#' @export

order_authors <- function(data, commit.weight = 0, cutoff = 1000) {
  required_cols <- c("added", "deleted", "commit", "username")

  if (is.list(data) && !is.data.frame(data)) {
    # Input validation for list
    if (length(data) == 0) {
      stop(
        "'data' is an empty list. Please provide at least one data frame.",
        call. = FALSE
      )
    }
    if (!all(vapply(data, is.data.frame, logical(1)))) {
      stop("All elements of 'data' must be data frames.", call. = FALSE)
    }
    for (i in seq_along(data)) {
      missing_cols <- setdiff(required_cols, names(data[[i]]))
      if (length(missing_cols) > 0) {
        elem_name <- if (!is.null(names(data)[i])) {
          names(data)[i]
        } else {
          as.character(i)
        }
        stop(
          sprintf(
            "Data frame '%s' is missing required columns: %s",
            elem_name,
            paste(missing_cols, collapse = ", ")
          ),
          call. = FALSE
        )
      }
    }
    results <- lapply(data, function(d) {
      order_authors_single(d, commit.weight, cutoff)
    })
    names(results) <- names(data)
    return(results)
  }

  # Input validation for single data frame
  if (!is.data.frame(data)) {
    stop("'data' must be a data frame or a list of data frames.", call. = FALSE)
  }
  missing_cols <- setdiff(required_cols, names(data))
  if (length(missing_cols) > 0) {
    stop(
      sprintf(
        "'data' is missing required columns: %s",
        paste(missing_cols, collapse = ", ")
      ),
      call. = FALSE
    )
  }

  order_authors_single(data, commit.weight, cutoff)
}

#' Order authors for a single data frame (internal helper)
#' @noRd
order_authors_single <- function(data, commit.weight, cutoff) {
  data$score <- data$added + abs(data$deleted) + data$commit * commit.weight
  data <- data[order(data$score, decreasing = TRUE), ]
  data <- data[data$score >= cutoff, ]
  cat(insight::format_message(toString(data$username)), "\n\n")
  data
}
