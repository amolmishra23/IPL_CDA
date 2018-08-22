batsmanDismissals <- function(df,name="Batsman"){
    batsman <- wicketKind <-dismissal <- NULL
    DismissalType <- NULL
    b <-select(df,batsman,wicketKind)
    
    c <- summarise(group_by(b,batsman,wicketKind),dismissal=n())
    d <- mutate(c,wicketKind=paste(wicketKind,"(",dismissal,")",sep=""))
    names(d) <-c("batsman","DismissalType","dismissal")
    
    plot.title = paste(name,"- Dismissals")
    ggplot(d, aes(x="", y=dismissal, fill=DismissalType))+
        geom_bar(width=1,stat = "identity")+
        coord_polar("y", start=0) +
        ggtitle(plot.title)+theme(text = element_text(family="sans",size=15),
                                  plot.title = element_text(family="sans",size=25,hjust = 0.5))
    
}
