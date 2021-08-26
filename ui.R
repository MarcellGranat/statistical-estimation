ui <- dashboardPage(
  title = "Dashboard example",
  dashboardHeader(title = "Statisztika II."),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Mi ez a projekt?", tabName = "what", icon = icon("question")),
      menuItem("Nevezetes eloszlások", icon = icon("area-chart"), 
               menuSubItem("Normális", tabName = "normal")
               )
  )),
  dashboardBody(
    tabItems(
      tabItem(tabName = "normal",
              box(width = 8,
                  sliderInput(inputId = "normal_mean", label = "Várható érték", value = 0, min = -5, max = 5, step = .2),
                  sliderInput(inputId = "normal_sd", label = "Szórás", value = 1, min = 0, max = 5, step = .1),
                  selectInput(inputId = "normal_type", label = "Függvény:", 
                              choices = c("Eloszlás-függvény", "Sűrűség-függvény")
                              ),
                  plotOutput("normal_plot")
                  )
              )
    )
  )
)
