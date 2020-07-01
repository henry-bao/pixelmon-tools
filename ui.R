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
      div(style = "display: inline-block;vertical-align:top; width: 70px;",
          numericInput(
            inputId = "hour",
            label = h4("Hour:"),
            value = 0
          )),
      div(style = "display: inline-block;vertical-align:top; width: 5px;"),
      div(style = "display: inline-block;vertical-align:top; width: 70px;",
          numericInput(
            inputId = "min",
            label = h4("Minute:"),
            value = 0
          )),
      div(style = "display: inline-block;vertical-align:top; width: 5px;"),
      div(style = "display: inline-block;vertical-align:top; width: 70px;",
          numericInput(
            inputId = "sec",
            label = h4("Second:"),
            value = 0
          )),
      h2(span("Current Minecraft time"), style = "color: grey"),
      div(style = "display: inline-block;vertical-align:top; width: 100px;",
          numericInput(
            inputId = "mc_hr",
            label = h4("Hour(0-23):"),
            value = 0
          )),
      div(style = "display: inline-block;vertical-align:top; width: 5px;"),
      div(style = "display: inline-block;vertical-align:top; width: 100px;",
          numericInput(
            inputId = "mc_min",
            label = h4("Minute:"),
            value = 0
          )
      )),
    mainPanel(
      width = 7,
      span(h2("The next spawn time is:"), style = "color: grey"),
      h2(span(textOutput("result"), style = "color: #C8C8C8")),
      p(""),
      span(h2("Possible legendary spawn:"), style = "color:grey"),
      p(""),
      tableOutput("table3"),
      p(""),
      span(p("Disclaimer: The calculated spawn time should only be used as a
        reference, calculations might not be accurate due to time conversions
        from IRL to Minecraft"), style = "color:grey"),
      p("")
    )
  )
)

# Second page
second_page <- tabPanel(
  "Conditions",
  sidebarLayout(
    sidebarPanel(
      width = 4,
      selectInput("time", "Select a spawn time",
                  choices = c("No time selected", unique(df$Time)),
                  selected = "No time selected"),
      selectInput("biome", "Select a spawn biome",
                  choices = ""
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
  "Name",
  sidebarLayout(
    sidebarPanel(
      width = 4,
      selectInput("name", "Select a Pokemon name",
                  choices = c("No name selected", unique(df$Pokemon)),
                  selected = "No name selected"),
      p(""),
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

# Combine 2nd and 3rd page together
combined_page <- tabPanel(
  "Search legend spawns",
  tabsetPanel(second_page, third_page)
)

# How to
about <- tabPanel(
  "About",
  sidebarLayout(
    sidebarPanel(
      width = 3,
      h3("Mod needed"),
      strong("Journey Map"),
      p(""),
      actionButton(inputId = "ab2",
                   label = "Download",
                   class = "btn-primary",
                   onclick = "window.open('https://bit.ly/384GMSx', '_blank')"),
      p(""),
      span(strong("OR"), style = "color: grey"),
      p(""),
      strong("Time HUD"),
      p(""),
      actionButton(inputId = "ab2",
                   label = "Download",
                   class = "btn-primary",
                   onclick = "window.open('https://bit.ly/3i625aO', '_blank')"),
    ),
    mainPanel(
      h2("How to use the time calculator"),
      tabsetPanel(type = "tabs",
                  tabPanel("Journey Map",
                           h3("To set up your Journey Map mod:"),
                           p("Make sure you have",
                             strong("Game Time Real"), "as one of the options 
                           for your map, and use that time to calculate next 
                           legend spawn."),
                           p(""),
                           tags$img(
                             src = "jmap.png",
                             width = "100%"
                           ),
                           p(""),
                           tags$img(
                             src = "jmap1.png",
                             width = "100%"
                           ),
                           p(""),
                           tags$img(
                             src = "jmap2.png",
                             width = "100%"),
                           p("")
                  ),
                  tabPanel("Time HUD",
                           h3("To set up your Time HUD mod:"),
                           p("Make sure your Time HUD format is on",
                             strong("24 hour interval"), "if it isn't go to mod
                           config in settings to change it."),
                           p(""),
                           tags$img(
                             src = "timehud.png",
                             width = "100%"
                           ),
                           p(""),
                           tags$img(
                             src = "timehud2.png",
                             width = "100%"
                           ),
                           p(""),
                           tags$img(
                             src = "timehud3.png",
                             width = "100%"
                           ),
                           p(""),
                           tags$img(
                             src = "timehud4.png",
                             width = "100%"
                           ),
                           p(""),
                           tags$img(
                             src = "timehud5.png",
                             width = "100%"),
                           p("")
                  ),
                  tabPanel("More informations",
                           h3("Time conversion table:"),
                           tableOutput("table4"),
                           h3("Some useful links:"),
                           p("You can get more informations about legend spawns from the",
                             tags$a(href = "https://pixelmonmod.com/wiki/", "Pixelmon Wiki"),
                             "website."),
                           tags$a(href = "https://pixelmonmod.com/wiki/Legendary_Pokemon/",
                                  "Legendary Pokemon"),
                           p(""),
                           tags$a(href = "https://pixelmonmod.com/wiki/Spawn_time",
                                  "Pixelmon spawn times")
                  )
                  
      ),
      p(""),
      h3("This website is made by"),
      p(strong("Discord"), ":", "Hackel#1337"),
      p(""),
      span(h6("Legendary table updated on 07/01/2020"), style = "color:grey")
    )
  )
)

# Define ui
ui <- tagList(
  navbarPage(
    windowTitle = "Pixelmon Tools",
    theme = shinytheme("slate"),
    div(tags$img(src = "icon.png",
                 style =
                   "margin-top: -9px; padding-right:0px;padding-bottom:20px",
                 height = 60)),
    first_page,
    combined_page,
    about
  ),
  titlePanel(
    title = tags$head(tags$link(rel = "icon",
                                href = "icon.ico"))
  )
)
