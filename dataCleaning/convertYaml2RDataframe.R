convertYaml2RDataframe <- function(yamlFile,sourceDir=".",targetDir="."){

  yaml.load_file=info.dates=info.match_type=info.overs=info.venue=NULL
  info.teams=matchType=winner=result=venue=NULL
  
  # declaring the file location
  pth = paste(sourceDir,"/",yamlFile,sep="")
  print(pth)
  
  # loading into R environment
  a <- yaml.load_file(pth)
  b <- as.data.frame(a)
  sz <- dim(b)
  
  # meta data related works
  meta <- select(b,info.dates,info.match_type,info.overs, info.venue,
                 info.teams)
  names(meta) <- c("date","matchType","overs","venue","team1")
  if(!is.null(b$info.outcome.winner)){
    meta$winner <- b$info.outcome.winner
    meta$result <- "NA"
  } else if(!is.null(b$info.result)){
    meta$winner <- "NA"
    meta$result <- b$info.result
  } else if(!is.null(b$info.outcome.result)){
    meta$winner <- "NA"
    meta$result <- b$info.outcome.result
  }

  meta$team2 = meta[2,5]
  meta <- meta[1,]
  meta <- select(meta,date,matchType,overs,venue,team1,team2,winner,result)
  
  # modifying column names as per our need
  names(b) <-gsub("innings.","",names(b))
  names(b) <- gsub("deliveries.","",names(b))
  
  # declaring fields needed in our final clean dataset
  overs <- data.frame(ball=character(),team=factor(),batsman=factor(),
                      bowler=factor(),nonStriker=factor(),byes=numeric(),
                      legbyes=numeric(), noballs=numeric(), wides=numeric(),
                      nonBoundary=factor(), penalty=factor(),
                      runs=factor(),extras=factor(),totalRuns=factor(),
                      wicketFielder=character(), wicketKind=character(),
                      wicketPlayerOut=character(),date=factor(),
                      matchType=factor(),
                      overs=integer(),venue=factor(),team1=factor(),team2=factor(),
                      winner=character(),result=character())
  
  
  # extracting match details
  idx = which(names(b) == "1st.0.1.batsman")
  m <- b[1,idx:sz[2]]
  match <- t(m)
  rnames <- rownames(match)
  match <- as.data.frame(cbind(rnames,match))
  numOver <- seq(from=0,to=20,by=1)
  
  d <- c(".1",".2",".3",".4",".5",".6",".7",".8",".9",".11",".12",
         ".13",".14",".15",".16")
  
  m <- 1
  delivery <- NULL
  for(k in 1:length(numOver)){
    for(l in 1:length(d)){
      delivery[m] <- paste(numOver[k],d[l],sep="")
      m=m+1
    }
  }
  
  
  print("first loop")
  s <- paste("1st.",delivery,"\\.",sep="")
  team1 <- b$`1st.team`[1]
  
  # match is entire match dataframe
  # s is for extracting columns from dataframe.f
  # team1 is name of team batting first
  # overs is the final dataframe where we are gonna store match details
  # delivery contains 16 balls each over, a vector
  # meta contains metadata of the match
  overs1 <- parseYamlOver(match,s,team1,overs,delivery,meta)
  
  
  print("second loop")
  s1 <- paste("2nd.",delivery,"\\.",sep="")
  team2 <- b$`2nd.team`[1]
  overs2 <- parseYamlOver(match,s1,team2,overs,delivery,meta)
  
  overs <- rbind(overs1,overs2)
  
  # converting all of it to character datatype from factor datatype
  overs$byes <- as.numeric(as.character(overs$byes))
  overs$legbyes <- as.numeric(as.character(overs$legbyes))
  overs$wides <- as.numeric(as.character(overs$wides))
  overs$noballs <- as.numeric(as.character(overs$noballs))
  overs$nonBoundary <- as.numeric(as.character(overs$nonBoundary))
  overs$penalty <- as.numeric(as.character(overs$penalty))
  overs$runs <- as.numeric(as.character(overs$runs))
  overs$extras <- as.numeric(as.character(overs$extras))
  overs$totalRuns <- as.numeric(as.character(overs$totalRuns))
  overs$date = as.Date(overs$date)
  overs$overs <- as.numeric(as.character(overs$overs))
  sapply(overs,class)
  
  # saving the final dataframe, and updating the file details
  teams <- as.character(unique(overs$team))
  filename <- paste(meta$team1,"-",meta$team2,"-",meta$date,".",
                    "RData",sep="")
  
  to <- paste(targetDir,"/",filename,sep="")
  save(overs,file=to)
  convertedFile <- paste(yamlFile,filename,sep=":")
  outputFile <- paste(targetDir,"/","convertedFiles.txt",sep="")
  write(convertedFile,outputFile,append=TRUE)



}



