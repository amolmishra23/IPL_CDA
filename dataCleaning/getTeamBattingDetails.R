
getTeamBattingDetails <- function(team,dir=".",save=FALSE){
    overs=batsman=NULL
    # regular expression for searching the team details
    a <- paste(dir,"/","*",team,"*",sep="")
    # Gather all the team match files
    fl <- Sys.glob(a)
    
    battingDetails <- NULL
    for(i in 1:length(fl)){
        # loading the match file
        load(fl[i])
        # extracting the details from dataframe
        match <- overs
        # match contains the entire match dataframe
        # team contains name of the team
        # includeinfo is a flag here
        details <- teamBattingPerfDetails(match,team,includeInfo=TRUE)
        # If a side has not batted, then details will be NULL. Skip in that case
        if(!is.null(dim(details))){
            battingDetails <- rbind(battingDetails,details)
        }else {
            #print("Empty")
            next
        }
    }
    if(save==TRUE){
        fl <- paste("./",team,"-BattingDetails.RData",sep="")
        save(battingDetails,file=fl)
    }
    battingDetails <- arrange(battingDetails,batsman,date)
    battingDetails
}



