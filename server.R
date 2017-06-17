#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(dplyr)
# Define server logic required to draw a histogram

maxObs = 10000
shinyServer(function(input, output) {
  
  
  calcData <- reactive({
    set.seed(input$seed)
    
    x = 1:(maxObs+4)
    
    data <- data.frame(i = x, trianglePoint = sample(1:3,maxObs+4,replace=TRUE))
    
    #data = data %>%
    #  mutate(typeOfPoint = ifelse(i < 4, "corners", ifelse(i==4,"start","new")))
    
    data$locx[1] = 0; data$locx[2] = 1; data$locx[3] = 1/2;
    data$locy[1] = 0; data$locy[2] = 0; data$locy[3] = sqrt(3)/2;
    
    startPoint = getGoodPoint()
    data$locx[4] = startPoint[1]; data$locy[4] = startPoint[2]
    
    for(j in 5:(maxObs+4)){
      corner = data$trianglePoint[j]
      data$locx[j] = (data$locx[j-1] + data$locx[corner])/2
      data$locy[j] = (data$locy[j-1] + data$locy[corner])/2
    }
    
    data
  })
  
  output$plot <- renderPlot({
    p = ggplot(calcData()[1:input$obs+4,], aes(x= locx, y = locy)) +
      geom_point() +
      theme(line = element_blank(),
            axis.title = element_blank(),
            axis.text = element_blank(),
            axis.ticks = element_blank()
            )                          
    print(p)
  })
  

  
})
getGoodPoint = function(){
  x = runif(1)
  y = runif(1)
  
  if(y <= sqrt(3)*x & y <= -sqrt(3)*x + 2*sqrt(3)){
    return(c(x,y))
  }
  else{
    return(getGoodPoint())
  }
}

