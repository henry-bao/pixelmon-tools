library(dplyr)

df <- read.csv("../data/lgnd_info.csv", stringsAsFactors = FALSE)


test <- unique(unlist(strsplit(df$Biomes, ",\\s*")))


observeEvent(
  input$time,
  updateSelectInput(session, "biome", "Select a spawn biome",
                    choices = c("No biome selected",
                                unique(unlist(strsplit(df$Biomes[df$Spawn.times == input$time],",\\s*")))
                    ),
                    selected = "No biome selected")
)

one <- df %>% 
  select(grepl("Jungle", Biomes))

View(one)
