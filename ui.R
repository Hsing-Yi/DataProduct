library(shiny)
library(ggplot2)

dataset <- iris

shinyUI(
        pageWithSidebar(
                # Application title

        headerPanel("Trial Run Classification Algorithms for iris dataset"),

        sidebarPanel(
                sliderInput('sampleSize', 'Training Set Sample Size', min=0, max=150,value=100, step=10, round=0),

                radioButtons("radio", "Select Algorithm:",
                             c("KKNN k-Nearest Neighbors" = "1",
                               "KNN k-Nearest Neighbors" = "2",
                               "SVM Support Vector Machine" = "3",
                               "RF Random Forest" = "4",
                               "NNET Neutral Network" = "5"))
        ),

        mainPanel(
                h3('Result:'),
                textOutput("algorithm"),
                textOutput("accuracy"),
                h4('Confusion Matrix Based on Test Dataset'),
                tableOutput("table")

        )
        )
)



