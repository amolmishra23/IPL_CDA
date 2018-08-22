bowlerCumulativeAvgEconRate <- function(df,name="Bowler"){
    economyRate=cs=no=NULL
    b <- select(df,economyRate)
    b$no<-seq.int(nrow(b))
    c <- select(b,no,economyRate)
    
    d <- mutate(c,cs=cumsum(economyRate)/no)
    plot.title= paste(name,"- Cum. avg Econ Rate vs No innings")
    ggplot(d) + geom_line(aes(x=no,y=cs),col="blue") +
        xlab("No of innings") + ylab("Cumulative Avg. Economy Rate") +
        ggtitle(plot.title)+theme(text = element_text(family="sans",size=15),
                                  plot.title = element_text(family="sans",size=25,hjust = 0.5))
}
