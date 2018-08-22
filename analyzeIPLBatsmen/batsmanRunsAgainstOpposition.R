batsmanRunsAgainstOpposition <- function(df,name= "Batsman"){
    batsman = runs = opposition = meanRuns =  NULL
    b <- select(df,batsman,runs,opposition)
    c <-b[complete.cases(b),]
    d <- summarise(group_by(c,opposition),meanRuns=mean(runs),numMatches=n())
    plot.title = paste(name,"- Runs against opposition")
    ggplot(d, aes(x=opposition, y=meanRuns, fill=opposition))+
        geom_bar(stat = "identity",position="dodge") +
        xlab("Opposition") + ylab("Runs") +
        geom_hline(aes(yintercept=50))+
        ggtitle(plot.title)+theme(plot.title = element_text(family="sans",size=25,hjust = 0.5))
}
