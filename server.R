library(shiny)
library(yorkr)
library(rpart)
library(dplyr)
library(ggplot2)
library(rpart.plot)


source("init.R")


shinyServer(function(input, output,session) {
    
    # Analyze and display batsmen plots
    output$batsmanPlot <- renderPlot({  
        analyzeIPLBatsmen(input$batsman,input$batsmanFunc)
        
    })
    
    # Analyze and display bowler plots
    output$bowlerPlot <- renderPlot({  
        analyzeIPLBowlers(input$bowler,input$bowlerFunc)
        
    })
    
    # Analyze and display IPL Match plot
    output$IPLMatchPlot <- renderPlot({ 
        printOrPlotIPLMatch(input, output)
     
    })
    
    # Analyze and display IPL Match table
    output$IPLMatchPrint <- renderTable({ 
        a <- printOrPlotIPLMatch(input, output)
        a         
    })
    
    # Output either a table or a plot 
    output$plotOrPrintIPLMatch <-  renderUI({ 
        # Check if output is a dataframe. If so, print
        if(is.data.frame(scorecard <- printOrPlotIPLMatch(input, output))){
            tableOutput("IPLMatchPrint")
        }
        else{ #Else plot
            plotOutput("IPLMatchPlot")
        }
      
    })
   
    # Analyze Head to head confrontation of IPL teams
    # Analyze and display IPL Matches between 2 teams plot
    output$IPLMatch2TeamsPlot <- renderPlot({ 
        printOrPlotIPLMatch2Teams(input, output)
        
    })
    
    # Analyze and display IPL Match table
    output$IPLMatch2TeamsPrint <- renderTable({ 
        a <- printOrPlotIPLMatch2Teams(input, output)
        a
        #a
    })
    
    # Output either a table or a plot 
    output$plotOrPrintIPLMatch2teams <-  renderUI({ 
        # Check if output is a dataframe. If so, print
        if(is.data.frame(scorecard <- printOrPlotIPLMatch2Teams(input, output))){
            tableOutput("IPLMatch2TeamsPrint")
        }
        else{ 
            plotOutput("IPLMatch2TeamsPlot")
        }
        
    })
    
    # Analyze overall IPL team performance plots
    output$IPLTeamPerfOverallPlot <- renderPlot({ 
        printOrPlotIPLTeamPerfOverall(input, output)
        
    })
    
    # Analyze and display IPL Match table
    output$IPLTeamPerfOverallPrint <- renderTable({ 
        a <- printOrPlotIPLTeamPerfOverall(input, output)
        a
        
    })
    
    # Output either a table or a plot 
    output$printOrPlotIPLTeamPerfoverall <-  renderUI({ 
        # Check if output is a dataframe. If so, print
        if(is.data.frame(scorecard <- printOrPlotIPLTeamPerfOverall(input, output))){
            tableOutput("IPLTeamPerfOverallPrint")
        }
        else{ #Else plot
            plotOutput("IPLTeamPerfOverallPlot")
        }
    })
    
    output$IPLTeamRanking <- renderTable({ 
        a <- plotIPLTeamRanking(input, output)
        a
    })
    
    output$printIPLRanking <-  renderUI({ 
        tableOutput("IPLTeamRanking")
    })
    
    output$IPLPrediction <- renderTable({
        load("./projectDataFrames/prediction/predicted.RData")
        predicted
    })
    
    output$printIPLPrediction <- renderUI({
        tableOutput("IPLPrediction")    
    })
    
    output$IPLPlayingXi <- renderTable({
        load(paste("./projectDataFrames/teamwise_playing11/",input$Team11,".RData",sep=""))
        team
    })
    
    output$printIPLPlayingXi <- renderUI({
        tableOutput("IPLPlayingXi")
    })
})
