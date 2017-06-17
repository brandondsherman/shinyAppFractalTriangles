#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Neat Thing"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      numericInput("seed",
                   "New random seed:",
                   floor(runif(1,max = 10000)),
                   min = 1,
                   max = 10000
                   ),
      sliderInput("obs", 
                  "Number of observations:",
                  min = 1,
                  max = 10000,
                  value = 10000
                  ),
      helpText("With a random starting point",
               "inside an equilateral triangle,",
               "pick one of the corners randomly",
               "and calculate the midpoint.",
               "Use this midpoint as a new point",
               "and repeat. The results if you plot",
               "these points is...interesting.")
                ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("plot")
    )
  )
))
