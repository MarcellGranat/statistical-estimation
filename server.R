server <- function(input, output, session) {
  
  output$cube_plot <- renderPlot({
    
    w <- c(input$cube_w0, input$cube_w1, input$cube_w2, input$cube_w3, 
           input$cube_w4, input$cube_w5, input$cube_w)
    
    w <- w / sum(w)
    
    
    m <- max(ifelse(w==0, 0, 0:6))
    n <- input$cube_n # number of throws
    x <- 0:(m*n) 
    f <- w[1:(m+1)]
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
      geom_line(size = 1.35) +
      geom_point(size = 4) +
      labs(title = "", y = "Probability", x = "Sum of dices") +
      scale_y_continuous(expand = c(0, 0), limits = c(0, (max(w)*1.2)), labels = function(x) scales::percent(x, accuracy = 1)) +
      scale_x_continuous(expand = c(0, 0)) +
      theme(
        plot.margin = unit(c(1, 1, 1, 1), "cm"),
        axis.text.x = element_text(size = 20),
        axis.text.y = element_text(size = 20),
        axis.title = element_text(size = 20, face = "bold")
      ) + 
      theme_classic(base_size = 20)
    
  })
  
  output$normal_plot <- renderPlot({
    
    p <- ggplot(data = data.frame(x = c(-5, 5)), aes(x = x)) + 
      stat_function(geom = "area", fun = ifelse(input$normal_type == "Density", "dnorm", "pnorm"), 
                    args = list(input$normal_mean, input$normal_sd), alpha = .3, color = "black") + 
      scale_y_continuous(limits = c(0, ifelse(input$normal_type == "Density", .6, 1)), expand = c(0, 0)) + 
      labs(x = NULL, y = NULL) + 
      theme_classic(base_size = 20)
    if (input$confint) {
      x <- qnorm(p = c(0.025, 0.975), mean = input$normal_mean, sd = input$normal_sd)
      if (input$normal_type == "Density") {
        p + geom_vline(xintercept = x, size = 1.2, color = "red4") + 
          geom_text(aes(x = input$normal_mean, y = dnorm(input$normal_mean, input$normal_mean, input$normal_sd) / 2) , label = "95%", color = "red4", size = 10)
      } else {
        p + geom_vline(xintercept = x, size = 1.2, color = "red4") + 
          geom_text(aes(x = input$normal_mean, y = pnorm(input$normal_mean, input$normal_mean, input$normal_sd) / 2) , label = "95%", color = "red4", size = 10)
      }
    } else {
      p
    }
    
  }) 
  
  output$t_plot <- renderPlot({
    p <-  ggplot(data = data.frame(x = c(-5, 5)), aes(x = x)) + 
      theme_classic(base_size = 20)
    
    if ("normal" %in% input$t_extra) {
      p <- p + stat_function(geom = "line", mapping = aes(color = "Standard normal distribution", x = x),
                             fun = ifelse(input$t_type == "Density", "dnorm", "pnorm"), 
                             lty = 2, size = 1.3)
    }
    
    if ("cauchy" %in% input$t_extra) {
      p <- p + stat_function(geom = "line", mapping = aes(color = "Cauchy distribution", x = x),
                             fun = ifelse(input$t_type == "Density", "dcauchy", "pcauchy"),
                             lty = 2,  size = 1.3)
    }
    
    p + stat_function(geom = "area", fun = ifelse(input$t_type == "Density", "dt", "pt"), 
                      args = list(input$t_df), alpha = .3, color = "black") + 
      scale_y_continuous(limits = c(0, ifelse(input$t_type == "Density", .6, 1)), expand = c(0, 0)) + 
      labs(x = NULL, y = NULL) + 
      labs(color = NULL)
  })
  
  output$chi_plot <- renderPlot({
    ggplot(data = data.frame(x = c(0, 15)), aes(x = x)) + 
      stat_function(geom = "area", fun = ifelse(input$chi_type == "Density", "dchisq", "pchisq"), 
                    args = list(input$chi_df), alpha = .3, color = "black") + 
      scale_y_continuous(limits = c(0, ifelse(input$chi_type == "Density", .6, 1)), expand = c(0, 0)) + 
      labs(x = NULL, y = NULL) + 
      theme_classic(base_size = 20)
  })
  
  output$f_plot <- renderPlot({
    
    rm(df)
    
    ggplot(data = data.frame(x = c(0, 15)), aes(x = x)) + 
      stat_function(geom = "area", fun = ifelse(input$f_type == "Density", df, pf), args = list(input$f_df1, input$f_df2), alpha = .3, color = "black") + 
      scale_y_continuous(limits = c(0, ifelse(input$f_type == "Density", 1, 1)), expand = c(0, 0)) + 
      labs(x = NULL, y = NULL) + 
      theme_classic(base_size = 20)
  })
  
  
}