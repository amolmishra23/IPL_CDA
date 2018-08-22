matchWormGraph <- function(match,t1,t2) {
    team=ball=totalRuns=NULL
    
    a <-filter(match,team==t1)
    b <- select(a,ball,totalRuns)
    if(grepl("1st",b$ball[1])){
        c <-mutate(b,ball=gsub("1st\\.","",ball))
    } else{
        c <-mutate(b,ball=gsub("2nd\\.","",ball))
    }
    
    d <- mutate(c,total=cumsum(totalRuns))
    
    a <-filter(match,team==t2)
    b1 <- select(a,ball,totalRuns)
    if(grepl("2nd",b1$ball[1])){
        c1 <-mutate(b1,ball=gsub("2nd\\.","",ball))
    } else{
        c1 <-mutate(b1,ball=gsub("1st\\.","",ball))
    }
    
    c<-c%>% mutate(team=t1)
    c1<-c1%>% mutate(team=t2)
    
    d<-rbind(c,c1)
    
    e<-group_by(d,team)%>%mutate(cs=cumsum(totalRuns))
    e$ball<-as.double(e$ball)
    e$team<-factor(e$team)
    
    plot.title<-"Worm chart of match"
    ggplot(e,aes(x=ball,y=cs,colour=team))+
        geom_line()+
        xlab("Overs") + ylab("Runs") +
        ggtitle(plot.title)+theme(plot.title = element_text(hjust = 0.5))
}
