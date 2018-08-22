# on average how many runs does the bowler give by the end of 1st/2nd/3rd/4th over
bowlerMeanRunsConceded <- function(df,name="Bowler"){
    overs = runs = maidens = meanRuns = wickets = NULL
    c <- summarise(group_by(df,overs),meanRuns=mean(runs),meanMaidens=mean(maidens),
                   meanWickets=mean(wickets))
    plot.title <- paste(name,"- Average runs conceded vs Overs")
    ggplot(c,aes(x=factor(overs), y=meanRuns,fill=overs)) +
        geom_bar(data=c,stat="identity" ) +
        xlab("Overs") + ylab("Average runs conceded") +
        ggtitle(plot.title)+theme(text = element_text(family="sans",size=15),
                                  plot.title = element_text(family="sans",size=25,hjust = 0.5))
}
