teamBowlersWicketRunsOppnAllMatches <- function(matches,main,opposition,plot=TRUE){

    team=bowler=ball=NULL
    runs=over=wickets=NULL
    byes=legbyes=noballs=wides=runsConceded=NULL
    extras=wicketFielder=wicketKind=wicketPlayerOut=NULL
    
    # Compute the maidens,runs conceded and overs for the bowlers
    a <- filter(matches,team !=main)
    
    # only wides and noballs need to be included with runs for bowlers.
    # Note: byes and legbyes should not be included
    # top_bowlers<-a %>% group_by(bowler)%>% summarise(total=sum(totalRuns))%>%arrange(desc(total))
    # top_bowlers<-head(top_bowlers,10)
    # 
    # a<-filter(a,bowler %in% top_bowlers$bowler)
    
    top_bowlers<-a %>% group_by(bowler)%>% summarise(count=n())%>%arrange(desc(count))
    top_bowlers<-head(top_bowlers,10)

    a<-filter(a,bowler %in% top_bowlers$bowler)

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
    
    l<-arrange(l,desc(runs))
    if(plot==TRUE){
        plot.title = paste("Wicket taken vs Runs conceded - ",main," Vs ",opposition,"(all matches)",sep="")
        ggplot(data=l,aes(x=reorder(bowler,-runs),y=runs,fill=factor(wickets))) +
            geom_bar(stat="identity") +
            xlab("Number of wickets") + ylab('Runs conceded') +
            ggtitle(plot.title) +
            theme(axis.text.x = element_text(angle = 90, hjust = 1))+
            theme(plot.title = element_text(size=20,hjust = 0.5))
    } else {
        l
    }
    
}
