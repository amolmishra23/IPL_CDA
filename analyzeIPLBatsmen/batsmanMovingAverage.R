batsmanMovingAverage <- function(df,name = "Batsman"){
    batsman = runs = NULL
    b <- select(df,batsman,runs,date)
    
    plot.title = paste(name,"- Moving average of runs in career")
    ggplot(b) + geom_line(aes(x=date, y=runs),colour="darkgrey") +
        geom_smooth(aes(x=date, y=runs)) +
        xlab("Date") + ylab("Runs") +
        ggtitle(plot.title)+theme(text = element_text(family="sans",size=15),
                                  plot.title = element_text(family="sans",size=25,hjust = 0.5))
}