batsmanGenerator<-function(from_dir="C:/Users/Amol/Desktop/CDAI/projectDataFrames/batting",to_dir="C:/Users/Amol/Desktop/CDAI/projectDataFrames/batsman"){
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
        a <- paste(from_dir,"/",IPLTeamNames[i],"-BattingDetails.RData",sep="")
        load(a)
        batsman<-as.character(unique(battingDetails$batsman))
        team<-IPLTeamNames[i]
        details <- paste(to_dir,"/",team,"-BatsmanDetails.RData",sep="")
        new_name<-paste(team_names[i],"_batsmen",sep="")
        assign(new_name,batsman)
        save(list=new_name, file=details)
        b<-c(b,batsman)
    }
    b<-unique(b)
    b<-sort(b)
    details1 <- paste(to_dir,"/","All_Batsman.RData",sep="")
    save(b, file=details1)
}
