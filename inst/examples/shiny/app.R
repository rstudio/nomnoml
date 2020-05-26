library(shiny)
library(nomnoml)


make_diagram <- function(name){
  paste0("[hello]->[", name, "]")
}

ui <- fluidPage(
  titlePanel(title = "Using 'nomnoml' in shiny"),
  fluidRow(
      textInput("textbox", label = "Enter name:", value = "world")
  ),
  fluidRow(
      h2("Regular output"),
      nomnomlOutput(outputId = "diagram_canvas", height = "100px")
    ),
    fluidRow(
        h2("SVG output"),
        nomnomlOutput(outputId = "diagram_svg", height = "100px")
  )
)


server <- function(input, output) {
  
  diagram <- reactive({
    make_diagram(
      name = input$textbox
    )
  })
  
  output$diagram_canvas <- renderNomnoml({
    nomnoml(diagram(), svg = FALSE)
  })
  
  output$diagram_svg <- renderNomnoml({
    nomnoml(diagram(), svg = TRUE)
  })
  
  
}

shinyApp(ui, server)