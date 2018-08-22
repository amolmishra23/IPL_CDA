batsmanCumulativeAverageRuns <- function(df,name="Batsman"){
    runs=cs=no=NULL
    b <- select(df,runs)
    b$no<-seq.int(nrow(b))
    c <- select(b,no,runs)
    
    d <- mutate(c,cs=cumsum(runs)/no)
    plot.title= paste(name,"- Cumulative Average vs No of innings")
    ggplot(d) + geom_line(aes(x=no,y=cs),col="blue") +
        xlab("No of innings") + ylab("Cumulative Avg. runs") +
        ggtitle(plot.title)+theme(text = element_text(family="sans",size=15),
                                  plot.title = element_text(family="sans",size=25,hjust = 0.5))
}
