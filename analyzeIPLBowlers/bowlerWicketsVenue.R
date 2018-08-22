bowlerWicketsVenue <- function(df,name="Bowler"){
    meanWickets = numMatches =wickets = venue = NULL
    c <- summarise(group_by(df,venue),meanWickets=mean(wickets),numMatches=n())
    d <- mutate(c,venue=paste(venue,"(",numMatches,")",sep=""))
    e <- arrange(d,desc(meanWickets))
    f <- e[1:20,]
    plot.title = paste(name,"- Wickets in venue(number innings)")
    ggplot(f, aes(x=reorder(venue, -meanWickets), y=meanWickets, fill=venue))+
        geom_bar(stat = "identity",position="dodge") +
        geom_hline(aes(yintercept=2))+
        xlab("Venue") + ylab("Average wickets taken") +
        ggtitle(plot.title)+
        theme(axis.text.x = element_text(angle = 90, hjust = 1))
}
