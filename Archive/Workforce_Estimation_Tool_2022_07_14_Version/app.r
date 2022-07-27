install.packages("shiny")
library("shiny")

source("ui.R")
source("server.r")

shinyApp(ui = ui, server = server)