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
    
    numericInput("seed", "Set Seed:", value=1),
    numericInput("n_samples", "Number of Samples (n):", value = 10000, min = 1),
    
    selectInput(inputId = "dist_type",
                label = 'What distribution would you like to simulate?',
                choices = list("Kumaraswamy" = "kumaraswamy",
                               "Arcsine" = "arcsine"),
                selected = "kumaraswamy"),
    
    conditionalPanel(
      condition = "input.dist_type == 'kumaraswamy'",
      numericInput("param_a", "Shape parameter a (controls left tail):", value = 0.5, min = 0.0001, step = 0.1),
      numericInput("param_b", "Shape parameter b (controls right tail):", value = 0.5, min = 0.0001, step = 0.1)
    ),
    
    selectInput(inputId = "graph_type",
                label = 'How would you like to view the simulated data?',
                choices = list("Histogram" = "hist",
                               "Statistics Table" = "table"),
                selected = "simulation"),
    
    width = 400,
    open = "always"),
  
  tableOutput("table"),
  plotOutput("plots")
  
)
  
  # conditionalPanel(
  #   condition = "input.dist_type == 'arcsine'",
  #   
  #   conditionalPanel(
  #     condition = "input.graph_version == 'hist'",
  #     withSpinner(plotOutput("arcsine_plot_hist"))
  #   ), 
  #   
  #   conditionalPanel(
  #     condition = "input.graph_version == 'table'",
  #     withSpinner(uiOutput("arcsine_table"))
  #   ) 
  # ) 
# )

server <- function(input, output, session) {
  source(file.path("server-plots.R"), local = TRUE)$value
}

shinyApp(ui = ui, server = server)