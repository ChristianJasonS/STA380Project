library(kableExtra)

#' Kumaraswamy distribution simulation through inverse transformation
#' @param n sets the number of samples to be generated
#' @param a sets one of the parameters of the distribution
#' @param b sets the other parameter of the distribution
#' @return An nx1 matrix of the values to simulate the Kumaraswamy distribution
#' @examples 
#' set.seed(1)
#' n <- 50000
#' a <- 0.5
#' b <- 0.5
#' xs <- is_kumaraswamy(n, a, b)
#' @importFrom runif
#' @export
is_kumaraswamy <- function(n, a, b) {
  u <- runif(n)
  x <- (1 - (1 - u)^(1/b))^(1/a)
  return(x)
}

#' Arcsine distribution simulation through inverse transformation
#' @param n sets the numbers of samples to be generated
#' @return  An nx1 matrix of the values to simulate the arcsine distribution
#' @examples 
#' set.seed(1)
#' n <- 50000
#' xs <- is_arcsine(n)
#' @importFrom runif
#' @export
is_arcsine <- function(n) {
  u <- runif(n)
  x <- sin(pi * u / 2)^2
  return(x)
}

draw_histogram <- function(xs, dist, a=0, b=0, 
               plot_color="skyblue", plot_border="white",
               line_color="red", line_width=2, draw_lines=TRUE){
  #draws the histogram of values taken from the dataset
  hist(xs, prob = TRUE, col = plot_color, border = plot_border)
  #draws the pdf line of the distribution (if enabled)
  if (draw_lines) {
    if (dist == "kumaraswamy"){
      lines(y, a*b*y^(a-1)*(1-y^a)^(b-1), col = line_color, lwd = line_width)
    } else if (dist == "arcsine"){
      lines(y, 1/(pi*sqrt(y*(1-y))), col = line_color, lwd = line_width)
    }
  }
}

kumaraswamy_moment <- function(n, a, b){
  return(b*beta(1+n/a, b))
}

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
