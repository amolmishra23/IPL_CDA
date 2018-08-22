IPLTeamNames <- c("Chennai Super Kings","Deccan Chargers", "Delhi Daredevils","Kings Xi Punjab", 
                     "Kochi Tuskers Kerala","Kolkata Knight Riders","Mumbai Indians","Pune Warriors",
                     "Rajasthan Royals","Royal Challengers Bangalore","Sunrisers Hyderabad","Gujarat Lions",
                     "Rising Pune Supergiant")  

for (i in IPLTeamNames){
    for (j in IPLTeamNames){
        if(i!=j){
            getAllMatchesBetweenTeams(i,j,save=TRUE)        
        }
    }
}