# Load libraries
library("shiny")
library("dplyr")

# Load scripts
source("scripts/irl to mc.R")
source("scripts/irl to mc 2.R")

# Load data frame
df <- read.csv("data/lgnd_info.csv", stringsAsFactors = FALSE)

# Define server
server <- function(input, output, session) {

   observeEvent(
      input$time, {
         if (input$time != "No time selected") {
            updateSelectInput(session, "biome", "Select a spawn biome",
                              choices = c("No biome selected",
                                          unique(
                                             unlist(
                                                strsplit(
                                                   df$Biomes[
                                                      df$Spawn.times
                                                      == input$time], ",\\s*")))
                              ),
                              selected = "No biome selected")
         } else {
            updateSelectInput(session, "biome", "Select a spawn biome",
                              choices = c("No biome selected",
                                          unique(unlist(strsplit
                                                        (df$Biomes, ",\\s*")))
                              ),
                              selected = "No biome selected")
      }
   })

   output$result <- renderText({
     validate(
       need(input$hour != "",
            "Enter the hour until next spawn, if there's none enter 0"),
       need(input$min != "",
            "Enter the minute until next spawn, if there's none enter 0"),
       need(input$sec != "",
            "Enter the second until next spawn, if there's none enter 0"),
       need(input$mc_hr != "",
            "Enter the current Minecraft hour"),
       need(input$mc_min != "",
            "Enter the current Minecraft minute")
     )
     irl_mc(input$hour, input$min, input$sec, input$mc_hr, input$mc_min)
  })

   get_table1 <- function(input1, input2) {
      if (input1 == "No time selected" && input2 == "No biome selected") {
         df
      } else if (input2 == "No biome selected") {
         filtered_table <- df %>%
            filter(Spawn.times == input1)
         filtered_table
      } else if (input1 == "No time selected") {
         filtered_table <- df %>%
            filter(grepl(paste(input2), Biomes))
         filtered_table
      } else {
         filtered_table <- df %>%
            filter(Spawn.times == input1 & grepl(paste(input2), Biomes))
         filtered_table
      }
   }
   output$table1 <- renderTable({
      get_table1(input$time, input$biome)
   })

   get_table2 <- function(input) {
      if (input == "No name selected") {
         paste("Please select a legendary Pokemon name")
      } else {
         filtered_table <- df %>%
         filter(Pokemon == input)
         filtered_table
      }
   }
   output$table2 <- renderTable({
      get_table2(input$name)
   })
   
   get_table3 <- function(input1, input2, input3, input4, input5) {
     times <- unique(unlist(strsplit(irl_mc2
                                      (input1, input2, input3, input4, input5),
                                      ",\\s*")))
     table3_df <- df %>%
       filter(Spawn.times %in% times)
   }
   output$table3 <- renderTable({
     get_table3(input$hour, input$min, input$sec, input$mc_hr, input$mc_min)
   })
}
