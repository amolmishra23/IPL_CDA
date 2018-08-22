source("init.R")
library(shinythemes)

shinyUI(navbarPage(theme = shinytheme("united"),
                   "Comprehensive Data Analysis on IPL",
                   # united
                   # cerulean
    # Batsman tab
    tabPanel("Batsman Analysis",
        h3('Analyze IPL batsman performances'),
        sidebarPanel(
            selectInput('batsmanFunc', 'Select function', IPLBatsmanFuncs),
            selectInput('batsman', 'Select batsman', IPLBatsmen,selectize=FALSE, size=20)
        ),
        mainPanel(
            plotOutput('batsmanPlot')
        )
    ),

    # Bowlers tab
    tabPanel("Bowler Analysis",
        h3('Analyze IPL bowler performances'),
        sidebarPanel(
            selectInput('bowlerFunc', 'Select function', IPLBowlerFuncs),
            selectInput('bowler', 'Select IPL bowler', IPLBowlers,selectize=FALSE, size=20)
        ),
        mainPanel(
            plotOutput('bowlerPlot')
            )
    ),

    # Analyze IPL matches
    tabPanel("Single Match Analysis",
        h3('Analyze an IPL match'),
        sidebarPanel(
            selectInput('matchFunc', 'Select match function', IPLMatchFuncs),
            selectInput('match', 'Select IPL match ', IPLMatches,selectize=FALSE, size=15),
            uiOutput("selectTeam"),
            radioButtons("plotOrTable", label = h4("Plot or table"),
                            choices = c("Plot" = 1, "Table" = 2), 
                            selected = 1,inline=T)
        ),

        mainPanel(
            uiOutput("plotOrPrintIPLMatch")
        )
    ),
    
    # Analyze 2 Teams IPL matches
    tabPanel("Head to head Analysis",
        h3('Head-to-head between 2 IPL teams'),
        sidebarPanel(
            selectInput('matches2TeamFunc', 'Select function', IPLMatches2TeamsFuncs),
            selectInput('match2', 'Select matches', IPLMatches2Teams,selectize=FALSE, size=13),                                
            uiOutput("selectTeam2"),
            radioButtons("plotOrTable1", label = h4("Plot or table"),
                            choices = c("Plot" = 1, "Table" = 2), 
                            selected = 1,inline=T),
            radioButtons("repType", label = h4("Report Type"),
                            choices = c("Summary" = 1, "Detailed" = 2), 
                            selected = 1,inline=T)
            
        ),
        mainPanel(
            uiOutput("plotOrPrintIPLMatch2teams")
        ) 
    ),

    # Analyze IPL Team Overall Perf
    tabPanel("Overall Performance",
             h3("Analyze IPL team's overall performance"),
             sidebarPanel(
                 selectInput('overallperfFunc', 'Select function', IPLTeamOverallPerfFunc),
                 selectInput('teamMatches', 'Select the team', IPLTeamsAll,selectize=FALSE, size=13),
                 uiOutput("Rank"),
                 radioButtons("plotOrTable2", label = h4("Plot or table"),
                              choices = c("Plot" = 1, "Table" = 2), 
                              selected = 1,inline=T),
                 radioButtons("repType2", label = h4("Report Type"),
                              choices = c("Summary" = 1, "Detailed" = 2),
                              selected = 1,inline=T)
             ),
             mainPanel(
                 uiOutput('printOrPlotIPLTeamPerfoverall')
             ) 
             
    ),
    
    tabPanel("Ranking",
             h3("Rank batsman and bowler"),
             sidebarPanel(
                 selectInput('rankingFunc','Select function',IPLRanking)
             ),
             mainPanel(
                 uiOutput('printIPLRanking')
             )
    ),
    
    tabPanel("Prediction",
             h3("Predicting the result of IPL-10"),
             mainPanel(
                 uiOutput('printIPLPrediction')
             )
    ),
    
    tabPanel("Playing XI",
             h3("Predicting the best 11 players of a team"),
             sidebarPanel(
                 selectInput('Team11','Select team',IPLLast)
             ),
             mainPanel(
                 uiOutput('printIPLPlayingXi')
             )
    ),
    
    tabPanel("About",
        h1("CDAI - Comprehensive data analysis on Indian Premier League"),
    )
                   
)
)
