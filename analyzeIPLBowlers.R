analyzeIPLBowlers <- function(IPLBowler,func) {
    i <- getTeamIndex_bowler(IPLBowler)
    
    teamNames <- getTeams(i)
    
    bowlerDF <- NULL
    
    
    # Create a consolidated Data frame of bowler for all IPL teams played
    for (i in seq_along(teamNames)){
        df <- getBowlerWicketDetails(team=teamNames[i],name=IPLBowler,dir="projectDataFrames/bowling")
        bowlerDF <- rbind(bowlerDF,df) 
        
    }
    bowlerDF[is.na(bowlerDF)]<-0
    # Call the necessary function
    if(func == "Mean Economy Rate of bowler"){
        bowlerMeanEconomyRate(bowlerDF,IPLBowler)
    } else if (func == "Mean runs conceded by bowler"){
        bowlerMeanRunsConceded(bowlerDF,IPLBowler)
    }     else if (func == "Bowler's Moving Average"){
        bowlerMovingAverage(bowlerDF,IPLBowler)
    } else if (func == "Bowler's Cumulative Avg. Wickets"){
        bowlerCumulativeAvgWickets(bowlerDF,IPLBowler)
    } else if (func == "Bowler's Cumulative Avg. Economy Rate"){
        bowlerCumulativeAvgEconRate(bowlerDF,IPLBowler)
    } else if (func == "Bowler's Wicket Plot"){
        bowlerWicketPlot(bowlerDF,IPLBowler)
    } else if (func == "Bowler's Wickets against opposition"){
        bowlerWicketsAgainstOpposition(bowlerDF,IPLBowler)
    } else if (func == "Bowler's Wickets at Venues"){
        bowlerWicketsVenue(bowlerDF,IPLBowler)
    } else if (func == "Bowler's wickets prediction"){
        # This is for the function wicket predict
        bowlerDF1 <- NULL
        # Create a consolidated Data frame of batsman for all IPL teams played
        for (i in seq_along(teamNames)){    
            # The below 2 lines for Bowler's wicket prediction
            df1 <- getDeliveryWickets(team=teamNames[i],dir="projectDataFrames/data",name=IPLBowler,save=FALSE)
            bowlerDF1 <- rbind(bowlerDF1,df1)
        }
        bowlerWktsPredict(bowlerDF1,IPLBowler)
    }
    
}