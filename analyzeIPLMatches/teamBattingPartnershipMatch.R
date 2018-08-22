# of the total runs a batsman makes, who was on non-striker end while he was batting

teamBatsmenPartnershipMatch <- function(match,theTeam,opposition,plot=TRUE){
    team=batsman=nonStriker=runs=runsScored=NULL
    a <-filter(match,team==theTeam)
    # Group batsman with non strikers and compute partnerships
    df <- data.frame(summarise(group_by(a,batsman,nonStriker),sum(runs)))
    names(df) <- c("batsman","nonStriker","runs")

    df <- arrange(df,desc(runs))

    temp<-df %>% group_by(batsman) %>% summarise(total=sum(runs)) %>% arrange(desc(total))
    temp<-mutate(temp,rank=1:nrow(temp))
    
    df<-filter(df,batsman %in% temp$batsman)
    temp1<-full_join(df,temp,by=batsman)
    df<-arrange(temp1,rank)
    
    if(plot==TRUE){
        plot.title <- paste(theTeam,"Batting partnership in match (vs.",opposition,")")
        ggplot(data=df,aes(x=reorder(batsman,rank),y=runs,fill=nonStriker))+
            geom_bar(data=df,stat="identity") +
            xlab("Batmen") + ylab("Runs Scored") +
            ggtitle(plot.title) +
            theme(axis.text.x = element_text(angle = 90, hjust = 1))+
            theme(plot.title = element_text(size=20,hjust = 0.5))
    }
    else{
        df
    }
}