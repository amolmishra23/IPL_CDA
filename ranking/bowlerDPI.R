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
        l1 <- l %>% group_by(bowler,wickets,runs,overs,economyRate) %>%  distinct(date)
        l2 <-summarise(group_by(l1,bowler),matches=n(),meanWickets=mean(wickets),
                       meanER=mean(economyRate),totalRuns=sum(runs),
                       totalWickets=sum(wickets),totalBalls=6*sum(overs),
                       fourWickets=nrow(l[l$wickets == 4,]),
                       fiveWickets=nrow(l[l$wickets == 5,]),
                       sixWickets=nrow(l[l$wickets == 6,]))
        o <-rbind(o,l2)       
    }
}


o[is.na(o)]<-0
o <- distinct(o)
o <- o[!duplicated(o[, c("bowler")]), ]
p <- arrange(o,desc(meanWickets),desc(meanER))
p <- mutate(p,bigWickets=(fourWickets+fiveWickets+sixWickets))

# 1) Economy(PBWER)= PRC/ (PBB/6)
# 2)WicketTaker (PBWA)= PBB / PWT
# 3) Consistent (PBWSR)= PRC / PWT
# 4) BigWicketTaker = Number of times four wickets or
# five wickets taken / Number of innings played
# 5) ShortPerformance = (Number of wickets taken -4*Number of times four wickets - 5* Number of timesfive wickets taken) /
#     (Number of innings played -Number of times four wickets or five wickets taken)

p <- mutate(p,PBWER=totalRuns/(totalBalls/6))
p <- mutate(p,PBWA=totalBalls/totalWickets)
p <- mutate(p,PBWSR=totalRuns/totalWickets)
p <- mutate(p,BWT=bigWickets/matches)
p <- mutate(p,ShortPerf=(totalWickets-4*fourWickets-5*fiveWickets-6*sixWickets)/(matches-bigWickets))


q <- do.call(data.frame, lapply(p, function(x) {
    replace(x, is.infinite(x) | is.na(x), 0)
})
)
bowler_DPI <- q
bowler_DPI <- distinct(bowler_DPI)
details1 <- paste("projectDataFrames/ranking","/","Bowler-DPI.RData",sep="")
save(bowler_DPI, file=details1)
