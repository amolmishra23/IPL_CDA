batsmanRunsVsDeliveries <- function(df,name= "Batsman"){
    batsman = runs  = ballsPlayed= NULL
    
    plot.title = paste(name,"- Runs vs balls faced")
    ggplot(df,aes(x=ballsPlayed,y=runs)) +
        geom_point(size=2) + geom_smooth() +
        xlab("Deliveries faced") + ylab("Runs") +
        ggtitle(plot.title)+theme(text = element_text(family="sans",size=15),
                                  plot.title = element_text(family="sans",size=25,hjust = 0.5))
    
}
