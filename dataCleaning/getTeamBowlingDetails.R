
getTeamBowlingDetails <- function(team,dir=".",save=FALSE){
    overs=bowler=NULL
    # regular expression for searching the team details
    a <- paste(dir,"/","*",team,"*",sep="")
    # Gather team against all ooposition
    fl <- Sys.glob(a)
    bowlingDetails <- NULL
    for(i in 1:length(fl)){
        # loading the match file
        load(fl[i])
        # extracting the details from dataframe
        match <- overs
        # match contains the entire match dataframe
        # team contains name of the team
        # includeinfo is a flag here
        details <- teamBowlingPerfDetails(match,team,includeInfo=TRUE)
        # If the side has not batted details will be NULL. Skip in that case
        if(!is.null(dim(details))){
            bowlingDetails <- rbind(bowlingDetails,details)
        }else {
            #print("Empty")
            next
        }

    }

    if(save==TRUE){
        fl <- paste("./",team,"-BowlingDetails.RData",sep="")
        save(bowlingDetails,file=fl)
    }
    bowlingDetails <- arrange(bowlingDetails,bowler,date)
    bowlingDetails


}
