source("code.R")
options(shiny.maxRequestSize=1024^3)

shinyServer(function(input, output, session) {

  fileInfo = reactive({
    req(input$dataFile)
    input$dataFile
  })
  
  dataSet = reactive({
    req(fileInfo())
    
    ext = tools::file_ext(fileInfo()$name)
    
    if(ext != "csv") 
    {
      createAlert(session, anchorId = "fileAlert", alertId = "fileError",title = "Error!", paste("This is not a csv! You have uploaded", ext))
      req(NULL)
    }
    closeAlert(session, "fileError")
    
    read_csv(fileInfo()$datapath)
  })
  
  problemTable = reactive({
    req(dataSet())
    problems(dataSet())
  })
  
  output$problems = renderDataTable({
    
    validate(need(nrow(problemTable()) > 0, 
                  message = "Good for you! CheckYourCSV was unable to find any problems in your data!"))
    
    problemTable()
  })
  
  output$problemsRows = renderDataTable({
    validate(need(nrow(problemTable()) > 0, 
                  message = "Good for you! CheckYourCSV was unable to find any problems in your data!"))
    
    dataSet()[problemTable()[["row"]],]
  })
  
  output$rawData = renderDataTable({
    dataSet()
  })
  
  output$cleanData <- downloadHandler(
    filename = function() {
      paste("clean", fileInfo()$name, sep = "-")
    },
    content = function(file) {
      req(dataSet())
      req(dataSet(), problemTable())
      
      dt = dataSet()
      
      if(nrow(problemTable()) > 0)
      {
        dt[-problemTable()$row,]
      }
      
      write.csv(dt, file, row.names = FALSE)
    }
  )
  
})
