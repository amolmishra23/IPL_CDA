batsmanCumulativeStrikeRate <- function(df,name= "Batsman"){
    strikeRate=cs=no=NULL
    b <- select(df,strikeRate)
    b$no<-seq.int(nrow(b))
    c <- select(b,no,strikeRate)
    
    d <- mutate(c,cs=cumsum(strikeRate)/no)
    plot.title= paste(name,"- Cumulative Strike Rate vs No of innings")
    ggplot(d) + geom_line(aes(x=no,y=cs),col="blue") +
        xlab("No of innings") + ylab("Cumulative Avg. Strike Rates") +
        ggtitle(plot.title)+theme(text = element_text(family="sans",size=15),
                                  plot.title = element_text(family="sans",size=25,hjust = 0.5))
}
