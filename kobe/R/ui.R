library (shiny)
agg_vars <<- c(
  "action_type", 
  "combined_shot_type", 
  "minutes_remaining",
  "playoffs",
  "period", 
  "season", 
  "shot_type", 
  "shot_zone_area", 
  "shot_zone_basic", 
  "shot_zone_range",
  "team_name",
  "opponent", 
  "home_away",
  "final_shot"
)

shinyUI(fluidPage(
  titlePanel("Kobe Bryant Shot Analysis: Shot Value vs. Distance from Basket"),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "inAggVar",
        label = "Split Variable",
        choices = agg_vars,
        selected = "season"
      ),
      h4('Project Summary:'),
      div('In basketball, the probability of making a shot for most players is inversely related 
          to the distance from the basket. (Basic physics) However this probability is balanced by the fact that 
          when shooting from more than (approximately) 23ft. away from the basket, 3 points are 
          awarded for a shot made instead of the standard 2. To normalize the shot probability against the points awarded a
          "Shot Value" is created by multiplying these together. For example, if a player can hit
          a 2-point shot with 50% accuracy, and a 3-point shot with 40% accuracy, he would receive a 
          shot value of 1.0 and 1.2 for 2 and 3 pointers respectively. In this case the player would have 
          a better game contribution by focusing on 3-pointers, despite having a lower probability of shot success.
          The plots below plot Shot Value against Shot Distance, split by any Factor Variable in the data set. 
          The size of the data point represents the number of observations (shot count) and an unweighted LOESS 
          (local smoothing) curve has been fitted to the data.
          '),
      width = 4
    ),
    mainPanel(
      #h4('Plot Split by'),
      #verbatimTextOutput("outAggVar"),
      fluidRow (
          column(
            width = 10, 
            plotOutput(outputId = "kobe_plot", 
            height = "550px", 
            width="600px")
          )
      )
    ),
    fluid=TRUE
  ), 
  
    fluidRow(
      wellPanel(
        h4('Data:'),
        div('The following data comes from the Kaggle Kobe Bryant data set:'),
        a('https://www.kaggle.com/c/kobe-bryant-shot-selection'),
        div('Some calculated fields have been added (final shot, home vs. away).'),
        h4('Study:'),
        div('The plots would help a basketball strategist answer some of the following questions:'),
        tags$ul(
          tags$li('Is Kobe more productive when shooting 2-point or 3-point shots? Does the answer change when a filter is applied (e.g. 4th quarter shots, when playing at home etc.)'),
          tags$li('How does Kobe\'s performance change over time (split by seasons variable)? If Kobe were to come out of retirement and play in a future season, which shot type(s) should be focus on most?'),
          tags$li('Kobe\'s most common shot zone (shot_zone_basic variable) is "Mid Range" - about 40% of total shots. Ironically Mid-Range shots also have the lowest shot value, consistenty below 1.0 for any distance. Should Kobe give up on Mid-range shots?'),
          tags$li('A common strategy when the game clock is less than the shot clock is to hold the ball for a final shot in the last few seconds, as a defensive rebound cannot result in points. Is Kobe better or worse in these pressure situations? See final_shot variable (less than 12 seconds left on game clock)')
        ),
        h4('Conclusions:'),
        div('For conclusions and summary, see presentation here:'),
        a('http://rpubs.com/nickkz/kobe'),
        h4('Reproducible Code:'),
        div('For reproducible code, see github repo here:'),
        a('https://github.com/nickkz/jhu_dp_nk'),
        h4('Disclaimers:'),
        div('This project is completely unrelated to the Kaggle contest; it uses the data set for a completely different purpose. Normally a conclusive analysis would be based on both visual and statistical analyses; for the purpose of the assignment only a visual analysis was used to produce conclusions. A more complete analysis would include additional data such as foul shots and other offensive/defensive stats.')
      )
    )
  )  
)