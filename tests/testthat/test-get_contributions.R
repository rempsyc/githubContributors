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
