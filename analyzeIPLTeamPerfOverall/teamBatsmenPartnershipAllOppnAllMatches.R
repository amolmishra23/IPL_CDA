teamBatsmenPartnershipAllOppnAllMatches <- function(matches,theTeam,report="summary"){

    team=batsman=nonStriker=runs=partnershipRuns=totalRuns=NULL
    a <-filter(matches,team==theTeam)
    #Get partnerships
    df <- data.frame(summarise(group_by(a,batsman,nonStriker),sum(runs)))
    names(df) <- c("batsman","nonStriker","partnershipRuns")
    b <- summarise(group_by(df,batsman),totalRuns=sum(partnershipRuns))
    c <- arrange(b,desc(totalRuns))
    d <- full_join(df,c,by="batsman")
    if(report == "detailed"){
        partnerships <- arrange(d,desc(totalRuns))
    } else{
        partnerships <- arrange(c,desc(totalRuns))
    }
    partnerships
}
