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
      p(""),
      tags$img(
        src = "time.png",
        width = "60%"
      ),
      p(" "),
      span(p("Disclaimer: The calculated spawn time should only be used as a
        reference, calculations might not be accurate due to time conversions
        from IRL to Minecraft"), style = "color:grey"),
      p(" ")
    )
  )
)

# Second page
second_page <- tabPanel(
  "Search legend spawns by conditions",
  sidebarLayout(
    sidebarPanel(
      width = 4,
      selectInput("time", "Select a spawn time",
                  choices = c("No time selected",unique(df$Spawn.times)),
                  selected = "No time selected"),
      selectInput("biome", "Select a spawn biome",
                  choices = ""
                  ),
      span(p("To search for a legend spawn by conditions simply select the
              desired time then choose a biome accordingly."),
           style = "color : gray"),
    ),
    mainPanel(
      width = 7,
      tableOutput("table1")
    )
  )
)

# Third page
third_page <- tabPanel(
  "Search legend spawns by name",
  sidebarLayout(
    sidebarPanel(
      width = 4,
      selectInput("name", "Select a legendary Pokemon name",
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

# How to
how_to <- tabPanel(
  "How to use" ,
  sidebarLayout(
    sidebarPanel(
      width = 3,
      h3("Mods needed"),
      strong("Journey Map"),
      p(" "),
      actionButton(inputId = "ab2",
                   label = "Download",
                   class = "btn-primary",
                   onclick = "window.open('https://www.curseforge.com/minecraft/mc-mods/journeymap/files', '_blank')"),
      p(" "),
      span(strong("OR"), style = "color: grey"),
      p(" "),
      strong("Time HUD"),
      p(" "),
      actionButton(inputId = "ab2",
                   label = "Download",
                   class = "btn-primary",
                   onclick = "window.open('https://www.curseforge.com/minecraft/mc-mods/time-hud/files', '_blank')"),
    ),
    mainPanel(
      h2("How to use the time calculator"),
      h4("For Journey Map:"),
      p("Make sure you have", strong("Game Time Real"), "as one of the options
        for your map, and use that time to calculate next
        legend spawn."),
      p(" "),
      h4("For Time HUD:"),
      p("Make sure your Time HUD format is on", strong("24 hour interval"),"if
        it isn't go to mod config in settings to change it."),
      p(" "),
      h2("More informations"),
      p("You can get more informations about legend spawns from the",
         tags$a(href="https://pixelmonmod.com/wiki/", "Pixelmon Wiki"),
        "website."),
      h4("Some useful links:"),
      tags$a(href="https://pixelmonmod.com/wiki/Legendary_Pokemon/",
             "Legendary Pokemon"),
      p(" "),
      tags$a(href="https://pixelmonmod.com/wiki/Spawn_time",
             "Pixelmon spawn times"),
      p(" "),
      h2("This website is made by"),
      p(strong("Discord"), ":", "Hackel#1337")
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
  third_page,
  how_to
)
