server <- function(input, output, session) {
 output$normal_plot <- renderPlot({
   ggplot(data = data.frame(x = c(-5, 5)), aes(x = x)) + 
     stat_function(geom = "area", fun = ifelse(input$normal_type == "Sűrűség-függvény", "dnorm", "pnorm"), args = list(input$normal_mean, input$normal_sd), alpha = .3, color = "black") + 
     scale_y_continuous(limits = c(0, ifelse(input$normal_type == "Sűrűség-függvény", .6, .9)), expand = c(0, 0))
 }) 
}