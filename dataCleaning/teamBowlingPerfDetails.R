teamBowlingPerfDetails <- function(match,theTeam,includeInfo=FALSE){
    includeInfo<-TRUE
    noBalls=wides=team=runs=bowler=wicketKind=wicketPlayerOut=NULL
    team=bowler=ball=wides=noballs=runsConceded=overs=over=NULL
    # Initialise to NULL
    l <- NULL

    # only selecting bowling details of target match
    a <-filter(match,team!=theTeam)
    sz <- dim(a)
    if(sz[1] == 0){
        return(NULL)
    }


    # to convert "1st.0.1" to "1st" "0"   "1"
    a1 <- unlist(strsplit(a$ball[1],"\\."))
    a2 <- paste(a1[1],"\\.",sep="")


    # only wides and noballs need to be included with runs for bowlers.
    # Note: byes and legbyes should not be included
    # adding a over number field also
    b <-  a %>%
        select(bowler,ball,noballs,wides,runs,wicketKind,wicketPlayerOut) %>%
        mutate(over=gsub(a2,"",ball)) %>%
        mutate(over=gsub("\\.\\d+","",over))

    
    # Calculate the number of maiden overs
    c <- summarise(group_by(b,bowler,over),sum(runs,wides,noballs))
    names(c) <- c("bowler","over","runsConceded")
    d <-summarize(group_by(c,bowler),maidens=sum(runsConceded==0))


    # Compute total runs conceded (runs_wides+noballs)
    e <- summarize(group_by(c,bowler),runs=sum(runsConceded))


    # Calculate the number of overs bowled by each bwler
    f <- select(c,bowler,over)
    g <- summarise(group_by(f,bowler),overs=length(unique(over)))


    #Compute number of wickets
    h <- b %>%
        select(bowler,wicketKind,wicketPlayerOut) %>%
        filter(wicketPlayerOut != "nobody")


    # i <- summarise(group_by(h,bowler),wickets=length(unique(wicketPlayerOut)))


    # Join the over & maidens
    j <- full_join(g,d,by="bowler")
    # Add runs
    k <- full_join(j,e,by="bowler")
    # Add wickets
    l <- full_join(k,h,by="bowler")


    # Remove unnecessary factors
    l$wicketPlayerOut <-factor(l$wicketPlayerOut)
    l$wicketKind <- factor(l$wicketKind)


    # Set as character to assign values
    l$wicketPlayerOut <- as.character(l$wicketPlayerOut)
    l$wicketKind <- as.character(l$wicketKind)


    # Set NAs to none
    if(sum(is.na(l$wicketKind)) != 0){
        l[is.na(l$wicketKind),]$wicketKind <-"none"
    }


    if(sum(is.na(l$wicketPlayerOut)) != 0){
        l[is.na(l$wicketPlayerOut),]$wicketPlayerOut="nobody"
    }
    l

    # Calculate strike rate
    l <- mutate(l,economyRate=round(((runs/overs)),2))


    # Determine the opposition
    t <- match$team != theTeam
    # Pick the 1st element

    t1 <- match$team[t]
    opposition <- as.character(t1[1])

    if(includeInfo == TRUE) {
        l$date <- a$date[1]
        l$venue <- a$venue[1]
        l$opposition <- opposition
        l$winner <- a$winner[1]
        l$result <- a$result[1]
    }

    l

}
