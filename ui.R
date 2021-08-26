ui <- dashboardPage(
  title = "Dashboard example",
  dashboardHeader(title = "Statisztika II."),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Mi ez a projekt?", tabName = "what", icon = icon("question")),
      menuItem("Centrális határeloszlás tétele", tabName = "cht", icon = icon("cubes")),
      menuItem("Newezetes eloszlások", icon = icon("area-chart"), 
               menuSubItem("Normális", tabName = "normal")
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
                  h6(
                    "A dobások súlya úgy értendő, hogy az adott súly és az összes dobási súly összegének hányadosából kaphatjuk meg az adott értékű dobás walószínűségét.
                       (Például: ha az összes kioszott súly 6 db és ebből 1-et kapott az 1-es dobás, akkor 1/6 a walószínűsége annak, hogy egy egyedi dobás értéke éppen 1-es.)"
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
                  sliderInput(inputId = "normal_mean", label = "wárható érték", value = 0, min = -5, max = 5, step = .2),
                  sliderInput(inputId = "normal_sd", label = "Szórás", value = 1, min = 0, max = 5, step = .1),
                  selectInput(inputId = "normal_type", label = "Függwény:", 
                              choices = c("Eloszlás-függwény", "Sűrűség-függwény")
                              ),
                  plotOutput("normal_plot")
                  )
              )
    )
  )
)
