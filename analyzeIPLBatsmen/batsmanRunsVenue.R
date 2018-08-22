batsmanRunsVenue <- function(df,name= "Batsman"){
    batsman = runs = venue = numMatches = meanRuns = NULL
    b <- select(df,batsman,runs,venue)
    c <- summarise(group_by(b,venue),meanRuns=mean(runs),numMatches=n())
    d <- mutate(c,venue=paste(venue,"(",numMatches,")",sep=""))
    e <- arrange(d,desc(numMatches))
    
    # Select only available rows or 25 rows
    sz <- dim(e)
    if(sz[1] > 25){
        f <- e[1:25,]
    } else{
        f <- e[1:sz[1],]
    }
    plot.title = paste(name,"- Mean runs at venue")
    ggplot(f, aes(x=venue, y=meanRuns, fill=venue))+
        geom_bar(stat = "identity",position="dodge") +
        geom_hline(aes(yintercept=50))+
        ggtitle(plot.title)+
        theme(axis.text.x = element_text(angle = 90, hjust = 1))
    
}
