---
title       : How effective is the NBA trend toward favoring 3-pointers?
subtitle    : Analysis based on Kobe Bryant Kaggle Data Set
author      : Nick Kravitz
job         : Coursera JHU Data Products Course
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : [bootstrap]            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## Introduction

1. There has been a conspicuous trend in recent years in the NBA for players to favor 3-point shots more so than in the past. Almost all of the all-time leaders of 3-pointers are either current players or recently retired (with the exception of Reggie Miller) 
2. Stephen Curry smashed the one-year season record for 3-pointers in 2015-16 with 402. The previous record (286) was also held by Stephen Curry. By comparison, one of the best point guards from the 1980s (Magic Johnson) scored 106 in his best year (1989-90) and averaged only 22 per season. 
3. A Rule Change prior to the 1994-95 season awarded three foul shots for any player fouled while attempting a three-point field goal. This rule change meant that 3-point shots were not defended as aggressively, and made the shot attempt more attractive. 
4. 3-pointers are a lower percentage shot for all players; however this is balanced by the fact they give a higher number of points for achieving them. To normalize these offsetting factors we should multiply them together to form a "Shot Value." For example, if a player can hit a 2-point shot with 50% accuracy, and a 3-point shot with 40% accuracy, he would receive shot values of 1.0 and 1.2 for 2 and 3 pointers respectively. In this case the player would have a more effective game contribution by focusing on 3-pointers.

--- .fifty

## Data

1. The data used for this analysis was taken from the Kaggle "Kobe Bryant Shot Selection" contest. This analysis is using the data for a completely different purpose than what is intended in the Kaggle contest.  https://www.kaggle.com/c/kobe-bryant-shot-selection
2. No statistical analysis was performed on the data. The goal of this project was simply to provide data presented visually and make conclusions through exploratory analysis. In a more complete project, exploratory plots would be combined with statistical analysis. 
3. Only a single player was used for this analysis. In a more complete project, we would examine many players from different teams over different seasons. 
4. Nevertheless, Kobe Bryant has a 19-year career; moreover he has staying with a single team (Los Angeles Lakers) throughout making this a control variable. Additionally, he has a rare ability for being versatile on the floor and being adept at many kids of shots, including both 2 and 3-point attempts. We therefore can still make valuable conclusions on his career data only. 

--- .class #id 

## Study

-  The project plots (developed in R/Shiny) can be found here: Link to Shiny Project
- The goal of these charts would be to answer some of the following questions through plot examination:
- Is Kobe more productive when shooting 2-point or 3-point shots? Does the answer change when a filter is applied (e.g. 4th quarter shots, when playing at home etc.)
- How does Kobe's performance change over time (split by **seasons** variable)? If Kobe were to come out of retirement and play in a future season, which shot type(s) should be focus on most?
- Kobe's most common shot zone (**shot_zone_basic** variable) is "Mid Range" - about 40% of total shots. Ironically Mid-Range shots also have the lowest shot value, consistenty below 1.0 for any distance. Should Kobe give up on Mid-range shots?
- A common strategy when the game clock is less than the shot clock is to hold the ball for a final shot in the last few seconds, as a defensive rebound cannot result in points. Is Kobe better or worse in these pressure situations? See **final_shot** variable (less than 12 seconds left on game clock)

--- .class #id 

## Conclusions

1. Kobe's overall shot percentages for 2 and 3 point shots are below. Note that 3-point shots provide a slightly better shot value overall for his entire career. (Reproducible R code is ommited but can be found in github)

```
##         shot_type total_shots made_shots  made_pct  shot_val
## 1: 2PT Field Goal       20285       9683 0.4773478 0.9546956
## 2: 3PT Field Goal        5412       1782 0.3292683 0.9878049
```
2. However when aggregating by additional variables, we sometimes get other conclusions. For example, lay-ups or other shots right under the basket (less than 1 foot away) have a very high shot value. 
3. Over time, Kobe's 3-point performance has degraded. In his latest few seasons his 2-point shots provide a better shot value. 
4. Despite being known as a clutch shooter, Kobe's shot performance tapers off during the 4th quarter. He also performs worse during a "final shot" (when game clock is less than 12 seconds). Note that Michael Jordan's performance generally went up when the game was on the line. 

--- .class #id 

## Follow up

1. This study could be improved in many ways:
2. Expand the study to show other players on many different teams. 
3. Expand the study to include statistiical analysis; in particular shot prediction. (This was the original intent of the Kaggle contest)

--- .class #id 





