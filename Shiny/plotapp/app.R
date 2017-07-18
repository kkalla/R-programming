library(shiny)
abc <- c(110,300,150,280,310)
def <- c(180,200,210,190,170)
ghi <- c(210,150,260,210,70)

B_type2 <- matrix(c(abc,def,ghi),5,3)

server <- function(input, output) {
    selected <- reactive(
        input$select
    )
    output$plot <- renderPlot({
        if(selected() == "Barplot"){
        barplot(t(B_type2),main = "시즌 별 볼타입에 따른 판매량",xlab="season",
                ylab="Price",beside=T,names.arg = LETTERS[1:5],border="blue",
                col=rainbow(3),
                ylim = c(0,400))
        legend(16,400,c("BaseBall","SoccerBall","BeachBall"),cex=.8,
            fill=rainbow(5))}
        else if(selected() == "Scatter"){
            plot(-4:4,-4:4, type="n")
            points(rnorm(200),rnorm(200),pch="+",col = "red")
            par(new=T)
            points(rnorm(200),rnorm(200),pch='o',col="cyan")
        }else if(selected() =="Stars"){
            par(mar = c(1,1,1,1))
            data("mtcars")
            stars(mtcars[,1:4],key.loc = c(12,1))
        }else if(selected() =="Pairs"){
            data(iris)
            pairs(iris[1:4],
                  col = c("red","gold","blue")[unclass(iris$Species)])
        }else if(selected() =="Persp"){
            x1 <- seq(-3,3,length = 50)
            x2 <- seq(-4,4,length = 60)
            f <- function(x1,x2) {x1^2 + x2^2 + x1*x2}
            y <- outer(x1,x2, FUN = f)
            par(mfrow = c(2,1),mar = c(1,1,1,1))
            persp(x1,x2,y)
            contour(x1,x2,y)
        }else if(selected() == "Pieplot"){
            x <- c(100,70,60,50)
            y <- c("A","B","C","D")
            pie(x, labels =y,col = rainbow(4))
        }
    })

    
    output$caption <- renderText({
        selected()
    })
}

ui <- fluidPage(
    sidebarPanel(
        selectInput("select","Select Graph Type:",
                    choices = c("Barplot","Pieplot","Scatter","Stars",
                                "Pairs","Persp"),
                    selected = "Barplot")
    ),
    mainPanel(
        h2(textOutput("caption")),
        plotOutput("plot",height = "600px")
    )
)

shinyApp(ui = ui, server = server)