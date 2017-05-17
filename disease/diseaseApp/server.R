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


# shinyServer(function(input,output){
#   
# 
#   
#   
# })#shinyServer

#set up table
url <- "https://docs.google.com/spreadsheets/d/1QzJSnkxBCQ8ZDmCVgyErKJ2i6gtSfebU57nSQr6wM6Q/edit#gid=0"

datos <- gsheet::gsheet2tbl(url)

# we called  the Temperature and Month of the data.frame: datos
nombre <- as.vector(c(datos$Month))
npop <- as.vector(c(datos$Nematode))

names(npop) <- c(nombre)

## Set up the bar plots of the nematode populations, try help(barplot) for more information
barplot(
  npop,
  axes=TRUE,
  main="Nematode  Population",
  ylim=c(0,1200),
  col="orange",
  xlab="Month",
  ylab="Nematodes per 100 cc soil")
axis(2,seq(0,1200,by=200)
)

## Set up the new plot to be drawn on top of the barplot, try help(par) for more information
par(new=T)

# correctly in the middle over the top of the bar chart.
y2 <-c (0.5,1.45,2.45,3.5,4.5,5.35,6.5,7.6,8.5,9.55,10.65,11.5)



## Plot the temperature points
plot(
  y2,
  y,
  ylim=c(0,35),
  xlab=NA,
  ylab=NA,
  xlim=c(0,12),
  axes=FALSE,
  type="o",
  pch=22,
  col="mediumblue"
)

axis(
  4,
  seq(0,35,by=5),
  labels=FALSE
)

