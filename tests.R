library("testthat")
library("extraDistr")

set.seed(1)


#########################################
# Kumaraswamy Inverse Transform Example #
#########################################
n <- 10000
a <- 0.5
b <- 0.5

actual <- is_kumaraswamy(n, a, b)
expected <- rkumar(n, a, b)

test_that("Simulated data matches target distribution properties" {
  # Check equal probability density function
  expect_equal()
  
  # Check equal means
  expect_equal(mean(actual), mean(expected), tolerance = 0.05)

  # Check equal standard deviations
  expect_equal(sd(actual), sd(expected), tolerance = 0.05)
})


#########################################
# Arcsine Inverse Transform Example     #
#########################################


