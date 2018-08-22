# CDAI (Comprehensive data analysis on IPL)


## Introduction
The Indian Premier League (IPL) is a professional Twenty20 cricket league in India contested during April and May every year by teams representing Indian cities. IPL is the most-attended cricket league in the world and is ranked sixth among all sports leagues. The brand value of IPL was estimated to be US$4.5 billion in 2015 by American Appraisal. The league was founded by the Board of Control for Cricket in India (BCCI) in 2008, has come long way to 2017 currently playing through 10 seasons, 637 matches. 

1. In this project, a detailed ball-by-ball dataset of all the matches played in the history of IPL, available on cricsheet website and do a comprehensive analysis of various aspects involved in the game along with pragmatic visualizations. 
2. Ranking of players in IPL according to their performance is a very essential step that would allow franchises and team managers to make prominent decisions in choosing their sides. Apart ranking them in usual methods, this project also ranks them by Deep Performance Index using few machine learning techniques.
3. Besides this, even during matches, selection of the eleven players, based on best ones in the team. 
4. Player's strength and weakness against a particular opponent, their performance on a particular pitch etc. Which batsman should be made to play against which bowler, etc can be of great utility.
4. In the end, predictions are also made on the success of forthcoming league’s matches using machine learning techniques.

## Terminologies and formulas used in this project

### Most valuable player index (MVPI) - Batsman

    MVPI = ( ( meanRuns/tour_meanRuns) + (meanSR/tour_meanSR) ) * totalRuns  
    

- meanruns is the average runs of batsman
- tour_meanruns is the average of all batsman in IPL tournament
- meansSr is the average strike rate of batsman
- tour_meanSR is the average strike rate of all batsman in IPL tournament
- totalRunstotal runs of the batsman


### Most valuable player index (MVPI) - Bowler


    MVPI = ( (meanWickets/tour_meanWickets) + (tour_meanER/meanER) ) * totalWickets


- meanWickets -average wickets taken by the bowler
- tour_meanWickets -average wickets taken by all the bowlers in the tournament
- tour_meaner – average economy rate of all the bowlers in the tournament
- meanER- average economy rate of the bowler
- totalWickets- total wickets taken by the bowler.

### Deep performance index (DPI) - Batsman

The Deep performance Index is found using five parameters for batsmen. The parameters are used to rank the players using random forest.

The parameters for batsmen include :

    HardHitter = (4*Fours + 6*Sixes) / Balls faced by player
    Finisher = Number of times Not Out/ Total number of played Innings
    FastScorer (Player batting strike rate)
    Consistent (Player batting average)
    RunningBetweenWickets (RBW) = (Run scored by player - (4*Fours + 6*Sixes))/ Number of balls faced without boundary

### Deep performance index (DPI) - Bowler

The Deep performance Index is found using five parameters for bowler. The parameters are used to rank the players using random forest.

The parameters for bowlers include :

    HardHitter = (4*Fours + 6*Sixes) / Balls faced by player
    Finisher = Number of times Not Out/ Total number of played Innings
    FastScorer (Player batting strike rate)
    Consistent (Player batting average)
    RunningBetweenWickets (RBW) = (Run scored by player - (4*Fours + 6*Sixes))/ Number of balls faced without boundary
    
## Usage

1. To use this project, its needed to have **R** and **R studio** latest version installed respectively.

2. After installing it, install the following packages:
	
	* yaml
	* dplyr
	* ggplot2
	* rpart
	* rpart.plot
	* scales
	* stringr
	* shiny
	* caret
	* randomForest
	* e1071
	
	To install a package execute:
		
		install.packages("package_name")

3. Clone the repository to your local system.
	
		git clone https://github.com/amolmishra23/CDAI.git
 
4. Now, open the *ui.R* script in R Studio. Runapp option should be visible in top right corner of the script editor. Click it. The shiny app is good to be used now. 

## Features

CDAI analyzes:

* Individual batsman performance
* Individual bowler performance
* Particular match
* Head to head between 2 teams
* Overall performance of a team
* Ranking of players using different indexes
* Prediction of outcomes of matches

