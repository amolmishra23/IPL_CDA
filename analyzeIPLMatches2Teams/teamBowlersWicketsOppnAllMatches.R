teamBowlersWicketsOppnAllMatches <- function(matches,main,opposition,plot=TRUE,top=20){
    
    team=bowler=ball=noballs=runs=NULL
    wicketKind=wicketPlayerOut=over=wickets=NULL
    batsman=wides=NULL
    
    a = NULL
    #Filter the matches by the team
    a <-filter(matches,team!=main)
    
    # only wides and noballs need to be included with runs for bowlers.
    # Note: byes and legbyes should not be included
    b <-  a %>%
        select(bowler,ball,noballs,wides,runs,wicketKind,wicketPlayerOut) %>%
        mutate(over=gsub("1st\\.","",ball)) %>%
        mutate(over=gsub("\\.\\d+","",over))
    
    #Compute number of wickets
    c <- b %>%
        select(bowler,wicketKind,wicketPlayerOut) %>%
        filter(wicketPlayerOut != "nobody")
    d <- summarise(group_by(c,bowler),wickets=length(unique(wicketPlayerOut)))
    
    e <- arrange(d,desc(wickets))
    # Display maximum or the requested 'top' size
    sz <- dim(e)
    if(sz[1] > top){
        e <- e[1:top,]
    }else{
        e <- e[1:sz[1],]
    }
    
    names(e) <- c("bowler","wickets")
    
    if(plot==TRUE){
        plot.title = paste(main," Bowler performances ","(against ",opposition," all matches)",sep="")
        ggplot(data=e,aes(x=reorder(bowler,-wickets),y=wickets,fill=factor(bowler))) +
            geom_bar(stat="identity",show.legend = F) +
            #facet_wrap( ~ bowler,scales = "free", ncol=3,drop=TRUE) + #Does not work.Check!
            xlab("Bowler") + ylab("Wickets taken") +
            ggtitle(plot.title)+
            theme(axis.text.x = element_text(angle = 90, hjust = 1))+
            theme(plot.title = element_text(size=20,hjust = 0.5))
    } else{
        e
    }
}
