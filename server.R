#-------------------------------------------------------------------------
#  Roseric Azondekon,
#  April 21st, 2018
#  Milwaukee, WI, USA
#-------------------------------------------------------------------------
library(shiny)
library(shinydashboard)
library(htmlwidgets)
library(MASS)
library(drc)
library(ggplot2)
library(readxl)
library(openxlsx)


  #This function is repsonsible for loading in the selected file
  filedata <- reactive({
    infile <- input$datafile
    if (is.null(infile)) {
      # User has not uploaded a file yet
      return(NULL)
    }
    if(endsWith(infile$name, ".csv")){
      read.csv(infile$datapath)
    } else if(endsWith(infile$name, ".txt")){
      read.table(infile$datapath,header = T)
    }else if(endsWith(infile$name, ".xls")){
      read_excel(infile$datapath)
    } else if(endsWith(infile$name, ".xlsx")){
      read_xlsx(infile$datapath,sheet=1)
      }
  })


  # #The following set of functions populate the column selectors
  output$kdt <- renderUI({
    df <-filedata()
    if (is.null(df)) return(NULL)

    items=names(df)
    names(items)=items
    selectInput("kdt", "Select a variable for 'KDT':",items, selected="KDT")

  })
  

  output$dead <- renderUI({
    df <-filedata()
    if (is.null(df)) return(NULL)

    items=names(df)
    names(items)=items
    selectInput("dead", "Select a variable for 'dead':",items, selected="dead")

  })
  
  output$total <- renderUI({
    df <-filedata()
    if (is.null(df)) return(NULL)
    
    items=names(df)
    names(items)=items
    selectInput("total", "Select a variable for 'total':",items, selected="total")
    
  })
  
  output$computeKDT <- renderUI({
    df <-filedata()
    if (is.null(df)) return(NULL)
    

    actionButton("computeKDT","Estimate KDT!")
  })

  output$filetable <- renderTable({
    filedata()
  })
  
  resModel <- eventReactive(input$computeKDT, {
    df <-filedata()
    func<-input$func
    KDT <- as.vector(df[[input$kdt]])
    DEAD <- as.vector(df[[input$dead]])
    TOTAL <- as.vector(df[[input$total]])
    ALIVE <- TOTAL - DEAD
    
    data <- data.frame(KDT=KDT, Alive=ALIVE, Dead=DEAD, Total=TOTAL)
    data$prop = with(data, Dead/Total)
    
    model<-glm(formula = data$prop~data$KDT,family = binomial(link = func),weights = data$Total)
    out <- dose.p(model,p=c(0.5,0.9,0.95))
    ret<-list()
    ret[['out']]<-out
    ret[['data']]<-data
    ret[['func']]<-func
    ret[['model']]<-model
    ret
  })
  
  output$kd50 <- renderValueBox({
    ret<-resModel()
    out<-ret$out
    valueBox(
      h5(paste0(round(out[[1]],1), "   [",round(out[[1]]-attr(out,"SE")[1],2)," - ",round(out[[1]]+attr(out,"SE")[1],2),"]")),
      "KD50",color = "green"
    )
  })
  output$kd90 <- renderValueBox({
    ret<-resModel()
    out<-ret$out
    valueBox(
      h5(paste0(round(out[[2]],1), "  [",round(out[[2]]-attr(out,"SE")[2],2)," - ",round(out[[2]]+attr(out,"SE")[2],2),"]")),
      "KD90",color = "yellow"
    )
  })
  output$kd95 <- renderValueBox({
    ret<-resModel()
    out<-ret$out
    valueBox(
      h5(paste0(round(out[[3]],1), "  [",round(out[[3]]-attr(out,"SE")[3],2)," - ",round(out[[3]]+attr(out,"SE")[3],2),"]")),
      "KD95",color = "red"
    )
  })
  output$summary <- renderPrint({
    ret<-resModel()
    out<-ret$out
    model <- ret$model
    list('Model Summary'=summary(model),'Prediction Summary'=out)
  })
  isolate({
    output$plotModel<-renderPlot({
      ret<-resModel()
      data<-ret$data
      func<-ret$func
      ggplot(data, aes(KDT, prop)) + 
        geom_smooth(method = "glm", method.args = list(family = binomial(link = func) ),
                    aes(weight = Total, colour = "KDT Model"), se = T) + geom_point() +
        labs(title="Knock-Down Time Estimation",subtitle=paste("Link function:",func),
             x = "Knock-Down Time (KDT)", 
             y = "Proportion of Dead")
    })
  })
})
