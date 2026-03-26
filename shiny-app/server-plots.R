output$plots <- renderPlot({
  source("R/inverseTransformation.R")
  
  set.seed(input$seed)
  n = input$n_samples
  dist = input$dist_type
  
  if (dist == "kumaraswamy"){
    a = input$param_a
    b = input$param_b
    xs = is_kumaraswamy(n, a, b)
  }
  else if (dist == "arcsine"){
    a = 0
    b = 0
    xs = is_arcsine(n)
  }
  
  
  if (input$graph_type == "hist"){
    draw_histogram(xs = xs, dist = dist, a = a, b = b, 
                   plot_color = input$plot_colour, plot_border = input$border_colour,
                   line_color = input$line_colour)
  }
})

output$table <- renderUI({
  source("R/inverseTransformation.R")
  
  set.seed(input$seed)
  n = input$n_samples
  dist = input$dist_type
  
  if (dist == "kumaraswamy"){
    a = input$param_a
    b = input$param_b
    xs = is_kumaraswamy(n, a, b)
  }
  else if (dist == "arcsine"){
    a = 0
    b = 0
    xs = is_arcsine(n)
  }
  
  if (input$graph_type == "table"){
    HTML(
      draw_table(xs = xs, dist = dist, a = a, b = b)
    )
  }
})


