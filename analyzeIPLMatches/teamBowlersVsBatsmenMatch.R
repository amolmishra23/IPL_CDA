teamBowlersVsBatsmenMatch <- function(match,theTeam,opposition, plot=TRUE){
    
    batsman=runsConceded=team=runs=bowler=NULL
    bowler=batsman=NULL
    c <- filter(match,team !=theTeam)
    b <-summarise(group_by(c,bowler,batsman),sum(runs))
    names(b) <- c("bowler","batsman","runsConceded")
    
    # Output plot or dataframe
    if(plot == TRUE){
        plot.title <- paste(theTeam,"Bowler vs Batsman (against",opposition,")")
        p <- ggplot(data=b,aes(x=batsman,y=runsConceded,fill=factor(batsman))) +
            facet_grid(. ~ bowler) + geom_bar(stat="identity") +
            ggtitle(plot.title) +
            theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
            theme(plot.title = element_text(size=20,hjust = 0.5))
        p
    }
    else{
        b
    }
}
