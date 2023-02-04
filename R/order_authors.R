#' Order GitHub authors
#'
#' Order GitHub authors based on contributions (obtained from `get_contributions()`).
#'
#' @param data data
#' @param commit.weight A multiplication constant representing the weight the
#' number of commits should have (setting it to 0, the default, will make it
#' have no impact).
#' @param cutoff Cutoff score under which to exclude contributors from the
#' filtered list.
#' @return A data frame with username of contributor, number of added lines of code,
#' deleted lines of code, number of commits, and a total 'score' column
#' representing the sum of the other columns.
#'
#' @examples
#' x <- get_contributions("report")
#' order_authors(x)
#' @export

order_authors <- function(data, commit.weight = 0, cutoff = 1000) {
  data$score <- data$added + abs(data$deleted) + data$commit * commit.weight
  data <- data[order(data$score, decreasing = TRUE), ]
  data <- data[data$score >= cutoff, ]
  cat(toString(data$username), "\n\n")
  data
}
