library(dplyr)

df <- read.csv("../data/lgnd_info.csv", stringsAsFactors = FALSE)

# group by spawn time
dawn_dusk <- df %>% 
  filter(Spawn.times == "Dawn/Dusk")
any <- df %>% 
  filter(Spawn.times == "Any")
none <- df %>% 
  filter(Spawn.times == "None")
dusk <- df %>% 
  filter(Spawn.times == "Dusk")
day <- df %>% 
  filter(Spawn.times == "Day")
night <- df %>% 
  filter(Spawn.times == "Night")
afternoon <- df %>% 
  filter(Spawn.times == "Afternoon")
morning <- df %>% 
  filter(Spawn.times == "Morning")
moon <- df %>% 
  filter(Spawn.times %in%
             c("Night - Moon Phase 0 (Full Moon)",
               "Night - Moon Phase 4 (New Moon)"))
