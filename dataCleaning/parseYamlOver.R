parseYamlOver <- function(match,s,ateam,overs,delivery,meta) { 
  team=ball=totalRuns=rnames=batsman=bowler=nonStriker=NULL
  byes=legbyes=noballs=wides=nonBoundary=penalty=runs=NULL
  extras=wicketFielder=wicketKind=wicketPlayerOut=NULL
  
  for(i in 1:length(delivery)){
  
    #  extracting important details of a particular ball
    overset <- filter(match,grepl(s[i],rnames))
    over <- as.data.frame(t(overset))
    over <- over[2,]
    
    # checking the number of columns in df.
    d <- dim(over)
    
    if(d[2] == 6){
      names(over) <-c("batsman","bowler","nonStriker","runs","extras","totalRuns")
      # adding extra details
      over$byes<-as.factor(0)
      over$legbyes<-as.factor(0)
      over$noballs<-as.factor(0)
      over$wides<-as.factor(0)
      over$nonBoundary <- as.factor(0)
      over$penalty<-as.factor(0)
      over$wicketFielder="nobody"
      over$wicketKind="not-out"
      over$wicketPlayerOut="nobody"
      over$ball=gsub("\\\\.","",s[i])
      over$team = ateam
      over <- select(over, ball,team,batsman,bowler,nonStriker,
                     byes,legbyes,noballs,
                     wides,nonBoundary,penalty, runs,
                     extras,totalRuns,wicketFielder,
                     wicketKind,wicketPlayerOut)
      over <- cbind(over,meta)
      
    } else if(d[2]==7){
      # based on yaml file. it has 7 columns for a bowl, it is an extra
      if(sum(grepl("\\.byes",overset$rnames))){
        names(over) <-c("batsman","bowler","byes","nonStriker","runs","extras","totalRuns")
        over$legbyes=as.factor(0)
        over$noballs=as.factor(0)
        over$wides=as.factor(0)
        over$nonBoundary <- as.factor(0)
        over$penalty=as.factor(0)
      } 
      else if(sum(grepl("legbyes",overset$rnames))){
        names(over) <-c("batsman","bowler","legbyes","nonStriker","runs","extras","totalRuns")
        over$byes=as.factor(0)
        over$noballs=as.factor(0)
        over$wides=as.factor(0)
        over$nonBoundary <- as.factor(0)
        over$penalty=as.factor(0)
      } 
      else if(sum(grepl("noballs",overset$rnames))){
        names(over) <-c("batsman","bowler","noballs","nonStriker","runs","extras","totalRuns")
        over$byes=as.factor(0)
        over$legbyes=as.factor(0)
        over$wides=as.factor(0)
        over$nonBoundary <- as.factor(0)
        over$penalty=as.factor(0)
      } 
      else if(sum(grepl("wides",overset$rnames))){
        names(over) <-c("batsman","bowler","wides","nonStriker","runs","extras","totalRuns")
        over$byes=as.factor(0)
        over$legbyes=as.factor(0)
        over$noballs=as.factor(0)
        over$nonBoundary <- as.factor(0)
        over$penalty=as.factor(0)
      } else if(sum(grepl("non_boundary",overset$rnames))){
        cat("parse1=",i,"\n")
        names(over) <-c("batsman","bowler","nonStriker","runs","extras","nonBoundary","totalRuns")
        over$byes=as.factor(0)
        over$legbyes=as.factor(0)
        over$wides=as.factor(0)
        over$noballs=as.factor(0)
        over$penalty=as.factor(0)
      } else if(sum(grepl("penalty",overset$rnames))){
        names(over) <-c("batsman","bowler","penalty","nonStriker","runs","extras","totalRuns")
        over$byes=as.factor(0)
        over$legbyes=as.factor(0)
        over$noballs=as.factor(0)
        over$wides=as.factor(0)
        over$nonBoundary <- as.factor(0)
      }
      
      over$wicketFielder="nobody"
      over$wicketKind="not-out"
      over$wicketPlayerOut="nobody"
      over$ball=gsub("\\\\.","",s[i])
      over$team = ateam
      over <- select(over, ball,team,batsman,bowler, nonStriker,
                     byes,legbyes,noballs,
                     wides,nonBoundary,penalty, runs,
                     extras,totalRuns,wicketFielder,
                     wicketKind,wicketPlayerOut)
      over <- cbind(over,meta)
    } else if(d[2] ==8){
      # based on yaml file. it has 8 rows for a bowl, if it was an wicket.
      # if any fielder is not involved, and wicket was because of being bowled, its 8 rows.
      names(over) <-c("batsman","bowler","nonStriker","runs","extras","totalRuns",
                      "wicketKind","wicketPlayerOut")
      
      over$byes<-as.factor(0)
      over$legbyes<-as.factor(0)
      over$noballs<-as.factor(0)
      over$wides<-as.factor(0)
      over$nonBoundary <- as.factor(0)
      over$penalty<-as.factor(0)
      
      over$wicketFielder="nobody"
      over$ball=gsub("\\\\.","",s[i])
      over$team = ateam
      
      over <- select(over, ball,team,batsman,bowler,nonStriker,
                     byes,legbyes,noballs,
                     wides,nonBoundary,penalty,runs,
                     extras,totalRuns,wicketFielder,
                     wicketKind,wicketPlayerOut)
      over <- cbind(over,meta)
      
      
    } else if(d[2] ==9){ 
      # if a player was out, because of being caught. and fielder was involved here.
      names(over) <-c("batsman","bowler","nonStriker","runs","extras","totalRuns",
                      "wicketFielder","wicketKind","wicketPlayerOut")
      
      over$byes<-as.factor(0)
      over$legbyes<-as.factor(0)
      over$noballs<-as.factor(0)
      over$wides<-as.factor(0)
      over$nonBoundary <- as.factor(0)
      over$penalty<-as.factor(0)
      
      over$ball=gsub("\\\\.","",s[i])
      over$team = ateam
      over <- select(over, ball,team,batsman,bowler,nonStriker,
                     byes,legbyes,noballs,
                     wides,nonBoundary,penalty, runs,
                     extras,totalRuns,wicketFielder,
                     wicketKind,wicketPlayerOut)
      over <- cbind(over,meta)
      
    } else if(d[2] == 10) { 
      # Here also, it covers if there is a wicket on an extras ball
      if(sum(grepl("\\.byes",overset$rnames))){
        names(over) <-c("batsman","bowler","byes","nonStriker","runs","extras","totalRuns",
                        "wicketFielder","wicketKind","wicketPlayerOut")
        over$legbyes=as.factor(0)
        over$noballs=as.factor(0)
        over$wides=as.factor(0)
        over$nonBoundary <- as.factor(0)
        over$penalty<-as.factor(0)
      } else if(sum(grepl("legbyes",overset$rnames))){
        names(over) <-c("batsman","bowler","legbyes","nonStriker","runs","extras","totalRuns",
                        "wicketFielder","wicketKind","wicketPlayerOut")
        over$byes=as.factor(0)
        over$noballs=as.factor(0)
        over$wides=as.factor(0)
        over$nonBoundary <- as.factor(0)
        over$penalty<-as.factor(0)
      } else if(sum(grepl("noballs",overset$rnames))){
        names(over) <-c("batsman","bowler","noballs","nonStriker","runs","extras","totalRuns",
                        "wicketFielder","wicketKind","wicketPlayerOut")
        over$byes=as.factor(0)
        over$legbyes=as.factor(0)
        over$wides=as.factor(0)
        over$nonBoundary <- as.factor(0)
        over$penalty<-as.factor(0)
      } else if(sum(grepl("wides",overset$rnames))){
        names(over) <-c("batsman","bowler","wides","nonStriker","runs","extras","totalRuns",
                        "wicketFielder","wicketKind","wicketPlayerOut")
        over$byes=as.factor(0)
        over$legbyes=as.factor(0)
        over$noballs=as.factor(0)
        over$nonBoundary <- as.factor(0)
        over$penalty<-as.factor(0)
      } else if(sum(grepl("non_boundary",overset$rnames))){
        
        print("OOOOOO*************************************************")
        break
        over$byes=as.factor(0)
        over$legbyes=as.factor(0)
        over$wides=as.factor(0)
        over$noballs=as.factor(0)
        over$penalty=as.factor(0)
      } else if(sum(grepl("penalty",overset$rnames))){
        names(over) <-c("batsman","bowler","penalty","nonStriker","runs","extras","totalRuns")
        over$byes=as.factor(0)
        over$legbyes=as.factor(0)
        over$noballs=as.factor(0)
        over$wides=as.factor(0)
        over$nonBoundary <- as.factor(0)
      }
      
      over$ball=gsub("\\\\.","",s[i])
      over$team = ateam
      
      over <- select(over, ball,team,batsman,bowler,nonStriker,
                     byes,legbyes,noballs,
                     wides,nonBoundary,penalty,runs,
                     extras,totalRuns,wicketFielder,
                     wicketKind,wicketPlayerOut)
      over <- cbind(over,meta)
      
    }else if(d[2] == 0){
      # a skip condition
      next
    } 
    
    
    overs <- rbind(overs,over)
  }
  overs
}
  
