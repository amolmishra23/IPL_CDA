bowlerMovingAverage <- function(df,name="Bowler"){
    bowler = wickets = NULL
    c <- select(df,bowler,wickets,date)
    
    plot.title = paste(name,"- Moving average of wickets in career")
    ggplot(c) + geom_line(aes(x=date, y=wickets),colour="darkgrey") +
        geom_smooth(aes(x=date, y=wickets)) +
        xlab("Date") + ylab("Wickets") +
        ggtitle(plot.title)+theme(text = element_text(family="sans",size=15),
                                  plot.title = element_text(family="sans",size=25,hjust = 0.5))
}