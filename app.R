# app.R

# Load libraries so they are available
library("shiny")

# Use source() to execute the `ui.R` and `server.R` files. These will
# define the UI value and server function respectively.
source("ui.R")
source("server.R")

# Create a new `shinyApp()` using the loaded `ui` and `server` variables
shinyApp(ui = ui, server = server)
