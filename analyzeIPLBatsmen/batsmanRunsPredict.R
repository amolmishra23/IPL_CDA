batsmanRunsPredict <- function(df,name= "Batsman"){
    
    batsman = ballsPlayed = runs = rpart =  NULL
    b <- select(df,ballsPlayed,runs, strikeRate,fours,sixes)
    names(b) <-c("deliveries","runs","strike rate","fours","sixes")
    m <-rpart(runs ~ .,data=b)
    atitle <- paste(name,"- Runs vs Required number of Deliveries")
    rpart.plot(m,main=atitle)
    # fancyRpartPlot(m,main=atitle,sub="Predicting batsman runs",caption = "")
}
