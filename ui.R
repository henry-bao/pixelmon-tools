# Load libraries
library("shiny")
library("shinythemes")

# Load data frame
df <- read.csv("data/lgnd_info.csv", stringsAsFactors = FALSE)

# First page
first_page <- tabPanel(
  "Spawn time calculator",
  sidebarLayout(
    sidebarPanel(
      width = 4,
      h2(span("Next spawn informations"), style = "color: grey"),
      numericInput(
        inputId = "hour",
        label = h4("Next spawn hour:"),
        value = 0
      ),
      numericInput(
        inputId = "min",
        label = h4("Next spawn minute:"),
        value = 0
      ),
      numericInput(
        inputId = "sec",
        label = h4("Next spawn second:"),
        value = 0
      ),
      h2(span("Current Minecraft time"), style = "color: grey"),
      numericInput(
        inputId = "mc_hr",
        label = h4("Current Minecraft hour (0-23):"),
        value = 0
      ),
      numericInput(
        inputId = "mc_min",
        label = h4("Current Minecraft minute:"),
        value = 0
      )
    ),
    mainPanel(
      width = 7,
      h2("The next spawn time is:"),
      h2(span(textOutput("result"), style = "color: black")),
      p("Disclaimer: The calculated spawn time should only be used as a
        reference, calculations might not be accurate due to time conversions
        from IRL to Minecraft"),
      tags$img(
        src = "time.png",
        width = "60%"
      ),
      p(" ")
    )
  )
)

# Second page
second_page <- tabPanel(
  "Legend spawn search",
  sidebarLayout(
    sidebarPanel(
      width = 4,
      selectInput("time", h4("Select a spawn time"),
                  choices = unique(df$Spawn.times)),
      tags$img(
        src = "time.png",
        width = "100%"
      )
    ),
    mainPanel(
      width = 7,
      tableOutput("table")
    )
  )
)

# Define ui
ui <- navbarPage(
  "Pixelmon Tools",
  theme = shinytheme("united"),
  first_page,
  second_page
)
