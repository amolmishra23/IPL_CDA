analyzeIPLMatches <- function(match,matchFunc,plotOrTable,team,opposition) {

    IPLmatch <- paste("projectDataFrames/data/", match,".RData",sep="")
    load(IPLmatch)
    matchDF <- overs
    
    if(plotOrTable == 1){
        val=TRUE
    } else {
        val= FALSE
    }
    print(matchFunc)
    print(team)
    if(matchFunc == "Match Batting Scorecard"){
        teamBattingScorecardMatch(matchDF,team)
    } else if (matchFunc == "Batting Partnerships"){
        teamBatsmenPartnershipMatch(matchDF,team,opposition,plot=val)
    } else if (matchFunc == "Batsmen vs Bowlers"){
        teamBatsmenVsBowlersMatch(matchDF,team,opposition,plot=val)
    }  else if (matchFunc == "Match Bowling Scorecard"){
        teamBowlingScorecardMatch(matchDF,team)    
    } else if (matchFunc == "Bowling Wicket Kind"){
        teamBowlingWicketKindMatch(matchDF,team,opposition, plot=val)
    } else if (matchFunc == "Bowling Wicket Runs"){
        teamBowlingWicketRunsMatch(matchDF,team,opposition, plot=val)
    } else if (matchFunc == "Bowling Wicket Match"){
        teamBowlingWicketMatch(matchDF,team,opposition, plot=val)
    } else if (matchFunc == "Bowler vs Batsmen"){
        teamBowlersVsBatsmenMatch(matchDF,team,opposition, plot=val)
    } else if (matchFunc == "Match Worm Graph"){
        matchWormGraph(matchDF,team,opposition)
    }

    
}

