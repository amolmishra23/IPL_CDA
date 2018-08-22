bowlerCumulativeAvgWickets <- function(df,name="Bowler"){
    wickets=cs=no=NULL
    b <- select(df,wickets)
    b$no<-seq.int(nrow(b))
    c <- select(b,no,wickets)
    
    d <- mutate(c,cs=cumsum(wickets)/no)
    plot.title= paste(name,"- Cumulative avg wkts vs No innings")
    ggplot(d) + geom_line(aes(x=no,y=cs),col="blue") +
        xlab("No of innings") + ylab("Cumulative Avg. wickets") +
        ggtitle(plot.title)+theme(text = element_text(family="sans",size=15),
                                  plot.title = element_text(family="sans",size=25,hjust = 0.5))
}
