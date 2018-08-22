bowlingDetails=bowler=wickets=economyRate=meanWickets=meanER=NULL
source("analyzeIPLBowlers/getBowlerWicketDetails.R")
source("analyzeIPLBowlers/helper.R")

load("./projectDataFrames/bowler/All_Bowlers.RData")
all_bowlers <- b

o <- data.frame(bowler=character(0),wickets=numeric(0),economyRate=numeric(0))
bowlerDF <- NULL
df <- NULL
for (j in 1:length(all_bowlers)){
    df <- NULL
    bowlerDF <- NULL
    i <- getTeamIndex_bowler(all_bowlers[j])
    teamNames <- getTeams(i)
    for (i in seq_along(teamNames)){
        tryCatch(df <- getBowlerWicketDetails(team=teamNames[i],name=all_bowlers[j],dir="projectDataFrames/bowling"),
                 error = function(e) {
                 }
        )
        bowlerDF <- rbind(bowlerDF,df)     
    }
    if(!is.null(bowlerDF) && length(bowlerDF) > 0){
        bowlerDF[is.na(bowlerDF)] <- 0
        l <- distinct(bowlerDF,date,.keep_all = TRUE)
        l[is.na(l)] <- 0
        l1 <- l %>% group_by(bowler,wickets,economyRate) %>%  distinct(date)
        l2 <-summarise(group_by(l1,bowler),matches=n(),totalWickets=sum(wickets),meanWickets=mean(wickets),
                       meanER=mean(economyRate))
        o <-rbind(o,l2)       
    }
}


complete_data <- na.omit(o)
complete_data <- distinct(complete_data)
complete_data <- complete_data[!duplicated(complete_data[, c("bowler")]), ]
tour_meanWickets <- mean(complete_data$meanWickets)
tour_meanER <- mean(complete_data$meanER)
full_data <- complete_data
full_data <- mutate(full_data,MVPI=(((meanWickets/tour_meanWickets) + (tour_meanER/meanER)))*totalWickets)
bowler_MVPI <- arrange(full_data,desc(MVPI))
details <- paste("projectDataFrames/ranking","/","Bowler-MVPI.RData",sep="")
save(bowler_MVPI, file=details)
