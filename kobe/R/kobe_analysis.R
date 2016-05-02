setwd("Q:/dev/coursera/dp")
library(shiny)

cat("Init");
library(ggplot2)
library(data.table)

input_file <- "kobe/data.csv"

#load data
kobe_data = read.csv(input_file,header = TRUE, skipNul = TRUE, na.strings = c('NULL', 'NA'))

#filter out blank shot_made
kobe_data_train <- subset(kobe_data, !is.na(shot_made_flag)) 

#aggregate
kobe_data_dt <- data.table(kobe_data_train)

kobe_data_dt$home_away <- grepl("vs.", kobe_data_dt$matchup)
kobe_data_dt$final_shot <- with(kobe_data_dt, minutes_remaining == 0 & seconds_remaining <=24)



agg_vars = c("action_type", "combined_shot_type", "period", "season", "shot_type", "shot_zone_area", "shot_zone_area", "opponent")
agg_var = "period"

kobe_data_agg <- kobe_data_dt[, list(
  sum=sum(shot_made_flag), 
  cnt=length(shot_made_flag), 
  mean=mean(shot_made_flag)
), by = c("shot_distance", "shot_type", agg_var)]
kobe_data_agg_clean <- subset(kobe_data_agg, cnt > 10) 
kobe_data_agg_clean$val <- as.numeric(substr(kobe_data_agg_clean$shot_type, 0, 1)) * kobe_data_agg_clean$mean

p <- ggplot(
  kobe_data_agg_clean, 
  aes_string(x = "shot_distance", y = "val", colour = agg_var, size = "cnt")
) + geom_point(shape=1) + geom_smooth() 
p2 <- p + facet_wrap(as.formula(paste("~", agg_var))) + scale_y_continuous(limits=c(0, 2))
print(p2)

dim(kobe_data_agg_clean)
summary(kobe_data_train)
