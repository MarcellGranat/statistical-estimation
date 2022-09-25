ui <- dashboardPage(
  title = "statistical-estimation",
  dashboardHeader(title = "Statistical estimation",
                  tags$li(a(href = 'https://marcellgranat.com',
                            img(src = 'myself-drawn.png',
                                title = "Company Home", height = "30px"),
                            style = "padding-top:10px; padding-bottom:10px;"),
                          class = "dropdown")),
  dashboardSidebar(
    shinyWidgets::materialSwitch(inputId = "confint", label = "Confidence interval", 
                   value = F, status = "info"),
    sidebarMenu(
      menuItem("About", tabName = "what", icon = icon("question")),
      menuItem("CLT", tabName = "clt", icon = icon("cubes")),
      menuItem("Notable distributions", icon = icon("area-chart"), 
               menuSubItem("Normal", tabName = "normal"),
               menuSubItem("Student T", tabName = "t"),
               menuSubItem("Chi-square", tabName = "chi"),
               menuSubItem("F", tabName = "f")
               )
  )),
  dashboardBody(
    tabItems(
      tabItem(tabName = "what", 
              box(width = 12, title = "About this project")
              ),
      tabItem(tabName = "clt", 
              box(
                title = "Central Limit Theorem",
                width = 12,
                  h3(
                    "The weight of the rolls is understood as the ratio of the given weight to the sum of all the roll weights to give the probability of a roll.
                       For example: if all the distributed weights are 6 and one of them was assinged to 1, then the probability of that single roll is 1/6."
                  ),
                inputPanel(
                  numericInput(
                    inputId = "cube_w0",
                    label = "Weight of roll 0",
                    value = 2
                  ),
                  numericInput(
                    inputId = "cube_w1",
                    label = "Weight of roll 1",
                    value = 1
                  ),
                  numericInput(
                    inputId = "cube_w2",
                    label = "Weight of roll 2",
                    value = 0
                  ),
                  numericInput(
                    inputId = "cube_w3",
                    label = "Weight of roll 3",
                    value = 1
                  ),
                  numericInput(
                    inputId = "cube_w4",
                    label = "Weight of roll 4",
                    value = 2
                  ),
                  numericInput(
                    inputId = "cube_w5",
                    label = "Weight of roll 5",
                    value = 0
                  ),
                  numericInput(
                    inputId = "cube_w6",
                    label = "Weight of roll 6",
                    value = 0
                  ),
                  
                  
                  sliderInput(
                    "cube_n",
                    "Number of dices",
                    min = 1,
                    max = 30,
                    value = 0
                  )
                ),
                plotOutput("cube_plot")
                
              )
              ),
      tabItem(tabName = "normal", title = "Normal",
              box(width = 8, title = "Normal distribution",
                  sliderInput(inputId = "normal_mean", label = "Expected value", value = 0, min = -5, max = 5, step = .2),
                  sliderInput(inputId = "normal_sd", label = "Standard deviation", value = 1, min = 0, max = 5, step = .1),
                  selectInput(inputId = "normal_type", label = "Function", 
                              choices = c("Distribution", "Density")
                              ),
                  plotOutput("normal_plot")
                  )
              ),
      tabItem(tabName = "t", title = "Student T",
        box(width = 8, title = "Student T",
        sliderInput(inputId = "t_df", "Degree of freedom", min = 1, value = 1, max = 120, step = 1),
        selectInput(inputId = "t_type", label = "Function", 
                    choices = c("Distribution", "Density")
        ),
        checkboxGroupInput(inputId = "t_extra", label = "Additional",
                           c("Normal distribution" = "normal",
                             "Cauchy distribution" = "cauchy")
                           ),
        plotOutput("t_plot")
        )
      ),
      tabItem(tabName = "chi", title = "Chi-squared", 
              box(width = 8, title = "Chi-squared distribution",
                  sliderInput(inputId = "chi_df", "Degree of freedom", min = 1, value = 1, max = 30, step = 1),
                  selectInput(inputId = "chi_type", label = "Function", 
                              choices = c("Distribution", "Density")),
                              plotOutput("chi_plot")
                  
              )
    ),
    tabItem(tabName = "f", title = "F distribution",
    box(
      width = 8, title = "F distribution",
      sliderInput(inputId = "f_df1", "Degree of freedom #1", min = 1, value = 1, max = 30, step = 1),
      sliderInput(inputId = "f_df2", "Degree of freedom #2", min = 1, value = 1, max = 30, step = 1),
      selectInput(inputId = "f_type", label = "Function", 
                  choices = c("Distribution", "Density")),
      plotOutput("f_plot")
    )
    )
  )
)
)
