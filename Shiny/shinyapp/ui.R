library(shiny)

shinyUI(pageWithSidebar(
    headerPanel("Miles Per Gallon"),
    sidebarPanel(
        selectInput("variable","Variable:",
                    list("Cylinders" = "cyl",
                         "Transmission" = "am",
                         "Gears" = "gear")),
        
        checkboxInput("outliers","Show outliers",FALSE)
    ),
    mainPanel(
        h1(textOutput("caption")),
        
        plotOutput("mpgPlot")
    )
))