# mu_list = reactive({create_necessary_vector(input$mean_vector)})
# sigma_list = reactive({create_necessary_vector(input$sd_vector)})
# 
# global_seed <- reactive(input$example_seed)
# 
# indmh_comp <- reactive({
#   set.seed(global_seed())
#   sigma_matrix <- matrix(c(sigma_list()[1], input$rho,
#                            input$rho, sigma_list()[2]), nrow = 2, ncol = 2)
#   test_pt1 <- rmvnorm(n = 1, mean = mu_list(), sigma = sigma_matrix)
#   
#   rbivariate.mh_ind(N = input$sample_size,
#                     burn = 100,
#                     Y0 = test_pt1,
#                     sigma_matrix = sigma_matrix,
#                     mu_vec = mu_list())
# })
# 
# rwmh_comp <- reactive({
#   set.seed(global_seed())
#   sigma_matrix <- matrix(c(sigma_list()[1], input$rho,
#                            input$rho, sigma_list()[2]), nrow = 2, ncol = 2)
#   test_pt2 <- rmvnorm(n = 1, mean = mu_list(), sigma = sigma_matrix)
#   
#   rbivariate.rwmh(N = input$sample_size,
#                   burn = 100,
#                   Y0 = test_pt2,
#                   sigma_matrix = sigma_matrix,
#                   mu_vec = mu_list())
# })
# 
# gibbs_comp <- reactive({
#   set.seed(global_seed())
#   sigma_matrix <- matrix(c(sigma_list()[1], input$rho,
#                            input$rho, sigma_list()[2]), nrow = 2, ncol = 2)
#   test_pt3 <- rmvnorm(n = 1, mean = mu_list(), sigma = sigma_matrix)
#   
#   gibbs_sampler(N = input$sample_size,
#                 burn = 100,
#                 Y0 = test_pt3,
#                 sigma_matrix = sigma_matrix,
#                 mu_vec = mu_list())
# })
# 
# output$indmh_plot_scat <- renderPlot({
#   plot(indmh_comp()[,1], indmh_comp()[,2],
#        xlab = "Variable 1",
#        ylab = "Variable 2",
#        main = "Scatter plot of the simulated bivariate Gaussian samples obtained\nvia the independence Metropolis–Hastings algorithm",
#        pch = as.numeric(input$scat_pch),
#        bg = input$scat_line_col,
#        col = input$scat_col)
# })
# 
# output$indmh_plot_hist <- renderPlot({
#   par(mfcol=c(1,2))
#   
#   xx = seq(-4,4,by=0.01)
#   hist(indmh_comp()[,1], breaks=100, freq=FALSE,
#        main = "Histogram of Marginal Distribution of Variable 1",
#        xlab = "Variable 1",
#        col = input$hist_col,
#        border = "white")
#   lines(xx, dnorm(xx, mean = mu_list()[1], sd = sigma_list()[1]),
#         col = input$hist_line_col,
#         lwd = as.numeric(input$hist_line_lwd),
#         lty = as.numeric(input$hist_line_lty))
#   
#   hist(indmh_comp()[,2], breaks=100, freq=FALSE,
#        main = "Histogram of Marginal Distribution of Variable 2",
#        xlab = "Variable 1",
#        col = input$hist_col,
#        border = "white")
#   lines(xx, dnorm(xx,  mu_list()[2], sd = sigma_list()[2]),
#         col = input$hist_line_col,
#         lwd = as.numeric(input$hist_line_lwd),
#         lty = as.numeric(input$hist_line_lty))
# })
# 
# output$indmh_plot_qqplot <- renderPlot({
#   par(mfcol=c(1,2))
#   
#   qqnorm(indmh_comp()[,1],
#          main = "Normal Q–Q Plot for the Marginal Distribution of Variable 1",
#          pch = as.numeric(input$qqplot_pch),
#          col = input$qqplot_col,
#          bg = input$qqplot_border_col)
#   qqline(indmh_comp()[,1],
#          col = input$qqplot_line_col,
#          lwd = as.numeric(input$qqplot_line_lwd),
#          lty = as.numeric(input$qqplot_line_lty))
#   
#   qqnorm(indmh_comp()[,2],
#          main = "Normal Q–Q Plot for the Marginal Distribution of Variable 2",
#          pch = as.numeric(input$qqplot_pch),
#          col = input$qqplot_col,
#          bg = input$qqplot_border_col)
#   qqline(indmh_comp()[,2],
#          col = input$qqplot_line_col,
#          lwd = as.numeric(input$qqplot_line_lwd),
#          lty = as.numeric(input$qqplot_line_lty))
# })
# 
# output$rwmh_plot_scat <- renderPlot({
#   plot(rwmh_comp()[,1], rwmh_comp()[,2],
#        xlab = "Variable 1",
#        ylab = "Variable 2",
#        main = "Scatter plot of the simulated bivariate Gaussian samples obtained\nvia the random walk Metropolis–Hastings algorithm",
#        pch = as.numeric(input$scat_pch),
#        bg = input$scat_line_col,
#        col = input$scat_col)
# })
# 
# output$rwmh_plot_hist <- renderPlot({
#   par(mfcol=c(1,2))
#   
#   xx = seq(-4,4,by=0.01)
#   hist(rwmh_comp()[,1], breaks=100, freq=FALSE,
#        main = "Histogram of Marginal Distribution of Variable 1",
#        xlab = "Variable 1",
#        col = input$hist_col,
#        border = "white")
#   lines(xx, dnorm(xx, mean = mu_list()[1], sd = sigma_list()[1]),
#         col = input$hist_line_col,
#         lwd = as.numeric(input$hist_line_lwd),
#         lty = as.numeric(input$hist_line_lty))
#   
#   hist(rwmh_comp()[,2], breaks=100, freq=FALSE,
#        main = "Histogram of Marginal Distribution of Variable 2",
#        xlab = "Variable 1",
#        col = input$hist_col,
#        border = "white")
#   lines(xx, dnorm(xx,  mu_list()[2], sd = sigma_list()[2]),
#         col = input$hist_line_col,
#         lwd = as.numeric(input$hist_line_lwd),
#         lty = as.numeric(input$hist_line_lty))
# })
# 
# output$rwmh_plot_qqplot <- renderPlot({
#   par(mfcol=c(1,2))
#   
#   qqnorm(rwmh_comp()[,1],
#          main = "Normal Q–Q Plot for the Marginal Distribution of Variable 1",
#          pch = as.numeric(input$qqplot_pch),
#          col = input$qqplot_col,
#          bg = input$qqplot_border_col)
#   qqline(rwmh_comp()[,1],
#          col = input$qqplot_line_col,
#          lwd = as.numeric(input$qqplot_line_lwd),
#          lty = as.numeric(input$qqplot_line_lty))
#   
#   qqnorm(rwmh_comp()[,2],
#          main = "Normal Q–Q Plot for the Marginal Distribution of Variable 2",
#          pch = as.numeric(input$qqplot_pch),
#          col = input$qqplot_col,
#          bg = input$qqplot_border_col)
#   qqline(rwmh_comp()[,2],
#          col = input$qqplot_line_col,
#          lwd = as.numeric(input$qqplot_line_lwd),
#          lty = as.numeric(input$qqplot_line_lty))
# })
# 
# output$gibbs_plot_scat <- renderPlot({
#   plot(gibbs_comp()[,1], gibbs_comp()[,2],
#        xlab = "Variable 1",
#        ylab = "Variable 2",
#        main = "Scatter plot of the simulated bivariate Gaussian samples obtained\nvia the Gibbs sampler",
#        pch = as.numeric(input$scat_pch),
#        bg = input$scat_line_col,
#        col = input$scat_col)
# })
# 
# output$gibbs_plot_hist <- renderPlot({
#   par(mfcol=c(1,2))
#   
#   xx = seq(-4,4,by=0.01)
#   hist(gibbs_comp()[,1], breaks=100, freq=FALSE,
#        main = "Histogram of Marginal Distribution of Variable 1",
#        xlab = "Variable 1",
#        col = input$hist_col,
#        border = "white")
#   lines(xx, dnorm(xx, mean = mu_list()[1], sd = sigma_list()[1]),
#         col = input$hist_line_col,
#         lwd = as.numeric(input$hist_line_lwd),
#         lty = as.numeric(input$hist_line_lty))
#   
#   hist(gibbs_comp()[,2], breaks=100, freq=FALSE,
#        main = "Histogram of Marginal Distribution of Variable 2",
#        xlab = "Variable 1",
#        col = input$hist_col,
#        border = "white")
#   lines(xx, dnorm(xx,  mu_list()[2], sd = sigma_list()[2]),
#         col = input$hist_line_col,
#         lwd = as.numeric(input$hist_line_lwd),
#         lty = as.numeric(input$hist_line_lty))
# })
# 
# output$gibbs_plot_qqplot <- renderPlot({
#   par(mfcol=c(1,2))
#   
#   qqnorm(gibbs_comp()[,1],
#          main = "Normal Q–Q Plot for the Marginal Distribution of Variable 1",
#          pch = as.numeric(input$qqplot_pch),
#          col = input$qqplot_col,
#          bg = input$qqplot_border_col)
#   qqline(gibbs_comp()[,1],
#          col = input$qqplot_line_col,
#          lwd = as.numeric(input$qqplot_line_lwd),
#          lty = as.numeric(input$qqplot_line_lty))
#   
#   qqnorm(gibbs_comp()[,2],
#          main = "Normal Q–Q Plot for the Marginal Distribution of Variable 2",
#          pch = as.numeric(input$qqplot_pch),
#          col = input$qqplot_col,
#          bg = input$qqplot_border_col)
#   qqline(gibbs_comp()[,2],
#          col = input$qqplot_line_col,
#          lwd = as.numeric(input$qqplot_line_lwd),
#          lty = as.numeric(input$qqplot_line_lty))
# })