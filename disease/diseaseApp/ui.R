# contruyendo la aplicación para disease
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


 # Define UI for application.
shinyUI(
  dashboardPage(

# head --------------------------------------------------------------------
    dashboardHeader(title = "DiseaseQuant"),#dashboard


# Sider -------------------------------------------------------------------

    dashboardSidebar(
      sidebarMenu(
      menuItem("Presentation", tabName = "intro", icon = icon("home")),
      menuItem("Choose File", tabName = "choose", icon = icon("folder-open")),
      menuItem("CicleVsTempeture", tabName = "ciclevstemperature", icon = icon("search")),
      menuItem("AUDCP", tabName = "audcp", icon = icon("pencil"))
                    )
                ),
#http://getbootstrap.com/components/#glyphicons-glyphs

# body --------------------------------------------------------------------
    dashboardBody(


      tabItems(


# presentacion ------------------------------------------------------------


    tabItem(tabName = "intro",#intro


            box(#box1
              title = "Presentation",
              width = 4,
              status = "primary",
              solidHeader = T,

              p( strong(em("DiseaseQuant")),"is a interactive application
                 for calculte the cicle of the disease."),

              #img(src = "agrinka.jpg",  width = "100%"),

              HTML('<p style="text-align: right;">
                   <span style="font-size:14px;">
                   <span style="font-family:comic sans ms,cursive;">
                   Powered by
                   <span style="font-size:16px;">
                   <span style="font-family:lucida sans unicode,lucida grande,sans-serif;">
                   <strong><span style="color:#ff0000;">
                   Q
                   </span><span style="color:#a52a2a;">
                   u
                   </span><span style="color:#008000;">
                   i
                   </span><span style="color:#008080;">
                   p
                   </span><span style="color:#0000ff;">
                   o
                   </span>
                   </strong>
                   </span>
                   </span>
                   </span>
                   </span>
                   </p>'
                   )

            ),#box1


            box(#2
              title = "Characteristics",
              width = 4,
              status = "danger",
              solidHeader = T,

              p("- Calculate the relation of the cicle to disease about the temperature."),

              p("- Calculate the area under the disease curve progress. ")


            ),#2

            box(#3
              title = "Contributors",
              width = 4,
              status = "success",
              solidHeader = T,
              p(
                strong("Felipe de Mendiburu"),
                br(),
                a("< fmendiburu@yahoo.com >"),
                br(),
                code("Universidad Nacional Agraría la Molina, Lima, Perú")
              ),

              p(
                strong("Flavio Lozano Isla "),
                br(),
                a("< flavjack@gmail.com >"),
                br(),
                code("Universidad Nacional Agraria la Molina, Lima, Perú")
              ),

              p(
                strong("Jimmy R. Gomez Carrión"),
                br(),
                a("< purmacana@gmail.com >"),
                br(),
                code("Universidad Nacional Agraria la Molina, Lima, Perú")
              ),

              p(
                strong("Omar Benites Alfaro"),
                br(),
                a("< obacc07@gmail.com >"),
                br(),
                code("Universidad Nacinal Mayor de San Marcos, Lima, Perú")
              ),


              p(
                strong("Kevin Arthur Lara Jauregui"),
                br(),
                a("< kevin.lara@pucp.edu.pe >"),
                br(),
                code("Pontificia Universidad Católica del Perú")
              ),


              hr(),

              p(strong("If you have any question, commment or sugestion you can write a email for us!!!"))

              )#box3


            ),#intro






# Choose File -------------------------------------------------------------





tabItem(tabName = "choose",
        
        
        box(#box
          
          status = "info",
          width = 12,
          background = "yellow",
          
          column(width = 3,
                 
                 
                 h4("Google spreadsheet (URL)", icon("folder-open"), width = "100%")
                 
                 
          ),
          
          column(width = 7,
                 
                 textInput("wtdt", label = NULL, width = "100%",
                           value = "https://docs.google.com/spreadsheets/d/1QzJSnkxBCQ8ZDmCVgyErKJ2i6gtSfebU57nSQr6wM6Q/edit#gid=0")
          ),
          
          column(width = 2,
                 
                 actionButton(inputId = "reload", label = "update", icon("refresh"), width = "100%")
                 
          )
          
          
        ),#box
        
        
        box(
          
          status = "danger",
          solidHeader = T,
          width = 12,
          
          
          htmlOutput("gss")
          
          
        )
        
        ),


# CicleVsTemperature ------------------------------------------------------
tabItem(tabName = "ciclevstemperature",
        
        
        box(
          
          status = "danger",
          solidHeader = T,
          width = 12,
          
          plotly::plotlyOutput("wtplot", height = "auto")
          
        )
        
        
)#,


 
#     tabItem(tabName = "ciclevstemperature",
# 
# 
# 
# shiny::fluidRow(
#   box(width = 12, height = NULL,
#       plotOutput("boxplot"),
#       br()#,
#   )#,
# )#,
# 
#         )#ciclevstemperature



)   ) #dashboard









)   ) #page




