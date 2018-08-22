teamBatsmenVsBowlersAllOppnAllMatchesRept <- function(matches,theTeam,theRank=1)
{
    team=batsman=bowler=runs=runsScored=NULL
    a <-filter(matches,team==theTeam)
    b <-summarise(group_by(a,batsman,bowler),sum(runs))
    names(b) <- c("batsman","bowler","runs")
    
    c <- summarise(b,runsScored=sum(runs))
    d <- arrange(c,desc(runsScored))
    
    d<-mutate(d,rank=c(1:nrow(d)))
    e<-full_join(b,d,by="batsman")
    arrange(e,rank)
    f<-filter(e,rank==theRank)
    
    
    g<-group_by(f,bowler)%>%summarise(total=sum(runs))%>%arrange(desc(total))
    if (nrow(g)>20){
        h<-head(g,20)    
    } else{
        h <- head(g,now(g))
    }
    
    
    i<-filter(f,bowler %in% h$bowler )

    i <- i[complete.cases(i),]
    i    
    
}
