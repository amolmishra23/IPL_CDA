rankIPLBatsmen <- function() {
    battingDetails=batsman=runs=strikeRate=meanRuns=meanSR= NULL
    
    load("Chennai Super Kings-BattingDetails.RData")
    csk_details <- battingDetails
    load("Deccan Chargers-BattingDetails.RData")
    dc_details <- battingDetails
    load("Delhi Daredevils-BattingDetails.RData")
    dd_details <- battingDetails
    load("Kings XI Punjab-BattingDetails.RData")
    kxip_details <- battingDetails
    load("Kochi Tuskers Kerala-BattingDetails.RData")
    ktk_details <- battingDetails
    load("Kolkata Knight Riders-BattingDetails.RData")
    kkr_details <- battingDetails
    load("Mumbai Indians-BattingDetails.RData")
    mi_details <- battingDetails
    load("Pune Warriors-BattingDetails.RData")
    pw_details <- battingDetails
    load("Rajasthan Royals-BattingDetails.RData")
    rr_details <- battingDetails
    load("Royal Challengers Bangalore-BattingDetails.RData")
    rcb_details <- battingDetails
    load("Sunrisers Hyderabad-BattingDetails.RData")
    sh_details <- battingDetails
    load("Gujarat Lions-BattingDetails.RData")
    gl_details <- battingDetails
    load("Rising Pune Supergiants-BattingDetails.RData")
    rps_details <- battingDetails
    
    a <- select(csk_details,batsman,runs,strikeRate)
    b <- select(dc_details,batsman,runs,strikeRate)
    c <- select(dd_details,batsman,runs,strikeRate)
    d <- select(kxip_details,batsman,runs,strikeRate)
    e <- select(ktk_details,batsman,runs,strikeRate)
    f <- select(kkr_details,batsman,runs,strikeRate)
    g <- select(mi_details,batsman,runs,strikeRate)
    h <- select(pw_details,batsman,runs,strikeRate)
    i <- select(rr_details,batsman,runs,strikeRate)
    j <- select(rcb_details,batsman,runs,strikeRate)
    k <- select(sh_details,batsman,runs,strikeRate)
    l <- select(gl_details,batsman,runs,strikeRate)
    m <- select(rps_details,batsman,runs,strikeRate)
    
    df <- rbind(a,b,c,d,e,f,g,h,i,j,k,l,m)
    
    batsmen <- unique(df$batsman)
    
    o <- NULL
    n <- data.frame(name=character(0),matches=numeric(0),meanRuns=numeric(0),meanSR=numeric(0))
    for (x in 1:length(batsmen)){
        m <- filter(df,batsman==batsmen[x])
        m <- mutate(m,matches=n(),meanRuns=mean(runs),meanSR=mean(strikeRate))
        m <- select(m,batsman,matches,meanRuns,meanSR)
        n <- m[1,]
        o <- rbind(o,n)
    }
    
    # Select only players who have played 60 matches or more
    p <- filter(o,matches >= 60)
    
    IPLBatsmenRank <- arrange(p,desc(meanRuns),desc(meanSR))
    IPLBatsmenRank
}

