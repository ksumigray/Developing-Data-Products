

library(shiny)
library(plotly)
library(ggplot2)
doc <- read.csv('./data/SED_sex_subject.csv')
doc$Number <- as.numeric(gsub(",", "", as.character(doc$Number)))
all_fields <- doc[doc$Field == "All fields",]
all_fields <- all_fields[all_fields$Sex %in% c("Male", "Female"),]
male <- all_fields[all_fields$Sex == "Male",]
female <- all_fields[all_fields$Sex == "Female",]


shinyServer(function(input, output) {
        model_male <- lm(Number ~ Year, data=male)
        model_female <- lm(Number ~ Year, data=female)
  
        model_male_pred <- reactive({
                year_input <- input$Year
                predict(model_male, newdata=data.frame(Year = year_input))
        })
        
        model_female_pred <- reactive({
                year_input <- input$Year
                predict(model_female, newdata = data.frame(Year = year_input))
        })
        
        output$plot1 <- renderPlot({
                year_input <- input$Year
                plot(all_fields$Year, all_fields$Number, xlab="Year", ylab="Number of Earned doctorates", bty="n", pch=16, col="black")
                if(input$Male){
                        abline(model_male, col="blue", lwd=2)
                }
                if(input$Female){
                        abline(model_female, col="pink", lwd=2)
                }
                points(year_input, model_male_pred(), col='blue', pch=16, cex=2)
                points(year_input, model_female_pred(), col="pink", pch=16, cex=2)
                })
        
output$pred_male <- renderText({
        model_male_pred()
        })
output$pred_female <- renderText({
        model_female_pred()
        })
})


