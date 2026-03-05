library("testthat")
# library("extraDistr")
# library("VaRES")

set.seed(1)


#########################################
# Kumaraswamy Inverse Transform Example #
#########################################

# setting parameters
n <- 10000
a <- 0.5
b <- 0.5

# generate random numbers in target distribution
actual_k <- is_kumaraswamy(n, a, b)

# Calculate theoretical kumaraswamy distribution
k_cdf <- function(x, a, b) {
  return(1 - (1 - x^a)^b)
}

k_mean <- function(a, b) {
  return(b * gamma(1 + 1 / a) * gamma(b) / gamma(1 + 1 / a + b))
}

# testing
test_that("Simulated data matches kumaraswamy distribution properties", {
  # Check equal cumulative density function
  q = c(0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0)
  emp_cdf <- sapply(q, function(qq) mean(actual_k < qq))
  theo_cdf <- k_cdf(q, a, b)
  expect_equal(emp_cdf, theo_cdf, tolerance = 0.05)
  
  # Check equal mean
  theo_mean <- k_mean(a, b)
  expect_equal(mean(actual_k), theo_mean, tolerance = 0.05)
})


#########################################
# Arcsine Inverse Transform Example     #
#########################################


# setting parameters
n <- 50000

# generate random numbers in target distribution
actual_a <- is_arcsine(n)

# Calculate theoretical arcsine distribution
a_cdf <- function(x) {
  return((2/pi) * asin(sqrt(x)))
}

a_mean <- function() {
  return(1/2)
}

# testing
test_that("Simulated data matches arcsine distribution properties", {
  # Check equal cumulative density function
  q = c(0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0)
  emp_cdf <- sapply(q, function(qq) mean(actual_a < qq))
  theo_cdf <- a_cdf(q)
  expect_equal(emp_cdf, theo_cdf, tolerance = 0.05)
  
  # Check equal mean
  theo_mean <- a_mean()
  expect_equal(mean(actual_a), theo_mean, tolerance = 0.05)
})

