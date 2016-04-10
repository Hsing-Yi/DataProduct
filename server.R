data("iris")
library(caret)
library(mlbench)
library(forecast)
library(dplyr)
library(ggplot2)
library(GGally)
library(lattice)
library(caret)
library(e1071)
library(kernlab)
library(kknn)



shinyServer(function(input, output) {

        output$algorithm <- renderText({
                if (input$radio == '1') t <- "You have selected KKNN k-Nearest Neighbors"
                if (input$radio == '2') t <- "You have selected KNN k-Nearest Neighbors"
                if (input$radio == '3') t <- "You have selected SVM Support Vector Machine"
                if (input$radio == '4') t <- "You have selected RF Random Forest"
                if (input$radio == '5') t <- "You have selected NNET Neutral Network"
                print(t)
        })


        output$accuracy <- renderText({
                intrain <- sample(1:nrow(iris), size = input$sampleSize, replace = FALSE)
                training <- iris[intrain,]
                testing <- iris[-intrain,]
                f <- as.formula(paste("Species ~", paste(names(training)[!names(training) %in% c("Species")], collapse = " + ")))

                if (input$radio == '1') {
                        ### KKNN k-Nearest Neighbors
                        iris.kknn <- kknn(f, training, testing, distance = 1, kernel = "triangular")
                        predict <- fitted(iris.kknn)
                }
                if (input$radio == '2') {
                        ### KNN k-Nearest Neighbors
                        knn_fit <- train(f, data = training, method = "knn", tuneLength = 10)
                        predict <- predict(knn_fit, testing[,1:4])
                }
                if (input$radio == '3') {
                        ### SVM Support Vector Machine
                        svm_fit <- svm(f, data = training)
                        predict <- predict(svm_fit, testing[,1:4])
                }
                if (input$radio == '4') {
                        ### RF Random Forest
                        rf_model<-train(f,data=training ,method="rf")
                        predict <- predict(rf_model, testing[,1:4])
                }
                if (input$radio == '5') {
                        ### NNET Neutral Network
                        NN_fit <- train(f, data = training, method = "nnet", tuneLength = 2,  maxit = 30)
                        predict <- predict(NN_fit, testing[,1:4])
                }

                output$table <- renderTable({
                        confusionMatrix(predict, testing[,5])$table
                })

                paste("The accuracy is :" ,{confusionMatrix(predict, testing[,5])$overall[1]})


                })

}
)




