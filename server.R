server <- function(input, output, session) {
 output$normal_plot <- renderPlot({
   ggplot(data = data.frame(x = c(-5, 5)), aes(x = x)) + 
     stat_function(geom = "area", fun = ifelse(input$normal_type == "Sűrűség-függvény", "dnorm", "pnorm"), args = list(input$normal_mean, input$normal_sd), alpha = .3, color = "black") + 
     scale_y_continuous(limits = c(0, ifelse(input$normal_type == "Sűrűség-függvény", .6, .9)), expand = c(0, 0))
 }) 
 
 output$cube_plot <- renderPlot({
   
   w=input$cube_w0+input$cube_w1+input$cube_w2+input$cube_w3+input$cube_w4+input$cube_w5+input$cube_w6
   
   w0=input$cube_w0/w
   w1=input$cube_w1/w
   w2=input$cube_w2/w
   w3=input$cube_w3/w
   w4=input$cube_w4/w
   w5=input$cube_w5/w
   w6=input$cube_w6/w
   w=vector()
   w[1]=w0; w[2]=w1; w[3]=w2; w[4]=w3; w[5]=w4; w[6]=w5; w[7]=w6
   m=max(ifelse(w==0,0,0:6))
   n=input$cube_n # number of throws
   x=0:(m*n) 
   f=w[1:(m+1)]
   if (n>1) {
     for (i in 2:n) {
       fo=f
       f=rep(0,(n*m+1))
       for (j in 1:(m*(i-1)+1)) {
         for (k in 1:(m+1)) {
           p=fo[j]*w[k]
           f[j+k-1]=f[j+k-1]+p
         }
       }
     }
   }
   
   ggplot(data.frame(x = x, f = f), aes(x, f)) +
     geom_line(size = 1.35, color = "black") +
     geom_point(size = 4, color = "black") +
     labs(title = "", y = "Valószínűség", x = "Dobások értékeinek összege") +
     scale_y_continuous(expand = c(0, 0), limits = c(0, (max(w)*1.2)), labels = function(x) scales::percent(x, accuracy = 1)) +
     scale_x_continuous(expand = c(0, 0)) +
     theme_bw() +
     theme(
       plot.margin = unit(c(1, 1, 1, 1), "cm"),
       axis.text.x = element_text(size = 20),
       axis.text.y = element_text(size = 20),
       axis.title = element_text(size = 20,face = "bold")
     )
   
 })
}