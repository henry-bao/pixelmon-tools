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
       need(input$hour != "", "Enter the next spawn hour, if there's none enter 0"),
       need(input$min != "", "Enter the next spawn minute, if there's none enter 0"),
       need(input$sec != "", "Enter the next spawn second, if there's none enter 0"),
       need(input$mc_hr != "", "Enter the current Minecraft hour"),
       need(input$mc_min != "", "Enter the current Minecraft minute")
     )
     irl_mc(input$hour, input$min, input$sec, input$mc_hr, input$mc_min)
  })
   
   output$table1 <- renderTable({
      filtered_table <- df %>% 
         filter(Spawn.times == input$time)
   })
   
   output$table2 <- renderTable({
      filtered_table <- df %>% 
         filter(Pokemon == input$name)
   })
}
