bowlerWicketsAgainstOpposition <- function(df,name="Bowler"){
    meanWickets = numMatches = wickets = opposition = NULL
    c <- summarise(group_by(df,opposition),meanWickets=mean(wickets),numMatches=n())
    d <- mutate(c,opposition=paste(opposition,"(",numMatches,")",sep=""))
    plot.title = paste(name,"- Wickets against Opposition(number innings)")
    ggplot(d, aes(x=opposition, y=meanWickets, fill=opposition))+
        geom_bar(stat = "identity",position="dodge") +
        geom_hline(aes(yintercept=2))+
        xlab("Opposition") + ylab("Average wickets taken") +
        ggtitle(plot.title)+theme(text = element_text(family="sans",size=15),
                                  plot.title = element_text(family="sans",size=25,hjust = 0.5))
}