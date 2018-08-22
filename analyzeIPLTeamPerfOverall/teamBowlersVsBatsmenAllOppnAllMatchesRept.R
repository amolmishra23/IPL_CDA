teamBowlersVsBatsmenAllOppnAllMatchesRept <- function(matches,theTeam,rank=1) {
    batsman=runsConceded=team=runs=bowler=NULL
    team=bowler=batsman=NULL
    
    a <-filter(matches,team==theTeam)
    
    b <-summarise(group_by(a,bowler,batsman),sum(runs))
    names(b) <- c("bowler","batsman","runsConceded")
    # Compute total runs conceded
    c <- summarise(group_by(b,bowler),runs=sum(runsConceded))
    # Sort by descneding
    d <- arrange(c,desc(runs))
    
    
    # Initialise to NULL
    f <- NULL
    if(rank == 0){
        f <- head(d,10)
    } else { 
        bwlr <- d[rank,]
        f <- filter(b,bowler==bwlr$bowler)
        f <- arrange(f,desc(runsConceded))
    }
    f
    
    
}
