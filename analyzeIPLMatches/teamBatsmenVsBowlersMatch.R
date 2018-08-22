teamBatsmenVsBowlersMatch <- function(match,theTeam,opposition, plot=TRUE)
{
    team=batsman=bowler=runs=runsConceded=NULL
    a <-filter(match,team==theTeam)
    # Summarise the performance of the batsmen against the bowlers vs total runs scored
    b <-summarise(group_by(a,batsman,bowler),sum(runs))
    names(b) <- c("batsman","bowler","runsConceded")
    
    if(plot == TRUE){
        plot.title <- paste(theTeam,"Batsmen vs Bowlers in Match (vs.",opposition,")")
        # Plot the performance of the batsmen as a facted grid
        ggplot(data=b,aes(x=bowler,y=runsConceded,fill=factor(bowler))) +
            facet_grid(~ batsman) + geom_bar(stat="identity") +
            xlab("Opposition bowlers") + ylab("Runs scored") +
            ggtitle('Batsmen vs Bowlers in Match') +
            ggtitle(plot.title) +
            theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
            theme(plot.title = element_text(size=20,hjust = 0.5))
    }
    else{
        b
    }
}