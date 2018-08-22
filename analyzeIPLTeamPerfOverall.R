analyzeIPLTeamPerfOverall <- function(team,matchFunc,rankV,plotOrTable2,repType2) {
    IPLmatch <- paste("projectDataFrames/all_matches_all_oppositions/", team,".RData",sep="")
    load(IPLmatch)
    matchesDF <- matches
    
    if(plotOrTable2 == 1){
        val3=TRUE
    } else {
        val3= FALSE
    }
    
    print(repType2)
    
    if(matchFunc == "Team Batting Scorecard Overall"){
        teamBattingScorecardAllOppnAllMatches(matchesDF,team)
    } 
    else if (matchFunc == "Team Batsmen Partnerships Overall"){
        if(val3 == TRUE){
            teamBatsmenPartnershipAllOppnAllMatchesPlot(matchesDF,team,plot=val3)
        } else if(val3 == FALSE){
            if(repType2 ==1){
                teamBatsmenPartnershipAllOppnAllMatches(matchesDF,team,report="summary")
            } else if(repType2 ==2){
                teamBatsmenPartnershipAllOppnAllMatches(matchesDF,team,report="detailed")
            }
        }
    } 
    else if (matchFunc == "Team Batsmen vs Bowlers Overall"){
        if(val3 == TRUE){
           df <- teamBatsmenVsBowlersAllOppnAllMatchesRept(matchesDF,team,theRank=as.integer(rankV))
           teamBatsmenVsBowlersAllOppnAllMatchesPlot(df)
        } else {
            teamBatsmenVsBowlersAllOppnAllMatchesRept(matchesDF,team,theRank=as.integer(rankV))
        }
    } 
    else if(matchFunc == "Team Bowling Scorecard Overall"){
        teamBowlingScorecardAllOppnAllMatchesMain(matchesDF,theTeam=team)
    } 
    else if (matchFunc == "Team Bowler vs Batsmen Overall"){
        if(val3 == TRUE){
           df <- teamBowlersVsBatsmenAllOppnAllMatchesRept(matchesDF,team,rank=as.integer(rankV))  
           teamBowlersVsBatsmenAllOppnAllMatchesPlot(df)
        } else {
            teamBowlersVsBatsmenAllOppnAllMatchesRept(matchesDF,team,rank=as.integer(rankV))  
        }
    } 
    else if (matchFunc == "Team Bowler Wicket Kind Overall"){
        teamBowlingWicketKindAllOppnAllMatches(matchesDF,team,"All")
    }    
}
