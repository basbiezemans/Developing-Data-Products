#
# User-interface definition of the application
#
library(shiny)
library(ggplot2)

dataset <- diamonds

is.factor.col <- sapply(dataset, is.factor)
names.factor.cols <- names(dataset[, is.factor.col])

shinyUI(fluidPage(
    
    titlePanel("Diamonds Explorer"), br(), 
    sidebarLayout(
        
        sidebarPanel(
            sliderInput("sampleSize", "Sample Size", 
                        min = 1, 
                        max = nrow(dataset),
                        step = 500, 
                        round = 0,
                        value = min(1000, nrow(dataset))),
            br(),
            
            selectInput("x", "X-axis", names(dataset), selected = "carat"),
            selectInput("y", "Y-axis", names(dataset), selected = "price"),
            
            selectInput("size", "Point Size", c("None", names(dataset)), selected = "carat"),
            selectInput("color", "Point Color", c("None", names.factor.cols), selected = "cut"),
            
            checkboxInput("jitter", "Jitter Points"),
            checkboxInput("smooth", "Smoothing Curve")
        ),
        
        mainPanel(
            tabsetPanel(type = "tabs",
                
                tabPanel("Interactive Plot", br(),
                         
                    plotOutput("plot")
                ),
                tabPanel("Documentation", br(), 
                         
                    h4("Summary"),
                    p("The Diamonds Explorer application lets you explore the", 
                      HTML("<i>diamonds dataset</i>"), ". This dataset contains the prices and other 
                      attributes of almost 54,000 diamonds."), hr(),
                    
                    h4("Interactivity"), 
                    p("The slider in the sidebar panel can be adjusted to increase or reduce  
                      sample size. You can select different variables for the X and Y axes. Use 
                      Point Size and Color to add an extra dimension to the plot. Check the Jitter 
                      Points box to reduce overplotting and the Smoothing Curve box to show a pattern 
                      in the data."), hr(),
                    
                    h4("Variables"),
                    p("The variables are as follows:"),
                    
                    p(strong("price"), ": price in US dollars ($326-$18,823)"),
                    
                    p(strong("carat"), ": weight of the diamond (0.2-5.01)"),
                    
                    p(strong("cut"), ": quality of the cut (Fair, Good, Very Good, Premium, Ideal)"),
                    
                    p(strong("color"), ": diamond colour, from J (worst) to D (best)"),
                    
                    p(strong("clarity"), ": a measurement of how clear the diamond is, from I1 
                      (worst) to IF (best)"),
                    
                    p(strong("x"), ": length in mm (0-10.74)"),
                    
                    p(strong("y"), ": width in mm (0-58.9)"),
                    
                    p(strong("z"), ": depth in mm (0-31.8)"),
                    
                    p(strong("depth"), ": total depth percentage = z / mean(x, y) = 2 * z / (x + y) 
                      (43-79)"),
                    
                    p(strong("table"), ": width of top of diamond relative to widest point (43-95)")
                )
        ))
    )
))
