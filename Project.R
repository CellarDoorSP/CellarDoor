library(shiny)
library(shinydashboard)

file.exists("~/.ssh/id_rsa.pub")

ui <- dashboardPage(
  dashboardHeader(title = "Cellar Door"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Current", tabName = "curr"),
      menuItem("Projections", tabName = "proj"),
      menuItem("What-If", tabName = "what"),
      menuItem("Journal", tabName = "jour")
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "curr",
              h2("Current Tab")),
      tabItem(tabName = "proj",
              h2("Projections Tab")),
      tabItem(tabName = "what",
              h2("What-If Tab")),
      tabItem(tabName = "jour",
              h2("Journal Tab"))
    )
  )
)

server <- function(input,output) {}

shinyApp(ui, server)