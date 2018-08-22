plotWinLossBetweenTeams <- function(team1,team2){
    overs=NULL
    venue=winner=result=date=NULL
    # Create 2 filenames with both combinations of team1 and team2
    dir <- "projectDataFrames/data"
    d1 <- paste(team1,"-",team2,"*",sep="")
    d2 <- paste(team2,"-",team1,"*",sep="")
    path1=paste(dir,"/",d1,sep="")
    path2=paste(dir,"/",d2,sep="")
    # Capture both combinations
    fl1 <- Sys.glob(path1)
    fl2 <- Sys.glob(path2)
    fl3 <-c(fl1,fl2)
    
    # Create a data frame with all matches
    overs <- NULL
    w <- NULL
    for(i in 1:length(fl3)){
        load(fl3[i])
        o <- overs[1,]
        a <- select(o,date,venue,winner,result)
        w <- rbind(w,a)
        overs <- NULL
    }
    winLoss <- summarise(group_by(w,winner),count=n())
    
    x <- winLoss$winner=="NA"
    winLoss$winner <- as.character(winLoss$winner)
    if(sum(x) !=0) {
        winLoss[x,]$winner <-"NoResult"
    }
    
    plot.title <- paste("Number of wins in",team1," vs ",team2, " matches")
    ggplot(winLoss, aes(x=winner, y=count, fill=winner))+
        geom_bar(stat = "identity",position="dodge") +
        xlab("Winner") + ylab("Numer of Wins") +
        ggtitle(plot.title)+theme(plot.title = element_text(hjust = 0.5))+
        scale_y_continuous(breaks= pretty_breaks())
}
