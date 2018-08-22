bowlerGenerator<-function(from_dir="C:/Users/Amol/Desktop/CDAI/projectDataFrames/bowling",to_dir="C:/Users/Amol/Desktop/CDAI/projectDataFrames/bowler"){
    IPLTeamNames <- c("Chennai Super Kings","Deccan Chargers", "Delhi Daredevils","Kings Xi Punjab", 
                      "Kochi Tuskers Kerala","Kolkata Knight Riders","Mumbai Indians","Pune Warriors",
                      "Rajasthan Royals","Royal Challengers Bangalore","Sunrisers Hyderabad","Gujarat Lions",
                      "Rising Pune Supergiants") 
    team_names<-NULL
    for (team in IPLTeamNames){
        team_names<-append(team_names,paste(unlist(str_extract_all(team,"[[:upper:]]")),collapse=""))
    }
    team_names<-tolower(team_names)
    setwd(from_dir)
    b<-c()
    for (i in seq_along(IPLTeamNames)){
        a <- paste(from_dir,"/",IPLTeamNames[i],"-BowlingDetails.RData",sep="")
        load(a)
        bowler<-as.character(unique(bowlingDetails$bowler))
        team<-IPLTeamNames[i]
        details <- paste(to_dir,"/",team,"-BowlerDetails.RData",sep="")
        new_name<-paste(team_names[i],"_bowler",sep="")
        assign(new_name,bowler)
        save(list=new_name, file=details)
        b<-c(b,bowler)
    }
    b<-unique(b)
    b<-sort(b)
    details1 <- paste(to_dir,"/","All_Bowlers.RData",sep="")
    save(b, file=details1)
}
