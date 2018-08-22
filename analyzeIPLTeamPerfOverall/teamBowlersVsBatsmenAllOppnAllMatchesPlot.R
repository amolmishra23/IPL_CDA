teamBowlersVsBatsmenAllOppnAllMatchesPlot <- function(bowlerDF){
    batsman=runsConceded=team=NULL
    bwlr <- bowlerDF$bowler
    plot.title <- paste(bwlr,"-Performance against all batsmen")
    ggplot(data=bowlerDF,aes(x=reorder(batsman,-runsConceded),y=runsConceded,fill=factor(batsman))) +
        facet_grid(. ~ bowler) + geom_bar(stat="identity") +
        xlab("Batsman") + ylab("Runs conceded") +
        ggtitle(plot.title) +
        theme(axis.text.x = element_text(angle = 90, hjust = 1))+
        theme(plot.title = element_text(size=20,hjust = 0.5))
}