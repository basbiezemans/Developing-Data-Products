#
# Server logic of the application
#
library(shiny)
library(ggplot2)

shinyServer(function(input, output) {
    
    set.seed(1337)
    
    dataset <- reactive({
        diamonds[sample(nrow(diamonds), input$sampleSize),]
    })
    
    output$plot <- renderPlot({
        
        p <- ggplot(dataset(), aes_string(x = input$x, y = input$y)) + 
             geom_point(shape = 19, alpha = 1/2) + 
             scale_colour_brewer(type = "seq", palette = "Set1") + 
             theme_bw() + 
             theme(axis.title = element_text(size = 14),
                   panel.border = element_blank(),
                   axis.line.x = element_line(colour = "black", size = .5))

        if (input$size != "None") {
            p <- p + aes_string(size = input$size)
        }
        
        if (input$color != "None") {
            p <- p + aes_string(color = input$color)
        }
        
        if (input$jitter) {
            p <- p + geom_jitter()
        }

        if (input$smooth) {
            p <- p + geom_smooth(color = "red", span = 1.5)
        }

        print(p)
    })
    
})