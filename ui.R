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
      h2(span("Time until next legend spawn"), style = "color: grey"),
      div(style="display: inline-block;vertical-align:top; width: 70px;",
      numericInput(
        inputId = "hour",
        label = h4("Hour:"),
        value = 0
      )),
      div(style="display: inline-block;vertical-align:top; width: 5px;"),
      div(style="display: inline-block;vertical-align:top; width: 70px;",
      numericInput(
        inputId = "min",
        label = h4("Minute:"),
        value = 0
      )),
      div(style="display: inline-block;vertical-align:top; width: 5px;"),
      div(style="display: inline-block;vertical-align:top; width: 70px;",
      numericInput(
        inputId = "sec",
        label = h4("Second:"),
        value = 0
      )),
      h2(span("Current Minecraft time"), style = "color: grey"),
      div(style="display: inline-block;vertical-align:top; width: 100px;",
      numericInput(
        inputId = "mc_hr",
        label = h4("Hour(0-23):"),
        value = 0
      )),
      div(style="display: inline-block;vertical-align:top; width: 5px;"),
      div(style="display: inline-block;vertical-align:top; width: 100px;",
      numericInput(
        inputId = "mc_min",
        label = h4("Minute:"),
        value = 0
      )
    )),
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
  "Legend spawn search by time",
  sidebarLayout(
    sidebarPanel(
      width = 4,
      selectInput("time", h4("Select a spawn time"),
                  choices = c("No time selected",unique(df$Spawn.times)),
                  selected = "No time selected"),
      p(" "),
      tags$img(
        src = "time.png",
        width = "100%"
      )
    ),
    mainPanel(
      width = 7,
      tableOutput("table1")
    )
  )
)

# Third page
third_page <- tabPanel(
  "Legend spawn search by name",
  sidebarLayout(
    sidebarPanel(
      width = 4,
      selectInput("name", h4("Select a legendary Pokemon name"),
                  choices = c("No name selected",unique(df$Pokemon)),
                  selected = "No name selected"),
      p(" "),
      tags$img(
        src = "sunglass.jpg",
        width = "100%"
      )
    ),
    mainPanel(
      width = 7,
      tableOutput("table2")
    )
  )
)

# Define ui
ui <- navbarPage(
  theme = shinytheme("united"),
  div(tags$img(src = "icon.png",
               style = "margin-top: -9px; padding-right:0px;padding-bottom:20px",
               height = 60)),
  windowTitle = "Pixelmon Tools",
  first_page,
  second_page,
  third_page
)
