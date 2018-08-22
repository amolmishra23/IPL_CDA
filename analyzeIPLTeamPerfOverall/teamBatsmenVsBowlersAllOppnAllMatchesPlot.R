teamBatsmenVsBowlersAllOppnAllMatchesPlot <- function(df,plot=TRUE)
{
    runs=bowler=NULL
    bman <- df$batsman
    if(plot==TRUE){
        plot.title <- paste(bman,"-Performances against all bowlers")
        ggplot(data=df,aes(x=reorder(bowler,-runs),y=runs,fill=factor(bowler))) +
            facet_grid(~ batsman) + geom_bar(stat="identity") +
            ggtitle(plot.title) +
            theme(axis.text.x = element_text(angle = 90, hjust = 1))+
            theme(plot.title = element_text(size=20,hjust = 0.5))
    }else{
        df
    }
    
}