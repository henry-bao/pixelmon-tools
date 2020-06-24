# Load libraries
library("shiny")
library("dplyr")

# Load scripts
source("scripts/irl to mc.R")

# Load data frame
df <- read.csv("data/lgnd_info.csv", stringsAsFactors = FALSE)

# Define server
server <- function(input, output) {

   output$result <- renderText ({
     validate(
       need(input$hour != "", "Enter the hour until next spawn, if there's none enter 0"),
       need(input$min != "", "Enter the minute until next spawn, if there's none enter 0"),
       need(input$sec != "", "Enter the second until next spawn, if there's none enter 0"),
       need(input$mc_hr != "", "Enter the current Minecraft hour"),
       need(input$mc_min != "", "Enter the current Minecraft minute")
     )
     irl_mc(input$hour, input$min, input$sec, input$mc_hr, input$mc_min)
  })
   
   get_table1 <- function (input){
      if (input == "No time selected") {
         df
      } else {
         filtered_table <- df %>% 
         filter(Spawn.times == input)
         filtered_table
      }
   }
   output$table1 <- renderTable({get_table1(input$time)})
   
   get_table2 <- function (input){
      if (input == "No name selected") {
         paste("Please select a legendary Pokemon name")
      } else {
         filtered_table <- df %>% 
         filter(Pokemon == input)
         filtered_table
      }
   }
   output$table2 <- renderTable({get_table2(input$name)})
}