batsmanRunsVsStrikeRate <- function(df,name= "Batsman"){
    batsman = runs = strikeRate = NULL
    b <- select(df,batsman,runs,strikeRate)
    
    plot.title = paste(name,"- Runs vs Strike Rate")
    ggplot(b) + geom_point(aes(x=runs, y=strikeRate),colour="darkgrey") +
        geom_smooth(aes(x=runs, y=strikeRate)) +
        xlab("Runs") + ylab("Strike rate") +
        ggtitle(plot.title)+theme(text = element_text(family="sans",size=15),
                                  plot.title = element_text(family="sans",size=25,hjust = 0.5))
}
