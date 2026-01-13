#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
  titlePanel("MDMA Monopoly — Revenue Sandbox"),
  tags$p(
    "This shiny app compliments the Counting the Returns MDMA quickscan. In the quickscan, the potential revenue of a Dutch MDMA state-monopoly is estimated. Since a regulated MDMA market has no precedent, various assumptions had to be made. This shiny app has been developed to make it as easy as possible to calculate your own estimate(s) of the revunue of an MDMA state-monopoly based on your own assumptions.",
    "Revenue is calculated using the following formula:",
    "Number of consumers × Intensity × Market capture × (Price − Cost)."
  ),
  hr(),
  
  fluidRow(
    column(
      width = 4,
      h4("Intensity (Normal)"),
      numericInput("intensity_mean", "Mean pills per session (μ)", value = 2, min = 0, step = 0.1),
      numericInput("intensity_sd", "Spread (sd)", value = 0.5, min = 0, step = 0.1)
    ),
    column(
      width = 4,
      h4("Market capture"),
      numericInput("mkr_point", "Point estimate", value = 0.8, min = 0, max = 1, step = 0.01),
      sliderInput("mkr_range", "Range", min = 0, max = 1, value = c(0.4, 0.9), step = 0.01)
    ),
    column(
      width = 4,
      h4("Price & Cost (€/pill)"),
      numericInput("price_point", "Price point estimate", value = 5, min = 0, step = 0.1),
      sliderInput("price_range", "Price range", min = 0, max = 20, value = c(3, 8), step = 0.1),
      numericInput("cost_point", "Cost point estimate", value = 2, min = 0, step = 0.1),
      sliderInput("cost_range", "Cost range", min = 0, max = 20, value = c(1, 8), step = 0.1)
    )
  ),
  hr(),
  fluidRow(
    column(
      width = 12,
      h4("Point estimate (using point inputs)"),
      verbatimTextOutput("point_estimate")
    )
  )
)


server <- function(input, output, session) {
  # # Simple validation: clamp capture to [0,1] and avoid negative (already enforced by min/max)
  # observe({
  #   if (input$mkr_point < 0) updateNumericInput(session, "mkr_point", value = 0)
  #   if (input$mkr_point > 1) updateNumericInput(session, "mkr_point", value = 1)
  # })
  
  # Point estimate uses point inputs only (no frequency in this minimal step)
  revenue_point <- reactive({
    mkr  <- input$mkr_point
    p    <- input$price_point
    cst  <- input$cost_point
    inten <- input$intensity_mean
    
    # Ensure non-negative and handle price < cost gracefully (can produce negative revenue)
    mkr <- max(0, min(1, mkr))
    p   <- max(0, p)
    cst <- max(0, cst)
    inten <- max(0, inten)
    
    number_consumers * inten * mkr * (p - cst)
  })
  
  output$point_estimate <- renderPrint({
    # formatted output
    val <- revenue_point()
    paste0("€ ", format(round(val, 0), big.mark = ","))
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
