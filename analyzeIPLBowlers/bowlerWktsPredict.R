bowlerWktsPredict <- function(df,name="Bowler"){
    rpart = NULL
    m <-rpart(wicketNo~delivery,data=df)
    atitle <- paste(name,"- No of deliveries to Wicket")
    rpart.plot(m,main=atitle)
    # fancyRpartPlot(m,main=atitle,sub="Predicting bowler wickets",caption = "")
}
