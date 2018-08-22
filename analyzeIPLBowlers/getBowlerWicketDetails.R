getBowlerWicketDetails <- function(team,name,dir="."){
    bowlingDetails=bowler=wicketPlayerOut=overs=maidens=NULL
    runs=economyRate=opposition=wickets=venue=NULL
    fl <- paste(dir,"/",team,"-BowlingDetails.RData",sep="")
    load(fl)
    details <- bowlingDetails
    bowlerDetails <- filter(details,grepl(name,bowler))
    bowlerDetails <- arrange(bowlerDetails,date)
    
    # Count wickets taken
    # Replace nobody by 0 wickets
    a <- bowlerDetails
    a$wickets <- 0
    a <- filter(a,wicketPlayerOut == "nobody")
    # a$wickets <- 0
    # a1 <- c <- select(a,bowler,overs,maidens,runs,economyRate,date,
    #                   opposition,wickets,venue)
    a1 <- c <- select(a,bowler,overs,maidens,runs,economyRate,date,
                      opposition,wickets,venue)
    # Get rows which have wickets
    b <- filter(bowlerDetails,wicketPlayerOut != "nobody")
    c <- select(b,bowler,overs,maidens,runs,economyRate,date,opposition,venue)
    # Count wickets
    d <- summarise(group_by(b,date),wickets=length(unique(wicketPlayerOut)))
    # Join tables
    e <- full_join(c,d,by="date")
    
    f <- rbind(a1,e)
    f <- select(f,bowler,overs,maidens,runs,wickets,economyRate,date,opposition,venue)
    g <- arrange(f,date)
    g
}
