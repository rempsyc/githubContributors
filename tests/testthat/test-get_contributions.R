test_that("get_contributions + order_authors", {
  x <- get_contributions("report")
  expect_s3_class(x, "data.frame")
  expect_s3_class(order_authors(x), "data.frame")
})

test_that("get_contributions supports multiple packages", {
  x <- get_contributions(c("report", "insight"))
  expect_type(x, "list")
  expect_length(x, 2)
  expect_named(x, c("report", "insight"))
  expect_s3_class(x$report, "data.frame")
  expect_s3_class(x$insight, "data.frame")
})

test_that("order_authors supports list from multiple packages", {
  x <- get_contributions(c("report", "insight"))
  y <- order_authors(x)
  expect_type(y, "list")
  expect_length(y, 2)
  expect_named(y, c("report", "insight"))
  expect_s3_class(y$report, "data.frame")
  expect_s3_class(y$insight, "data.frame")
  expect_true("score" %in% names(y$report))
  expect_true("score" %in% names(y$insight))
})
