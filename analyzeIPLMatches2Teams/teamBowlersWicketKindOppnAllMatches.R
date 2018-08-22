teamBowlersWicketKindOppnAllMatches <- function(matches,main,opposition,plot=TRUE){
    team=bowler=ball=NULL
    runs=over=runsConceded=NULL
    
    byes=legbyes=noballs=wides=runConceded=NULL
    extras=wicketFielder=wicketKind=wicketPlayerOut=NULL
    # Compute the maidens,runs conceded and overs for the bowlers
    a <-filter(matches,team !=main)
    
    top_bowlers<-a %>% group_by(bowler)%>% summarise(count=n())%>%arrange(desc(count))
    top_bowlers<-head(top_bowlers,10)
    
    a<-filter(a,bowler %in% top_bowlers$bowler)
    
    # only wides and noballs need to be included with runs for bowlers.
    # Note: byes and legbyes should not be included
    b <-  a %>%
        select(bowler,ball,noballs,wides,runs,wicketKind,wicketPlayerOut) %>%
        mutate(over=gsub("1st\\.","",ball)) %>%
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
    
    r <- full_join(h,e,by="bowler")
    
    # Set NAs to 0
    if(sum(is.na(r$wicketKind)) != 0){
        r[is.na(r$wicketKind),]$wicketKind="noWicket"
    }
    if(sum(is.na(r$wicketPlayerOut)) !=0){
        r[is.na(r$wicketPlayerOut),]$wicketPlayerOut="noWicket"
    }
    
    z<-r%>%group_by(bowler,wicketKind)%>%summarise(count=n())
    
    
    
    if(plot == TRUE){
        plot.title = paste("Wicket kind taken by bowlers -",main," Vs ",opposition,"(all matches)",sep="")
        ggplot(data=z,aes(x=wicketKind,y=count,fill=factor(wicketKind))) +
            facet_wrap( ~ bowler,scales = "fixed", ncol=10) +
            geom_bar(stat="identity") +
            xlab("Wicket kind") + ylab("Number of Wickets") +
            ggtitle(plot.title) +
            theme(axis.text.x = element_text(angle = 90, hjust = 1))+
            theme(plot.title = element_text(size=20,hjust = 0.5))
    }
    else{
        z
    }
}
