# for each time he has bowled 1/2/3/4 overs, what was his average economyRate

bowlerMeanEconomyRate <- function(df,name="Bowler"){
    overs =meanEconomyRate = economyRate = NULL
    c <- summarise(group_by(df,overs),meanEconomyRate=mean(economyRate))
    
    plot.title <- paste(name,"- Mean Economy Rate vs Overs")
    ggplot(c,aes(x=factor(overs), y=meanEconomyRate,fill=overs)) +
        geom_bar(data=c,stat="identity" ) +
        xlab("Overs") + ylab("Mean Economy Rate") +
        ggtitle(plot.title)+theme(text = element_text(family="sans",size=15),
                                  plot.title = element_text(family="sans",size=25,hjust = 0.5))
}