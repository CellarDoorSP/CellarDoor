library(shiny)
library(shinydashboard)
library(shinyBS)
library(RODBC)

dbhandle <- odbcDriverConnect(
  'driver={SQL Server};server=satou.cset.oit.edu;database=KatieSP;uid=katie_hughes;pwd=Cactus#3')

booksCur <- sqlQuery(dbhandle, 'select BookTitle from Book where Finished = \'N\'')

ui <- dashboardPage(
  dashboardHeader(title="popup"),
  dashboardSidebar(disable = TRUE),
  dashboardBody(
    textOutput("ReadOut"),
    br(),
    textOutput("GoalOut"),
    br(),
    actionButton("popButton", "Popup"),
    actionButton("newBookButton", "New Book"),
    bsModal("Popup1", "Input Reading", "popButton",
            fluidRow(
              column(8, 
                     selectInput("bookSelect", 
                                 label = "Book: ", 
                                 choices = booksCur$BookTitle
                                )),
              column(5,
                     dateInput("readingDate",
                               label = "Reading Date: "))),
            fluidRow(
              column(3,
                     textInput("readText",
                               label = "Read: ",
                               value = "0")),
              column(3,
                     textInput("readingGoalText",
                               label = "Goal: ",
                               value = "0"))),
            fluidRow(
              column(3,
                     actionButton("pop1Submit","Submit")))
    ),
    bsModal("Popup2", "Input New Book", "newBookButton",
            fluidRow(
              column(6,
                     textInput("titleInput",
                               label = "Title: ")),
              column(3,
                     selectInput("bookType", 
                                 label = "Written or Audio: ",
                                 choices = c("Written", "Audio"),
                                 selected = "Written")),
              column(3,
                     textInput("totalInput",
                               label = "Total(pages/hours): "))),
            fluidRow(
              column(4,
                     textInput("authorInput",
                               label = "Author: ")),
              column(3,
                     selectInput("authorGender",
                                 label = "Gender",
                                 choices = c("Female", "Male"))),
              column(3,
                     selectInput("authorRace",
                                 label = "Race",
                                 choices = c("White", "Black", "Asian", "Latinx")))),
            fluidRow(
              column(4,
                     textInput("authorAge",
                               label = "Age(When Written): ")),
              column(3,
                     textInput("yearWritten",
                               label = "Year Written: ")),
              column(3,
                     selectInput("bookGenre",
                                 label = "Genre",
                                 choices = c("Classic", "Fantasy", "Sci-Fi", "Horror", "Thriller", 
                                             "Mystery", "Memoir", "Romance", "Other")))),
            fluidRow(
              column(3,
                    actionButton("pop2Submit", "Submit")))
    )
  )
)

server <- function(input, output, session) {
  values <- reactiveValues()
  values$read <- "0";
  values$goal <- "0";
  
  # output$ReadOut <- renderText({
  #   paste0("Current Read: ", values$read)
  # })
  # 
  # output$GoalOut <- renderText({
  #   if(values$goal != "0"){
  #   paste0("Current Goal: ", values$goal)}
  # })
  
  observeEvent(input$pop1Submit,{
    toggleModal(session, "Popup1", toggle="close")
    values$read <- input$readText
    values$goal <- input$readingGoalText
  })
  
  observeEvent(input$pop2Submit,{
    toggleModal(session, "Popup2", toggle="close")
  })
}

shinyApp(ui, server)
