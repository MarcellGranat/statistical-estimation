ui <- dashboardPage(
  title = "Dashboard example",
  dashboardHeader(title = "Statisztika II."),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("quetion")),
      menuItem("Nevezetes eloszlások", icon = icon("chart"), tabName = "distribution")
  )),
  dashboardBody()
)
