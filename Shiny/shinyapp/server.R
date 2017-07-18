library(shiny)
library(datasets)

mpgdata <- mtcars
mpgdata$am <- factor(mpgdata$am, labels = c("Automatic","Manual"))

shinyServer(function(input,output){
    formulaText <- reactive({
        paste("mpg ~",input$variable)
    })
    
    output$caption <- renderText({
        formulaText()
    })
    output$mpgPlot <- renderPlot({
        boxplot(as.formula(formulaText()),
                           data = mpgdata,
                           outline = input$outliers)
    })
})
