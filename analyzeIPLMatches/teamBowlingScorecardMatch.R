teamBowlingScorecardMatch <- function(match,theTeam){
    noBalls=wides=team=runs=bowler=wicketKind=wicketPlayerOut=NULL
    team=bowler=ball=wides=noballs=runsConceded=overs=over=NULL
    
    # Compute the maidens,runs conceded and overs for the bowlers.
    # The bowlers performance of the team is got when the other side is batting. Hence '!-"
    
    a <-filter(match,team != theTeam)
    a1 <- unlist(strsplit(a$ball[1],"\\."))
    # Create a string for substitution 1st or 2nd
    a2 <- paste(a1[1],"\\.",sep="")
    
    # only wides and noballs need to be included with runs for bowlers.
    # Note: byes and legbyes should not be included
    
    # all these are done to convert 1st.2.6 to 2
    
    b <-  a %>%
        select(bowler,ball,noballs,wides,runs,wicketKind,wicketPlayerOut) %>%
        #mutate(over=gsub("1st\\.","",ball)) %>%
        mutate(over=gsub(a2,"",ball)) %>%
        mutate(over=gsub("\\.\\d+","",over))
    
    # this is used to get, per over how many runs were given
    c <- summarise(group_by(b,bowler,over),sum(runs,wides,noballs))
    names(c) <- c("bowler","over","runsConceded")
    # Calculate the number of maiden overs
    d <-summarize(group_by(c,bowler),maidens=sum(runsConceded==0))
    
    # Total runs conceded by a bowler
    e <- summarize(group_by(c,bowler),runs=sum(runsConceded))
    
    # Calculate the number of overs bowled by each bwler
    f <- select(c,bowler,over)
    g <- summarise(group_by(f,bowler),overs=length(unique(over)))
    
    
    #Compute number of wickets
    h <- b %>%
        select(bowler,wicketKind,wicketPlayerOut) %>%
        filter(wicketPlayerOut != "nobody")
    i <- summarise(group_by(h,bowler),wickets=length(unique(wicketPlayerOut)))
    
    #Join the over & maidens
    j <- full_join(g,d,by="bowler")
    # Add runs
    k <- full_join(j,e,by="bowler")
    # Add wickets
    l <- full_join(k,i,by="bowler")
    
    # Set NAs to 0
    if(sum(is.na(l$wickets)) != 0){
        l[is.na(l$wickets),]$wickets=0
    }
    l
}
