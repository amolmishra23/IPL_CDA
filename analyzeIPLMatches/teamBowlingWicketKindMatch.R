teamBowlingWicketKindMatch <- function(match,theTeam,opposition,plot=TRUE){
    noBalls=wides=team=runs=bowler=wicketKind=wicketPlayerOut=NULL
    team=bowler=ball=wides=noballs=runsConceded=overs=over=NULL
    # The performance of bowlers of the team is got when the other side is batting. Hence '!-"
    # Filter the bowler's performance
    a <-filter(match,team !=theTeam)
    
    # Compute the maidens,runs conceded and overs for the bowlers
    a1 <- unlist(strsplit(a$ball[1],"\\."))
    # Create a string for substitution 1st or 2nd
    a2 <- paste(a1[1],"\\.",sep="")
    # only wides and noballs need to be included with runs for bowlers.
    # Note: byes and legbyes should not be included
    b <-  a %>%
        select(bowler,ball,noballs,wides,runs,wicketKind,wicketPlayerOut) %>%
        mutate(over=gsub(a2,"",ball)) %>%
        mutate(over=gsub("\\.\\d+","",over))
    
    #Calculate the number of maiden overs
    c <- summarise(group_by(b,bowler,over),sum(runs,wides,noballs))
    names(c) <- c("bowler","over","runsConceded")
    d <-summarize(group_by(c,bowler),maidens=sum(runsConceded==0))
    
    #Compute total runs conceded (runs_wides+noballs)
    e <- summarize(group_by(c,bowler),runs=sum(runsConceded))
    
    #Compute number of wickets
    h <- b %>%
        select(bowler,wicketKind,wicketPlayerOut) %>%
        filter(wicketPlayerOut != "nobody")
    i <- summarise(group_by(h,bowler),wickets=length(unique(wicketPlayerOut)))
    
    j <- full_join(h,e,by="bowler")
    
    # Make as.character to assign values
    j$wicketKind = as.character(j$wicketKind)
    j$wicketPlayerOut = as.character(j$wicketPlayerOut)
    # Set NAs to 0
    if(sum(is.na(j$wicketKind) !=0)){
        j[is.na(j$wicketKind),]$wicketKind="noWicket"
    }
    if(sum(is.na(j$wicketPlayerOut) != 0)){
        j[is.na(j$wicketPlayerOut),]$wicketPlayerOut="noWicket"
    }
    
    if(plot == TRUE){
        plot.title <- paste(theTeam,"Wicketkind vs Runs given (against",opposition,")")
        p <- ggplot(data=j,aes(x=wicketKind,y=runs,fill=factor(wicketKind))) +
            facet_grid(. ~ bowler,scales = "free_x", space = "free_x") +
            geom_bar(stat="identity") +
            xlab("Wicket kind") + ylab("Total runs conceded") +
            ggtitle(plot.title) +
            theme(axis.text.x = element_text(angle = 90, hjust = 1))  +
            theme(plot.title = element_text(size=20,hjust = 0.5))        
        p
    }
    else{
        j
    }
    
}
