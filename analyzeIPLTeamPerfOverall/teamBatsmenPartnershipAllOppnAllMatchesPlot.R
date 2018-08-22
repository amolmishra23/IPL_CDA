teamBatsmenPartnershipAllOppnAllMatchesPlot <- function(matches,theTeam,plot=TRUE){
    team=batsman=nonStriker=runs=partnershipRuns=totalRuns=NULL
    a <- NULL
    a <-filter(matches,team==theTeam)
    
    #Get partnerships
    df <- data.frame(summarise(group_by(a,batsman,nonStriker),sum(runs)))
    names(df) <- c("batsman","nonStriker","runs")
    
    df <- filter(df,runs!=0)
    df <- arrange(df,desc(runs))
    
    temp<-df %>% group_by(batsman) %>% summarise(total=sum(runs)) %>% arrange(desc(total))
    if (nrow(temp)>20){
        temp<-head(temp,20)
        temp<-mutate(temp,rank=1:20)    
    } else{
        temp <- head(temp,nrow(temp))
        temp <- mutate(temp,rank=1:nrow(temp))
    }
    
    
    df<-filter(df,batsman %in% temp$batsman)
    temp1<-full_join(df,temp,by=batsman)
    df<-arrange(temp1,rank)
    
    if(plot==TRUE){
        plot.title <- paste(theTeam," batting partnerships")
        ggplot(data=df,aes(x=reorder(batsman,rank),y=runs,fill=nonStriker))+
            geom_bar(data=df,stat="identity") +
            xlab("Batsman") + ylab("Partnership runs") +
            ggtitle(plot.title) +
            theme(axis.text.x = element_text(angle = 90, hjust = 1))+
            theme(plot.title = element_text(size=20,hjust = 0.5))
    } else{
        df
    }
}
