#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)
library(ggplot2)

shinyUI(fluidPage(
        titlePanel("Earned doctoral degrees by sex"),
        sidebarLayout(
                sidebarPanel(
                        sliderInput("Year", "What year are you interested in?", 1985, 2050, value=2000),
                        checkboxInput("Male", "Show/Hide Male", value=TRUE),
                        checkboxInput("Female", "Show/Hide Female", value=TRUE)
                ),
        
        mainPanel(
                h5("How many males and females have earned doctoral degrees each year from 1985-2015? When will the numbers be equal for each sex?"),
                h5("Use the slider on the left to choose the year you are interested in learning about. Data is available from 1985-2015. If you choose future years, it will predict the numbers based on the model."),
                h5("All points are displayed. Select on the left whether you'd like to see the linear models for males, females or both"),
                h5("", a("ui.R & server.R code in Kaelyn Sumigray's Github Repository", href="https://github.com/ksumigray/Developing-Data-Products")),
                
                h3("Graph of earned doctorates 1985-2015"),
                plotOutput("plot1"),
                h3("Predicted Number of male doctorates:"),
                textOutput("pred_male"),
                h3("Predicted Number of female doctorates:"),
                textOutput("pred_female")
                )
        )
))
