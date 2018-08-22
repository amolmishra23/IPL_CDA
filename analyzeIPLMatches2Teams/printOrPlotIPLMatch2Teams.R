printOrPlotIPLMatch2Teams <- function(input,output){
    p <- strsplit(as.character(input$match2),"-")
    teams2 <- c(p[[1]][1],p[[1]][2])
    
    output$selectTeam2 <- renderUI({ 
        selectInput('team2', 'Choose team',choices=teams2,selected=input$team2)
    })
    
    otherTeam = setdiff(teams2,input$team2)
    a <- analyzeIPLMatches2Teams(input$match2,input$matches2TeamFunc,input$plotOrTable1,
                                 input$repType,input$team2,otherTeam)
    a
}