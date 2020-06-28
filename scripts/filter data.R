library(dplyr)

df <- read.csv("../data/lgnd_info.csv", stringsAsFactors = FALSE)


test <- unique(unlist(strsplit(df$Biomes, ",\\s*")))
test

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


example <- c("a, b", "c", "d", "e, f", "g")
df <- data.frame(example)
df$example <- sub(",\\s*", ",\n", df$example)
df



test1 <- function(){
  paste("Night, Dawn/Dusk")
}
test1()

times <- unique(unlist(strsplit(test1(), ",\\s*")))
times


t1 <- df %>%
  filter(Spawn.times %in% times)
t1

  