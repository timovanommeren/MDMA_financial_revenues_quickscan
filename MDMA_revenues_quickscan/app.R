
library(shiny)
library(bslib)
library(here)

# Define UI for application that draws a histogram
ui <- page_navbar(
  title = "Estimating MDMA Monopoly Revenues",
  theme = bs_theme(version = 5),
  
  # ---- PAGE 1: Assumptions ----
  nav_panel(
    "Assumptions",
    layout_sidebar(
      sidebar = sidebar(
        title = "Estimates",
        open = TRUE,            # keep sidebar open by default
        width = 360,            # tweak to taste
        # --- Inputs (moved here) ---
        h5("Intensity"),
        p(class = "text-muted small", "Average number of pills per session."),
        numericInput("intensity_mean", "Mean pills per session (μ)", value = 2, min = 0, step = 0.1),
        numericInput("intensity_sd",   "Spread (sd)",               value = 0.5, min = 0, step = 0.1),
        
        hr(),
        h5("Market capture"),
        p(class = "text-muted small", "Proportion of consumers who switch to the regulated market."),
        numericInput("mkr_point", "Point estimate", value = 0.8, min = 0, max = 1, step = 0.01),
        sliderInput("mkr_range", "Range", min = 0, max = 1, value = c(0.4, 0.9), step = 0.01),
        
        hr(),
        h5("Price & Cost (€/pill)"),
        p(class = "text-muted small", "Cost is total marginal cost per pill."),
        numericInput("price_point", "Price point estimate", value = 5, min = 0, step = 0.1),
        sliderInput("price_range", "Price range", min = 0, max = 20, value = c(3, 8), step = 0.1),
        numericInput("cost_point", "Cost point estimate", value = 2, min = 0, step = 0.1),
        sliderInput("cost_range", "Cost range", min = 0, max = 20, value = c(1, 8), step = 0.1)
      ),
      
      # ---- Main content (outputs) ----
      card(
        card_header("Point estimate (using point inputs)"),
        h1(textOutput("point_estimate"), class = "display-5"),
        p(class = "text-muted small",
          "Revenue = Number of consumers × Intensity × Market capture × (Price − Cost)."
        )
      ),
      
      # Placeholder for the plot we’ll add later
      card(
        card_header("Simulation results (coming soon)"),
        p("We will add a Monte Carlo plot here.")
      )
    )
  ),
  
  # ---- PAGE 2 (blank for now) under a menu ----
  nav_menu(
    "More",
    nav_panel(
      "Frequency (coming soon)",
      fluidPage(
        h4("Frequency"),
        p("This page will host frequency inputs, data loading, and related outputs.")
      )
    )
  )
)

server <- function(input, output, session) {
  
  # Import empirical frequency 
  party_panel <- read.csv(here::here("data", "Party_Panel.csv"), check.names = FALSE)
  
  # drop the last five rows (your comment says five, not one)
  if (nrow(party_panel) >= 5) {
    party_panel <- party_panel[seq_len(nrow(party_panel) - 5), ]
  }
  
  party_panel[] <- lapply(party_panel, function(x) as.numeric(x))
  
  fr <- with(party_panel, sum(Gebruik * Frequencies, na.rm = TRUE) / sum(Frequencies, na.rm = TRUE))
  
  # Point estimate uses point inputs only
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
    
    number_consumers * fr * inten * mkr * (p - cst)
  })
  
  output$point_estimate <- renderPrint({
    # formatted output
    val <- revenue_point()
    paste0("€ ", format(round(val, 0), big.mark = ","))
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)
