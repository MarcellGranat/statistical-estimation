package_success <- FALSE
tryCatch(expr = {
  library(shiny)
  library(shinydashboard)
  library(shinyWidgets)
  library(tidyverse)
  package_success <- TRUE
}, error = function(e) {message(e)}
)

if (!package_success) {
  install.packages("shiny")
  install.packages("shinydashboard")
  install.packages("shinyWidgets")
  install.packages("tidyverse")
  
  library(shiny)
  library(shinydashboard)
  library(shinyWidgets)
  library(tidyverse)
}

