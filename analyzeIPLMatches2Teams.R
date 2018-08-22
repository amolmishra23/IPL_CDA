analyzeIPLMatches2Teams <- function(match2,matchFunc,plotOrTable1,repType, team,opposition) {
    IPLmatch <- paste("projectDataFrames/all_matches/", match2,".RData",sep="")
    load(IPLmatch)
    matchesDF <- matches
    
    if(plotOrTable1 == 1){
        val1=TRUE
    } else {
        val1= FALSE
    }
    
    print(repType)
    if(repType == 1){
        val2="summary"
    } else {
        val2= "detailed"
    }
    
    if(matchFunc == "Team Batting Scorecard All Matches"){
        teamBattingScorecardOppnAllMatches(matchesDF,team, opposition)
    } 
    else if (matchFunc == "Team Batsmen Batting Partnerships All Matches"){
        if(val1 == TRUE){
            teamBatsmenPartnershipOppnAllMatchesChart(matchesDF,team,opposition,plot=val1)
        } else if(val1 == FALSE){
            if(repType ==1){
                teamBatsmenPartnershiOppnAllMatches(matchesDF,team,report="summary")
            } else if(repType ==2){
                teamBatsmenPartnershiOppnAllMatches(matchesDF,team,report="detailed")
            }
        }
    } 
    else if (matchFunc == "Team Batsmen vs Bowlers all Matches"){
        teamBatsmenVsBowlersOppnAllMatches(matchesDF,team,opposition,plot=val1)
    }  
    else if (matchFunc == "Team Bowling Scorecard All Matches"){
        teamBowlingPerfOppnAllMatches(matchesDF,team, opposition)    
    } 
    else if (matchFunc == "Team Wickets Opposition All Matches"){
        teamBowlersWicketsOppnAllMatches(matchesDF,team,opposition,plot=val1)
    } 
    else if (matchFunc == "Team Bowler vs Batsmen All Matches"){
        teamBowlersVsBatsmenOppnAllMatches(matchesDF,team,opposition,plot=val1)
    } 
    else if (matchFunc == "Team Bowlers Wicket Kind All Matches"){
        teamBowlersWicketKindOppnAllMatches(matchesDF,team,opposition,plot=val1)
    } 
    else if (matchFunc == "Team Bowler Wicket Runs All Matches"){
        teamBowlersWicketRunsOppnAllMatches(matchesDF,team,opposition,plot=val1)
    } 
    else if (matchFunc == "Win Loss All Matches"){
        plotWinLossBetweenTeams(team,opposition)
    }
}