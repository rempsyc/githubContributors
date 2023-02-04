test_that("get_contributions + order_authors", {
  x <- get_contributions("report")
  expect_s3_class(x, "data.frame")
  expect_s3_class(order_authors(x), "data.frame")
})
