teamBowlersVsBatsmenOppnAllMatches <- function(matches,main,opposition,plot=TRUE,top=5){
    noBalls=wides=team=runs=bowler=wicketKind=wicketPlayerOut=NULL
    team=bowler=ball=wides=noballs=runsConceded=overs=batsman=NULL
    a <-filter(matches,team != main)
    
    top_bowlers<-summarise(group_by(a,bowler),total=sum(runs))%>% 
        arrange(desc(total)) %>% 
        select(bowler)
    top_bowlers<-head(top_bowlers,10)
    
    
    top_batsman<-summarise(group_by(a,batsman),total=sum(runs))%>% 
        arrange(desc(total)) %>% 
        select(batsman)
    top_batsman<-head(top_batsman,10)
    
    a<-filter(a,bowler %in% top_bowlers$bowler, batsman %in% top_batsman$batsman)
    
    b <-summarise(group_by(a,bowler,batsman),sum(runs))
    names(b) <- c("bowler","batsman","runsConceded")
    # Compute total runs conceded
    c <- summarise(group_by(b,bowler),runs=sum(runsConceded))
    # Sort by descneding
    d <- arrange(c,desc(runs))
    
    # Pick 5 highest run givers
    d <- head(d,top)
    
    bowlers <- as.character(d$bowler)
    e <- NULL
    for(i in 1:length(bowlers)){
        f <- filter(b,bowler==bowlers[i])
        e <- rbind(e,f)
        
    }
    names(e) <- c("bowler","batsman","runsConceded")
    
    if( plot == TRUE){
        plot.title = paste("Bowlers vs batsmen -",main," Vs ",opposition,"(all matches)",sep="")
        ggplot(data=e,aes(x=batsman,y=runsConceded,fill=factor(batsman))) +
            facet_grid(. ~ bowler) + geom_bar(stat="identity") +
            #facet_wrap( ~ bowler,scales = "free", ncol=3,drop=TRUE) + #Does not work.Check!
            xlab("Batsman") + ylab("Runs conceded") +
            ggtitle(plot.title) +
            theme(axis.text.x = element_text(angle = 90, hjust = 1))+
            theme(plot.title = element_text(size=20,hjust = 0.5))
    } else{
        e
    }
}
