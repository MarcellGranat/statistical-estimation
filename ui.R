ui <- dashboardPage(
  title = "Dashboard example",
  dashboardHeader(title = "Statisztika II."),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Mi ez a projekt?", tabName = "what", icon = icon("question")),
      menuItem("Centrális határeloszlás tétele", tabName = "cht", icon = icon("cubes")),
      menuItem("Nevezetes eloszlások", icon = icon("area-chart"), 
               menuSubItem("Normális", tabName = "normal"),
               menuSubItem("T-eloszlás", tabName = "t"),
               menuSubItem("Khi-négyzet", tabName = "chi"),
               menuSubItem("F-eloszlás", tabName = "f")
               )
  )),
  dashboardBody(
    tabItems(
      tabItem(tabName = "what", 
              box(width = 12, title = "Mi ez a projekt")
              ),
      tabItem(tabName = "cht", 
              box(
                width = 12,
                  h3(
                    "A dobások súlya úgy értendő, hogy az adott súly és az összes dobási súly összegének hányadosából kaphatjuk meg az adott értékű dobás valószínűségét.
                       (Például: ha az összes kioszott súly 6 db és ebből 1-et kapott az 1-es dobás, akkor 1/6 a valószínűsége annak, hogy egy egyedi dobás értéke éppen 1-es.)"
                  ),
                inputPanel(
                  numericInput(
                    inputId = "cube_w0",
                    label = "0-ás dobásának súlya",
                    value = 2
                  ),
                  numericInput(
                    inputId = "cube_w1",
                    label = "1-es dobásának súlya",
                    value = 1
                  ),
                  numericInput(
                    inputId = "cube_w2",
                    label = "2-es dobásának súlya",
                    value = 0
                  ),
                  numericInput(
                    inputId = "cube_w3",
                    label = "3-as dobásának súlya",
                    value = 1
                  ),
                  numericInput(
                    inputId = "cube_w4",
                    label = "4-es dobásának súlya",
                    value = 2
                  ),
                  numericInput(
                    inputId = "cube_w5",
                    label = "5-ös dobásának súlya",
                    value = 0
                  ),
                  numericInput(
                    inputId = "cube_w6",
                    label = "6-os dobásának súlya",
                    value = 0
                  ),
                  
                  
                  sliderInput(
                    "cube_n",
                    "Dobások száma: ",
                    min = 1,
                    max = 30,
                    value = 0
                  )
                ),
                plotOutput("cube_plot")
                
              )
              ),
      tabItem(tabName = "normal",
              box(width = 8,
                  sliderInput(inputId = "normal_mean", label = "várható érték", value = 0, min = -5, max = 5, step = .2),
                  sliderInput(inputId = "normal_sd", label = "Szórás", value = 1, min = 0, max = 5, step = .1),
                  selectInput(inputId = "normal_type", label = "Függvény:", 
                              choices = c("Eloszlás-függvény", "Sűrűség-függvény")
                              ),
                  plotOutput("normal_plot")
                  )
              ),
      tabItem(tabName = "t", title = "Student-féle T-eloszlás",
        box(width = 8,
        sliderInput(inputId = "t_df", "Szabadságfok:", min = 1, value = 1, max = 120, step = 1),
        selectInput(inputId = "t_type", label = "Függvény:", 
                    choices = c("Eloszlás-függvény", "Sűrűség-függvény")
        ),
        checkboxGroupInput(inputId = "t_extra", label = "Megjelenít:",
                           c("Normális eloszlás" = "normal",
                             "Cauchy eloszlás" = "cauchy")
                           ),
        plotOutput("t_plot")
        )
      ),
      tabItem(tabName = "chi", title = "Khi-négyzet eloszlás", 
              box(width = 8,
                  sliderInput(inputId = "chi_df", "Szabadságfok:", min = 1, value = 1, max = 30, step = 1),
                  selectInput(inputId = "chi_type", label = "Függvény:", 
                              choices = c("Eloszlás-függvény", "Sűrűség-függvény")),
                              plotOutput("chi_plot")
                  
              )
    ),
    tabItem(tabName = "f", title = "F-eloszlás",
    box(
      width = 8, title = "F-eloszlás",
      sliderInput(inputId = "f_df1", "Szabadságfok #1:", min = 1, value = 1, max = 30, step = 1),
      sliderInput(inputId = "f_df2", "Szabadságfok #2:", min = 1, value = 1, max = 30, step = 1),
      selectInput(inputId = "f_type", label = "Függvény:", 
                  choices = c("Eloszlás-függvény", "Sűrűség-függvény")),
      plotOutput("f_plot")
    )
    )
  )
)
)
