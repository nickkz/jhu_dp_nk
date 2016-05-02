library(ggplot2)

# Multiple plot function
#
# ggplot objects can be passed in ..., or to plotlist (as a list of ggplot objects)
# - cols:   Number of columns in layout
# - layout: A matrix specifying the layout. If present, 'cols' is ignored.
#
# If the layout is something like matrix(c(1,2,3,3), nrow=2, byrow=TRUE),
# then plot 1 will go in the upper left, 2 will go in the upper right, and
# 3 will go all the way across the bottom.
#
multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
  require(grid)
  
  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)
  
  numPlots = length(plots)
  
  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                     ncol = cols, nrow = ceiling(numPlots/cols))
  }
  
  if (numPlots==1) {
    print(plots[[1]])
    
  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
    
    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
      
      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}

myGGXYPlot <- function(df, inputVar, indicatorType = "hf") {
  indicatorVar = paste0("is_", indicatorType, "_customer")
  return (ggplot(
      df, 
      aes_string(x=inputVar, y=indicatorVar, colour=indicatorVar)
    ) + geom_jitter(width = 0.01, height = 0.01) +
    stat_smooth(method="glm", family="binomial", se=FALSE) + 
    ggtitle(inputVar)
  )
}

myGGBinPlot <- function(df, inputVar, indicatorType = "hf") {
  account.logit.single.hf <- glm(
    formula = paste("is_hf_customer ~", inputVar),
    data = df, 
    family = "binomial",
    na.action = na.exclude
  )
  nTile <- quantile(unique(df[,inputVar]), seq(0.01, 1, 0.01), na.rm=TRUE)
  nTileMid <- quantile(unique(df[,inputVar]), seq(0, 1, 0.01), na.rm=TRUE)
  myData <- data.frame(inputVar=nTile)
  colnames(myData) <- c(inputVar)
  
  yPredict <- predict(account.logit.single.hf, newdata=myData)
  yPredictOdds <- exp(yPredict) / (1 + exp(yPredict))
  yActual <- aggregate( 
    df$is_hf_customer ~ cut(
      df[,inputVar],
      breaks=nTileMid
    ), 
    FUN=mean
  )

  dfPredictOdds <- data.frame (x = as.vector(nTile), result = as.vector(yPredictOdds), actual_predict = "Predicted")
  if (length(nTile) == length(yActual[,2])) {
    dfActual <- data.frame (x = as.vector(nTile), result = yActual[,2], actual_predict="Actual")
    dfCombined <- rbind(dfActual, dfPredictOdds)
  } else {
    dfCombined <- dfPredictOdds
  }
  
  return (
    ggplot(
      dfCombined, 
      aes(x=x, y=result, color=actual_predict)) + 
      geom_point(shape=1)
    )
}
#print(myGGBinPlot(account_bureau_attr_training, "TRB01TOT", "hf")) 

myGGBoxPlot <- function(df, inputVar, indicatorType = "hf") {
  indicatorVar = paste0("as.factor(is_", indicatorType, "_customer)")
  return (
    ggplot(
      df, 
      aes_string(x = indicatorVar, y = inputVar)
    ) 
    + stat_boxplot(geom ="errorbar", width=0.5, position = "dodge") 
      + geom_boxplot(
          notch = FALSE, 
          colour=c("darkblue","darkgreen"), 
          outlier.colour = "red", 
          fill =c("lightblue","lightgreen"), 
          position = "dodge"
        )
  )
}