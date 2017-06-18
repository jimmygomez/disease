library(shiny)
library(shinydashboard)
library(dplyr)
library(plotly)
library(tibble)
library(DT)
library(leaps)
library(scatterplot3d)
library(flashClust)
library(lubridate)


shinyServer(function(input, output) {##inicio

# #set up table
# url <- "https://docs.google.com/spreadsheets/d/1QzJSnkxBCQ8ZDmCVgyErKJ2i6gtSfebU57nSQr6wM6Q/edit#gid=0"
# 
# datos <- gsheet::gsheet2tbl(url)


# manual update -----------------------------------------------------------

metdata <-  eventReactive(input$reload, {#>>>>>>>>
  #
  file <-   disease::getData(dir = input$wtdt)
  
  file <- file %>%
    dplyr::mutate(ill = disease::dgrap(data = file, 
                                        Month = "month",
                                       Nematode = "nematode",
                                        Temperature = "temperature"))%>%
    dplyr::mutate(ill = round(ill,2))
  
}, ignoreNULL = FALSE)#>>>>>>


# Plot metdata ------------------------------------------------------------


output$wtplot <- plotly::renderPlotly({#<<<<<<<<<<
  
  file <- metdata()
  
  file <- file %>%
  
    tidyr::gather(key = variable , value = value,  -month)
  
   ax <- list(
    title = "",
    type = "month",
  #  tickformat = "%d-%b",
    tickmode = "auto"
  )
  
  ay <- list(
    title = "",
    type = "linear",
    tickmode = "auto"
  )
  
  lgd <- list(
    
    orientation = "h",
    xanchor = "auto"
    
  )
  
  
  plotly::plot_ly(file, x = ~month, y = ~variable,
                  color = ~variable, symbol = ~variable) %>%
    plotly::add_lines() %>%
    plotly::layout(xaxis = ax, yaxis = ay, legend =  lgd)
  
})#<<<<<<<<

# Data frame in the screen ------------------------------------------------


output$gss <- renderUI({
  
  gss <- tags$iframe(src = input$wtdt ,
                     style="height:450px; width:100%; scrolling=no")
  
  print(gss)
  
})

# plotcvst -----------------------------------------------------------------

output$bpx <- renderUI({
  
  
  file <- fb()
  fbn <- names(file)
  
  selectInput(
    inputId = "xbp",
    label = "Axis X",
    choices = c("choose" = "", fbn)
  )
  
})


})##inicio