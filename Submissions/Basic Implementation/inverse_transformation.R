library(kableExtra)

#' Kumaraswamy distribution simulation through inverse transformation
#' @param n sets the number of samples to be generated.
#' @param a sets the first parameter of the distribution.
#' @param b sets the other parameter of the distribution.
#' @return An nx1 matrix of the values to simulate the Kumaraswamy distribution.
#' @examples 
#' set.seed(1)
#' n <- 50000
#' a <- 0.5
#' b <- 0.5
#' xs <- is_kumaraswamy(n, a, b)
#' head(xs)
#' @importFrom runif
#' @export
is_kumaraswamy <- function(n, a, b) {
  u <- runif(n)
  x <- (1 - (1 - u)^(1/b))^(1/a)
  return(x)
}

#' Arcsine distribution simulation through inverse transformation
#' @param n sets the numbers of samples to be generated.
#' @return  An nx1 matrix of the values to simulate the arcsine distribution.
#' @examples 
#' set.seed(1)
#' n <- 50000
#' xs <- is_arcsine(n)
#' head(xs)
#' @importFrom runif
#' @export
is_arcsine <- function(n) {
  u <- runif(n)
  x <- sin(pi * u / 2)^2
  return(x)
}

#' Create a histogram with the inputted values
#' @description Create a histogram with an optional line to represent the theoretical pdf of the Kumaraswamy distribution or the arcsine distribution.
#' @param xs a vector of simulated values.
#' @param draw_lines draws a line to represent the pdf of the chosen distribution, TRUE by default.
#' @param dist optional - sets the distribution being simulated to generate its actual pdf, accepts "kumaraswamy" and "arcsine".
#' @param a optional - sets the first parameter of the Kumaraswamy distribution.
#' @param b optional - sets the other parameter of the Kumaraswamy distribution.
#' @param plot_color sets the color of the bars of the histogram.
#' @param plot_border sets the color of the borders of the bars.
#' @param line_color sets the color of the pdf line.
#' @param line_width sets the width of the line.
#' @examples 
#' set.seed(1)
#' n <- 50000
#' a <- 0.5
#' b <- 0.5
#' xs <- is_kumaraswamy(n, a, b)
#' draw_histogram(xs, dist="kumaraswamy", a=a, b=b)
#' @export
draw_histogram <- function(xs, draw_lines=TRUE, dist, a=0, b=0, 
               plot_color="skyblue", plot_border="white",
               line_color="red", line_width=2){
  #draws the histogram of values taken from the dataset
  hist(xs, prob = TRUE, col = plot_color, border = plot_border)
  #draws the pdf line of the distribution (if enabled)
  if (draw_lines) {
    if (dist == "kumaraswamy"){
      y <- seq(0.001, 0.999, length.out = 1000)
      lines(y, a*b*y^(a-1)*(1-y^a)^(b-1), col = line_color, lwd = line_width)
    } else if (dist == "arcsine"){
      lines(y, 1/(pi*sqrt(y*(1-y))), col = line_color, lwd = line_width)
    }
  }
}

#' Helper function generating moments of the Kumaraswamy distribution
#' @param n sets the nth moment of the distribution.
#' @param a sets the first parameter of the distribution.
#' @param b sets the other parameter of the distribution.
#' @return the nth moment of Kumaraswamy(a, b)
#' @export
kumaraswamy_moment <- function(n, a, b){
  return(b*beta(1+n/a, b))
}

#' Draw a table of statistics for comparison
#' @description Create a table comparing the simulated statistics with the theoretical statistics.
#' @param xs a vector of simulated values.
#' @param dist sets the distribution being simulated to generate its theoretical values, accepts "kumaraswamy" and "arcsine".
#' @param a optional - sets the first parameter of the Kumaraswamy distribution.
#' @param b optional - sets the other parameter of the Kumaraswamy distribution.
#' @examples
#' set.seed(1)
#' n <- 50000
#' a <- 0.5
#' b <- 0.5
#' xs <- is_kumaraswamy(n, a, b)
#' draw_table(xs, "kumaraswamy", a, b)
#' @importFrom kableExtra
#' @export
draw_table <- function(xs, dist, a=0, b=0){
  if (dist == "kumaraswamy"){
    theoretical_stats <- c(kumaraswamy_moment(1, a, b), 
                           kumaraswamy_moment(2, a, b) - 
                             kumaraswamy_moment(1, a, b)^2)
  }
  else if (dist == "arcsine"){
    theoretical_stats <- c(1/2, 1/8)
  }
  dt <- data.frame(Simulated=c(mean(xs), sd(xs)^2),
                   Theoretical=theoretical_stats,
                   row.names = c("Mean", "Variance"))
  dt %>%
    kbl() %>%
    kable_material(c("striped", "hover"))
}


