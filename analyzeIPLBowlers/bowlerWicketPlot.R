# based on how many overs he bowled in a match, what was average wickets
bowlerWicketPlot <- function(df,name="Bowler"){
    overs = runs = maidens = meanRuns = wickets = bowler = meanWickets = NULL
    c <- summarise(group_by(df,overs),meanRuns=mean(runs),meanMaidens=mean(maidens),
                   meanWickets=mean(wickets))
    
    plot.title <- paste(name,"- Average wickets vs overs")
    ggplot(c,aes(x=factor(overs), y=meanWickets,fill=overs)) +
        geom_bar(data=c,stat="identity" ) +
        xlab("Overs") + ylab("Mean Wickets") +
        ggtitle(plot.title)+theme(plot.title = element_text(hjust = 0.5))
}