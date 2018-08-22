teamBatsmenVsBowlersOppnAllMatches <- function(matches,main,opposition,plot=TRUE,top=5){
    team=batsman=bowler=runs=runsScored=NULL
    a <-filter(matches,team==main)
    
    
    top_bowlers<-summarise(group_by(a,bowler),total=sum(runs))%>% 
        arrange(desc(total)) %>% 
        select(bowler)
    top_bowlers<-head(top_bowlers,10)
    
    
    top_batsman<-summarise(group_by(a,batsman),total=sum(runs))%>% 
        arrange(desc(total)) %>% 
        select(batsman)
    top_batsman<-head(top_batsman,10)
    
    
    a<-filter(a,bowler %in% top_bowlers$bowler, batsman %in% top_batsman$batsman)
    
    b <-summarise(group_by(a,batsman,bowler),sum(runs))
    names(b) <- c("batsman","bowler","runs")
    c <- summarise(b,runsScored=sum(runs))
    d <- arrange(c,desc(runsScored))
    
    d <- head(d,top)
    
    batsmen <- as.character(d$batsman)
    e <- NULL
    for(i in 1:length(batsmen)){
        f <- filter(b,batsman==batsmen[i])
        e <- rbind(e,f)
        
    }
    if(plot == TRUE){
        plot.title = paste(main," Batsmen vs bowlers"," (against ",opposition," all matches)",sep="")
        ggplot(data=e,aes(x=bowler,y=runs,fill=factor(bowler))) +
            facet_grid(~ batsman) + geom_bar(stat="identity") +
            xlab("Bowler") + ylab("Runs Scored") +
            ggtitle(plot.title) +
            theme(axis.text.x = element_text(angle = 90, hjust = 1))+
            theme(plot.title = element_text(size=20,hjust = 0.5))
    }
    else{
        e
    }
}