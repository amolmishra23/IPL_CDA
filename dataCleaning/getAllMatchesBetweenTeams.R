getAllMatchesBetweenTeams <- function(team1,team2,dir=".",save=FALSE){
    
    overs=NULL
    # Create 2 filenames with both combinations of team1 and team2
    d1 <- paste(team1,"-",team2,"*",sep="")
    d2 <- paste(team2,"-",team1,"*",sep="")
    path1=paste(dir,"/",d1,sep="")
    path2=paste(dir,"/",d2,sep="")
    # Capture both combinations
    fl1 <- Sys.glob(path1)
    fl2 <- Sys.glob(path2)
    fl3 <-c(fl1,fl2)
    if(length(fl3) != 0){
        
        # Create a data frame with all matches
        matches <- NULL
        for(i in 1:length(fl3)){
            load(fl3[i])
            matches <- rbind(matches,overs)
        }
        b <- paste(team1,"-",team2,"-allMatches.RData",sep="")
        if(save){
            save(matches,file=b)
        }
        
        matches
    }
}
