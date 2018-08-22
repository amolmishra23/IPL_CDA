analyzeIPLBatsmen <- function(IPLBatsman,func) {
    print(IPLBatsman)
    
    if(is.null(IPLBatsman))
        return()
    
    i <- getTeamIndex(IPLBatsman)
    
    teamNames <- getTeams(i)
    
    
    batsmanDF <- NULL
    for (i in seq_along(teamNames)){
        df <- getBatsmanDetails(team=teamNames[i],name=IPLBatsman,dir="projectDataFrames/batting")
        batsmanDF <- rbind(batsmanDF,df) 
    }
    if(func == "Batsman Runs vs. Deliveries"){
        batsmanRunsVsDeliveries(batsmanDF,IPLBatsman)
    }   else if (func == "Dismissals of batsman"){
        batsmanDismissals(batsmanDF,IPLBatsman)
    } else if (func == "Batsman's Runs vs Strike Rate"){
        batsmanRunsVsStrikeRate(batsmanDF,IPLBatsman)
    } else if (func == "Batsman's Moving Average"){
        batsmanMovingAverage(batsmanDF,IPLBatsman)
    } else if (func == "Batsman's Cumulative Average Runs"){
        batsmanCumulativeAverageRuns(batsmanDF,IPLBatsman)
    } else if (func == "Batsman's Cumulative Strike Rate"){
        batsmanCumulativeStrikeRate(batsmanDF,IPLBatsman)
    } else if (func == "Batsman's Runs against Opposition"){
        batsmanRunsAgainstOpposition(batsmanDF,IPLBatsman)
    } else if (func == "Batsman's  Runs at Venue"){
        batsmanRunsVenue(batsmanDF,IPLBatsman)
    } else if (func == "Predict Runs of batsman"){
        batsmanRunsPredict(batsmanDF,IPLBatsman)
    } 
}