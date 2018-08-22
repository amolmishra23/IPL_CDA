printOrPlotIPLTeamPerfOverall <- function(input,output){
    rankValues <- c(1,2,3,4,5,6)
    output$Rank = renderUI({
        selectInput('rank', 'Choose the rank',choices=rankValues,selected=input$rank)
    })
    
    print(input$teamMatches)
    
    analyzeIPLTeamPerfOverall(input$teamMatches,input$overallperfFunc,input$rank,
                              input$plotOrTable2,
                              input$repType2)

}