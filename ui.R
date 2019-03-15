#-------------------------------------------------------------------------
#  Roseric Azondekon,
#  April 21st, 2018
#  Milwaukee, WI, USA
#-------------------------------------------------------------------------
library(shiny)
library(shinydashboard)
library(htmlwidgets)

#Dashboard Menu
dashboard <- dashboardHeader(title = "KDT Estimator")

loadData <- fileInput('datafile', 'Load a dataset (.xlsx, .xls, .txt or .csv)',
                      accept=c('text/csv/xls', 'text/comma-separated-values,text/plain'))


linkFunction <- selectInput("func", 
                         label = h4("Select a link function:"),
                         choices = list("Probit" = "probit", "Log" = "log", 
                                        "Logit" = "logit") 
                         # ,selected = "probit"
)

kdtUI <- uiOutput("kdt")
deadUI <- uiOutput("dead")
totalUI <- uiOutput("total")
compute <- uiOutput("computeKDT")
sidebar <- dashboardSidebar(loadData, linkFunction, kdtUI, deadUI, totalUI, compute)
kd50 <- valueBoxOutput("kd50")
kd90 <- valueBoxOutput("kd90")
kd95 <- valueBoxOutput("kd95")
plotM <- plotOutput("plotModel",width = "75%", height = "400px",inline = F)
previewData <- tabPanel("Preview Data", tableOutput("filetable"))
resultsContent <- fluidRow(
  kd50,kd90,kd95,column(12,align="center",plotM)
)
results <- tabPanel("Results", resultsContent)
readme <- tabPanel("README", includeHTML("readme.html"))
modelSummary <- tabPanel("Model Summary", verbatimTextOutput("summary"))

menu <- fluidRow(tabBox(width=12,height = "600px",results,modelSummary,previewData,readme),selected=readme)

#Display body
body <- dashboardBody(menu)

dashboardPage(dashboard,sidebar,body)
