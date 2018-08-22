library(ggplot2)
library(dplyr)
library(yaml)
library(rpart)
library(rpart.plot)
library(scales)
library(lubridate)
library(stringr)


IPLBatsmanFuncs <- c("Batsman Runs vs. Deliveries",
                       "Dismissals of batsman",
                       "Batsman's Runs vs Strike Rate",
                       "Batsman's Moving Average",
                       "Batsman's Cumulative Average Runs",
                       "Batsman's Cumulative Strike Rate",
                       "Batsman's Runs against Opposition",
                       "Batsman's  Runs at Venue",
                       "Predict Runs of batsman")



IPLBowlerFuncs <- c("Mean Economy Rate of bowler",
                     "Mean runs conceded by bowler",
                     "Bowler's Moving Average",
                     "Bowler's Cumulative Avg. Wickets",
                     "Bowler's Cumulative Avg. Economy Rate",
                     "Bowler's Wicket Plot",
                     "Bowler's Wickets against opposition",
                     "Bowler's Wickets at Venues",
                     "Bowler's wickets prediction")

IPLMatchFuncs <- c("Match Batting Scorecard",
                   "Batting Partnerships",
                   "Batsmen vs Bowlers",
                   "Bowling Wicket Kind",
                   "Match Bowling Scorecard",
                   "Bowling Wicket Runs",
                   "Bowling Wicket Match",
                   "Bowler vs Batsmen",
                   "Match Worm Graph")


IPLMatches2TeamsFuncs <- c("Team Batsmen Batting Partnerships All Matches",
                           "Team Batting Scorecard All Matches",
                            "Team Batsmen vs Bowlers all Matches",
                            "Team Wickets Opposition All Matches",
                           "Team Bowling Scorecard All Matches",
                            "Team Bowler vs Batsmen All Matches",
                            "Team Bowlers Wicket Kind All Matches",
                            "Team Bowler Wicket Runs All Matches",
                            "Win Loss All Matches")

IPLTeamOverallPerfFunc <- c("Team Batsmen Partnerships Overall",
                            "Team Batting Scorecard Overall",
                           "Team Batsmen vs Bowlers Overall",
                           'Team Bowler vs Batsmen Overall',
                           "Team Bowling Scorecard Overall",
                           "Team Bowler Wicket Kind Overall")

IPLRanking <- c("Batting average ranking",
				"Batting MVPI ranking",
				"Batting DPI ranking",
				"Bowling average ranking",
				"Bowling MVPI ranking",
				"Bowling DPI ranking")

IPLTeamNames <- list("Chennai Super Kings","Deccan Chargers", "Delhi Daredevils","Kings Xi Punjab", 
                     "Kochi Tuskers Kerala","Kolkata Knight Riders","Mumbai Indians","Pune Warriors",
                     "Rajasthan Royals","Royal Challengers Bangalore","Sunrisers Hyderabad","Gujarat Lions",
                     "Rising Pune Supergiants")  
                     


IPLLast <- c("Mumbai Indians","Rising Pune Supergiant","Sunrisers Hyderabad",
                   "Kolkata Knight Riders","Kings XI Punjab","Delhi Daredevils",
                   "Gujarat Lions", "Royal Challengers Bangalore")

getBatsmen <- function(df){
    bmen <- df %>% distinct(batsman) 
    bmen <- as.character(bmen$batsman)
    batsmen <- sort(bmen)
}

find1 <- function(x, a){
    which(x==a)
}

getTeamIndex <- function(batsman){
    setwd("projectDataFrames/batsman")
    file_names<-list.files()
    lapply(file_names,load,.GlobalEnv)
    teams_batsmen = list(csk_batsmen,dc_batsmen,dd_batsmen,kxp_batsmen,ktk_batsmen,kkr_batsmen,mi_batsmen,
                         pw_batsmen,rr_batsmen,rcb_batsmen,sh_batsmen,gl_batsmen,rps_batsmen)
    b <- NULL
    for (i in 1:length(teams_batsmen)){
        a <- which(teams_batsmen[[i]] == batsman)
        
        if(length(a) != 0)
            b <- c(b,i)
    }
    
    setwd("..")
    setwd("..")
    b
}

getTeams <- function(x){
    l <- NULL
    for (i in seq_along(x)){
        
        l <- c(l, IPLTeamNames[[x[i]]]) 
        
    }
    l
}


getBowlers <- function(df){
    bwlr <- df %>% distinct(bowler) 
    bwlr <- as.character(bwlr$bowler)
    bowler <- sort(bwlr)
}

getTeamIndex_bowler <- function(bowler){
    setwd("projectDataFrames/bowler")
    file_names<-list.files()
    invisible(lapply(file_names,load,.GlobalEnv))
    teams_bowlers = list(csk_bowler,dc_bowler,dd_bowler,kxp_bowler,ktk_bowler,kkr_bowler,mi_bowler,
                         pw_bowler,rr_bowler,rcb_bowler,sh_bowler,gl_bowler,rps_bowler)
    b <- NULL
    for (i in 1:length(teams_bowlers)){
        a <- which(teams_bowlers[[i]] == bowler)
        if(length(a) != 0){
            b <- c(b,i)
        }
    }
    setwd("..")
    setwd("..")
    b
}

analysis_files<-c("./analyzeIPLBatsmen.R","./analyzeIPLBowlers.R",
           "./analyzeIPLMatches.R","./analyzeIPLMatches2Teams.R",
           "./analyzeIPLTeamPerfOverall.R")
invisible(sapply((analysis_files),source))


folders<-c("analyzeIPLBatsmen","analyzeIPLBowlers",
           "analyzeIPLMatches","analyzeIPLMatches2Teams",
           "analyzeIPLTeamPerfOverall")

source("ranking/getRankTable.R")
source("ranking/plotIPLTeamRanking.R")

for (f in folders){
    full_path<-f
    invisible(sapply(list.files(full_path, full.names=TRUE),source))
}


    
load("./projectDataFrames/batsman/All_Batsman.RData")
IPLBatsmen <-sort(b)

load("./projectDataFrames/bowler/All_Bowlers.RData")
IPLBowlers <-sort(b)

a <-list.files("projectDataFrames/data/")
IPLMatches <- gsub(".RData","",a)

a1 <-list.files("projectDataFrames/all_matches/")
IPLMatches2Teams <- gsub(".RData","",a1)

a2 <-list.files("projectDataFrames/all_matches_all_oppositions/")
IPLTeamsAll <- gsub(".RData","",a2)
