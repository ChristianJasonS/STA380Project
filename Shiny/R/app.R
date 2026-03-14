library(shiny)
library(bslib)
library(shinycssloaders) 

options(spinner.type = 8, spinner.color = "#6990EE")

ui <- page_sidebar(
  theme = bs_theme(version = 5,
                   bootswatch = "flatly",
                   "navbar-bg" = "#2C3E50"),
  
  title = "Simulating Distributions Using Inverse Transform",
  
  sidebar = sidebar(
    
    selectInput(inputId = "dist_type",
                label = 'What distribution would you like to see?',
                choices = list("Kumaraswamy" = "kumaraswamy",
                               "Arcsine" = "arcsine"),
                selected = "kumaraswamy"),
    
    selectInput(inputId = "modify_type",
                label = 'What would you like to modify?',
                choices = list("Simulation Inputs" = "simulation",
                               "Graph Output" = "graph"),
                selected = "simulation"),
    
    conditionalPanel(
      condition = "input.modify_type == 'simulation'",
      numericInput("n_samples", "Number of Samples (n):", value = 5000, min = 100),
      
      conditionalPanel(
        condition = "input.dist_type == 'kumaraswamy'",
        numericInput("param_a", "Parameter a:", value = 0.5, min = 0.1, step = 0.1),
        numericInput("param_b", "Parameter b:", value = 0.5, min = 0.1, step = 0.1)
      )
    ),
    
    conditionalPanel(
      condition = "input.modify_type == 'graph'",
      
      selectInput(inputId = "graph_version",
                  label = 'Which output would you like to view?',
                  choices = list("Scatterplot" = "scat",
                                 "Histogram" = "hist",
                                 "Statistics Table" = "table"),
                  selected = "scat")
    ), 
    
    width = 400,
    open = "always"), 
  
  conditionalPanel(
    condition = "input.dist_type == 'kumaraswamy'",
    
    conditionalPanel(
      condition = "input.graph_version == 'scat'",
      withSpinner(plotOutput("kumaraswamy_plot_scat"))
    ), 
    
    conditionalPanel(
      condition = "input.graph_version == 'hist'",
      withSpinner(plotOutput("kumaraswamy_plot_hist"))
    ), 
    
    conditionalPanel(
      condition = "input.graph_version == 'table'",
      withSpinner(uiOutput("kumaraswamy_table"))
    ) 
  ), 
  
  conditionalPanel(
    condition = "input.dist_type == 'arcsine'",
    
    conditionalPanel(
      condition = "input.graph_version == 'scat'",
      withSpinner(plotOutput("arcsine_plot_scat"))
    ), 
    
    conditionalPanel(
      condition = "input.graph_version == 'hist'",
      withSpinner(plotOutput("arcsine_plot_hist"))
    ), 
    
    conditionalPanel(
      condition = "input.graph_version == 'table'",
      withSpinner(uiOutput("arcsine_table"))
    ) 
  ) 
)

server <- function(input, output, session) {
  source(file.path("server-plots.R"), local = TRUE)$value
}

shinyApp(ui = ui, server = server)