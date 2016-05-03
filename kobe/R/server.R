#init
cat("Server Start");

#libraries
library(shiny)
library(ggplot2)
library(data.table)

#globals
#setwd("Q:/dev/coursera/dp/jhu_dp_nk/kobe")
input_file <- "./data/data.csv"

#load data
kobe_data <- read.csv(input_file,header = TRUE, skipNul = TRUE, na.strings = c('NULL', 'NA'))

#filter out blank shot_made
kobe_data_train <- subset(kobe_data, !is.na(shot_made_flag)) 

#transform into data table
kobe_data_dt <- data.table(kobe_data_train)

#add home_away flag
kobe_data_dt$home_away <- grepl("vs.", kobe_data_dt$matchup)
kobe_data_dt$final_shot <- with(kobe_data_dt, minutes_remaining == 0 & seconds_remaining <= 12)

#aggregate by variables
kobe_data_agg_all <<- list()
for (agg_var in agg_vars) {
  kobe_data_agg <- kobe_data_dt[, list(
    sum=sum(shot_made_flag), 
    cnt=length(shot_made_flag), 
    mean=mean(shot_made_flag)
  ), by = c("shot_distance", "shot_type", agg_var)]
  kobe_data_agg_clean <- subset(kobe_data_agg, cnt > 10) 
  kobe_data_agg_clean$val <- as.numeric(substr(kobe_data_agg_clean$shot_type, 0, 1)) * kobe_data_agg_clean$mean
  kobe_data_agg_all[[agg_var]] <- kobe_data_agg_clean
}

shinyServer (
  function(input, output) {
    output$outAggVar <- renderPrint({input$inAggVar})
    output$kobe_plot <- renderPlot({
      ggplot(
        kobe_data_agg_all[[input$inAggVar]], 
        aes_string(x = "shot_distance", y = "val", colour = input$inAggVar, size = "cnt")
      ) + 
      geom_point(shape=1) + 
      geom_smooth() + 
      facet_wrap(as.formula(paste("~", input$inAggVar))) + 
      scale_y_continuous(limits=c(0.5, 1.5), name="Shot Value")
    })
  }
)