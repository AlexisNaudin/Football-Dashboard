rm(list = ls())

setwd("C:/Users/Alexis/Documents/Project/backend/Football_DB")

library(tidyverse)
library(plyr)
library(dplyr)
library(RCurl)
library(plotly)
library(lubridate)
library(zoo)
library(data.table)

###Create a log file
Systime <- format(Sys.time(), "%Y%m%d_%H%M%S")
filelocation <- paste0("C:/Users/Alexis/Documents/Project/backend/Logs/", Systime, "_Log_File_Update.txt")
# Open Log file
filelocation <- file(filelocation, open="wt")
sink(filelocation, type="output")
sink(filelocation, type="message")

print("------------------Process started----------------------")

### Historical Results
# library(devtools)
# install_github('jalapic/engsoccerdata', username = "jalapic")
# install.packages("engsoccerdata")
# library(engsoccerdata)
# 
# data(package="engsoccerdata")  

# # Load five seasons of main leagues
# years <- c("20142015", "20152016", "20162017", "20172018", "20182019", "20192020")
# chpship <- c("E0", "E1", "F1", "SP1", "I1", "D1")
# newchpship <- c("PL", "Ch", "L1", "Liga", "SeA", "Bun1")
# 
# years2 <- c("1415", "1516", "1617", "1718", "1819", "1920")
# n <- 0
# for (c in chpship) {
#   for (y in years2) {
#     n <- n + 1
#     newname <- paste0(newchpship[match(c, chpship)], "_", years[which(years2 == y)])
#     name <- paste0("https://www.football-data.co.uk/mmz4281/", y, "/", c, ".csv")
#     tempname <- paste0("df", n)
#     assign(newname, read.csv(name))
#   }
# }
# 
# # Load two years of secondary leagues
# years2nd <- c("20172018", "20182019")
# chpship2nd <- c("F2", "D2", "SP2", "I2", "N1", "P1")
# newchpship2nd <- c("L2", "Bun2", "Liga2", "SeB", "Erd", "LigaI")
# 
# years2 <- c("1718", "1819", "1920")
# n <- 0
# for (c in chpship2nd) {
#   for (y in years2) {
#     n <- n + 1
#     newname <- paste0(newchpship2nd[match(c, chpship2nd)], "_", years2nd[which(years2 == y)])
#     name <- paste0("https://www.football-data.co.uk/mmz4281/", y, "/", c, ".csv")
#     tempname <- paste0("df", n)
#     assign(newname, read.csv(name))
#   }
# }

# # For each dataset from the year 2019-2020, remove the column "Time"
# n <- 0
# list_20192020 <- list()
# for (c in newchpship) {
#  n <- n + 1
#  newname <- paste0(c, "_20192020")
#  tempname <- paste0("df", n)
#  newname <- get(newname)
#  list_20192020[[tempname]] <- newname
# }
# list_20192020 <- lapply(list_20192020, function(df) { select(df, -Time) })


cat("############################################################## 
    \n##################### SEASON 2020-2021 ####################### 
    \n############################################################## \n")

years <- c("20202021")
chpship <- c("E0", "E1", "F1", "SP1", "I1", "D1", "F2", "D2", "SP2", "I2", "N1", "P1")
newchpship <- c("PL", "Ch", "L1", "Liga", "SeA", "Bun1", "L2", "Bun2", "Liga2", "SeB", "Erd", "LigaI")

# PL_20192020 <- read.csv("https://www.football-data.co.uk/mmz4281/1920/E0.csv")
# Ch_20192020 <- read.csv("https://www.football-data.co.uk/mmz4281/1920/E1.csv")
# Bun1_20192020 <- read.csv("https://www.football-data.co.uk/mmz4281/1920/D1.csv")
# SeA_20192020 <- read.csv("https://www.football-data.co.uk/mmz4281/1920/I1.csv")
# L1_20192020 <- read.csv("https://www.football-data.co.uk/mmz4281/1920/F1.csv")
# Liga_20192020 <- read.csv("https://www.football-data.co.uk/mmz4281/1920/SP1.csv")
# SeB_20192020 <- read.csv("https://www.football-data.co.uk/mmz4281/1920/I2.csv")
# L2_20192020 <- read.csv("https://www.football-data.co.uk/mmz4281/1920/F2.csv")
# Liga2_20192020 <- read.csv("https://www.football-data.co.uk/mmz4281/1920/SP2.csv")
# Bun2_20192020 <- read.csv("https://www.football-data.co.uk/mmz4281/1920/D2.csv")
# Erd_20192020 <- read.csv("https://www.football-data.co.uk/mmz4281/1920/N1.csv")
# LigaI_20192020 <- read.csv("https://www.football-data.co.uk/mmz4281/1920/P1.csv")

PL_20202021 <- read.csv("https://www.football-data.co.uk/mmz4281/2021/E0.csv")
Ch_20202021 <- read.csv("https://www.football-data.co.uk/mmz4281/2021/E1.csv")
Bun1_20202021 <- read.csv("https://www.football-data.co.uk/mmz4281/2021/D1.csv")
SeA_20202021 <- read.csv("https://www.football-data.co.uk/mmz4281/2021/I1.csv")
L1_20202021 <- read.csv("https://www.football-data.co.uk/mmz4281/2021/F1.csv")
Liga_20202021 <- read.csv("https://www.football-data.co.uk/mmz4281/12021/SP1.csv")
SeB_20202021 <- read.csv("https://www.football-data.co.uk/mmz4281/2021/I2.csv")
L2_20202021 <- read.csv("https://www.football-data.co.uk/mmz4281/2021/F2.csv")
Liga2_20202021 <- read.csv("https://www.football-data.co.uk/mmz4281/12021/SP2.csv")
Bun2_20202021 <- read.csv("https://www.football-data.co.uk/mmz4281/2021/D2.csv")
Erd_20202021 <- read.csv("https://www.football-data.co.uk/mmz4281/2021/N1.csv")
LigaI_20202021 <- read.csv("https://www.football-data.co.uk/mmz4281/2021/P1.csv")

# NOTES
############
# Div = League Division
# Date = Match Date (dd/mm/yy)
# Time = Time of match kick off
# HomeTeam = Home Team
# AwayTeam = Away Team
# FTHG and HG = Full Time Home Team Goals
# FTAG and AG = Full Time Away Team Goals
# FTR and Res = Full Time Result (H=Home Win, D=Draw, A=Away Win)
# HTHG = Half Time Home Team Goals
# HTAG = Half Time Away Team Goals
# HTR = Half Time Result (H=Home Win, D=Draw, A=Away Win)
# 
# Match Statistics (where available)
# Attendance = Crowd Attendance
# Referee = Match Referee
# HS = Home Team Shots
# AS = Away Team Shots
# HST = Home Team Shots on Target
# AST = Away Team Shots on Target
# HHW = Home Team Hit Woodwork
# AHW = Away Team Hit Woodwork
# HC = Home Team Corners
# AC = Away Team Corners
# HF = Home Team Fouls Committed
# AF = Away Team Fouls Committed
# HFKC = Home Team Free Kicks Conceded
# AFKC = Away Team Free Kicks Conceded
# HO = Home Team Offsides
# AO = Away Team Offsides
# HY = Home Team Yellow Cards
# AY = Away Team Yellow Cards
# HR = Home Team Red Cards
# AR = Away Team Red Cards
# HBP = Home Team Bookings Points (10 = yellow, 25 = red)
# ABP = Away Team Bookings Points (10 = yellow, 25 = red)
# 
# Note that Free Kicks Conceeded includes fouls, offsides and any other offense commmitted and will always be equal to or higher than the number of fouls. Fouls make up the vast majority of Free Kicks Conceded. Free Kicks Conceded are shown when specific data on Fouls are not available (France 2nd, Belgium 1st and Greece 1st divisions).
# 
# Note also that English and Scottish yellow cards do not include the initial yellow card when a second is shown to a player converting it into a red, but this is included as a yellow (plus red) for European games.
# 
# 
# Key to 1X2 (match) betting odds data:
#   
# B365H = Bet365 home win odds
# B365D = Bet365 draw odds
# B365A = Bet365 away win odds
# BSH = Blue Square home win odds
# BSD = Blue Square draw odds
# BSA = Blue Square away win odds
# BWH = Bet&Win home win odds
# BWD = Bet&Win draw odds
# BWA = Bet&Win away win odds
# GBH = Gamebookers home win odds
# GBD = Gamebookers draw odds
# GBA = Gamebookers away win odds
# IWH = Interwetten home win odds
# IWD = Interwetten draw odds
# IWA = Interwetten away win odds
# LBH = Ladbrokes home win odds
# LBD = Ladbrokes draw odds
# LBA = Ladbrokes away win odds
# PSH and PH = Pinnacle home win odds
# PSD and PD = Pinnacle draw odds
# PSA and PA = Pinnacle away win odds
# SOH = Sporting Odds home win odds
# SOD = Sporting Odds draw odds
# SOA = Sporting Odds away win odds
# SBH = Sportingbet home win odds
# SBD = Sportingbet draw odds
# SBA = Sportingbet away win odds
# SJH = Stan James home win odds
# SJD = Stan James draw odds
# SJA = Stan James away win odds
# SYH = Stanleybet home win odds
# SYD = Stanleybet draw odds
# SYA = Stanleybet away win odds
# VCH = VC Bet home win odds
# VCD = VC Bet draw odds
# VCA = VC Bet away win odds
# WHH = William Hill home win odds
# WHD = William Hill draw odds
# WHA = William Hill away win odds
# 
# Bb1X2 = Number of BetBrain bookmakers used to calculate match odds averages and maximums
# BbMxH = Betbrain maximum home win odds
# BbAvH = Betbrain average home win odds
# BbMxD = Betbrain maximum draw odds
# BbAvD = Betbrain average draw win odds
# BbMxA = Betbrain maximum away win odds
# BbAvA = Betbrain average away win odds
# 
# MaxH = Market maximum home win odds
# MaxD = Market maximum draw win odds
# MaxA = Market maximum away win odds
# AvgH = Market average home win odds
# AvgD = Market average draw win odds
# AvgA = Market average away win odds
# 
# 
# 
# Key to total goals betting odds:
#   
#   BbOU = Number of BetBrain bookmakers used to calculate over/under 2.5 goals (total goals) averages and maximums
# BbMx>2.5 = Betbrain maximum over 2.5 goals
# BbAv>2.5 = Betbrain average over 2.5 goals
# BbMx<2.5 = Betbrain maximum under 2.5 goals
# BbAv<2.5 = Betbrain average under 2.5 goals
# 
# GB>2.5 = Gamebookers over 2.5 goals
# GB<2.5 = Gamebookers under 2.5 goals
# B365>2.5 = Bet365 over 2.5 goals
# B365<2.5 = Bet365 under 2.5 goals
# P>2.5 = Pinnacle over 2.5 goals
# P<2.5 = Pinnacle under 2.5 goals
# Max>2.5 = Market maximum over 2.5 goals
# Max<2.5 = Market maximum under 2.5 goals
# Avg>2.5 = Market average over 2.5 goals
# Avg<2.5 = Market average under 2.5 goals
# 
# 
# 
# Key to Asian handicap betting odds:
#   
# BbAH = Number of BetBrain bookmakers used to Asian handicap averages and maximums
# BbAHh = Betbrain size of handicap (home team)
# AHh = Market size of handicap (home team) (since 2019/2020)
# BbMxAHH = Betbrain maximum Asian handicap home team odds
# BbAvAHH = Betbrain average Asian handicap home team odds
# BbMxAHA = Betbrain maximum Asian handicap away team odds
# BbAvAHA = Betbrain average Asian handicap away team odds
# 
# GBAHH = Gamebookers Asian handicap home team odds
# GBAHA = Gamebookers Asian handicap away team odds
# GBAH = Gamebookers size of handicap (home team)
# LBAHH = Ladbrokes Asian handicap home team odds
# LBAHA = Ladbrokes Asian handicap away team odds
# LBAH = Ladbrokes size of handicap (home team)
# B365AHH = Bet365 Asian handicap home team odds
# B365AHA = Bet365 Asian handicap away team odds
# B365AH = Bet365 size of handicap (home team)
# PAHH = Pinnacle Asian handicap home team odds
# PAHA = Pinnacle Asian handicap away team odds
# MaxAHH = Market maximum Asian handicap home team odds
# MaxAHA = Market maximum Asian handicap away team odds	
# AvgAHH = Market average Asian handicap home team odds
# AvgAHA = Market average Asian handicap away team odds

############

# # Rename HFKC and AFKC to HF and AF for French Second division (2017-2018 season)
# if(exists("L2_20172018")){
#   names(L2_20172018)[names(L2_20172018) == "HFKC"] <- "HF"
#   names(L2_20172018)[names(L2_20172018) == "AFKC"] <- "AF"
# }

# For each dataset from the year 2020-2021, remove the column "Time"
n <- 0
list_20202021 <- list()
for (c in newchpship) {
  n <- n + 1
  newname <- paste0(c, "_20202021")
  tempname <- paste0("df", n)
  newname <- get(newname)
  list_20202021[[tempname]] <- newname
}

list_20202021 <- lapply(list_20202021, function(df) { select(df, -Time) })

# Apply data.frame format for datasets from the season 2020-2021
n <- 0
for (c in newchpship) {
  n <- n + 1
  newname <- paste0(c, "_20202021")
  tempname <- paste0("df", n)
  assign(newname, as.data.frame(list_20202021[[tempname]]))
}

# For each dataset, add it to a list and remove the column "Referee"
list_season <- c()
n <- 0
for (c in newchpship) {
  for (y in years) {
    n <- n + 1
    newname <- paste0(c, "_", y)
    tempname <- paste0("df", n)
    newname <- get(newname)
    
    if ("Referee" %in% colnames(newname)) {
      newname["Referee"] <- NULL
    }
    
    list_season[[tempname]] <- newname
  }
}

# for (c in newchpship2nd) {
#   for (y in years2nd) {
#     n <- n + 1
#     newname <- paste0(c, "_", y)
#     tempname <- paste0("df", n)
#     newname <- get(newname)
# 
#     if ("Referee" %in% colnames(newname)) {
#       newname["Referee"] <- NULL
#     }
# 
#     list_season[[tempname]] <- newname
#   }
# }

# Remove some columns related to betting odds
list_season <- lapply(list_season, function(df) {
  df <- df[,c(1:22)]
})

n <- 0
for (c in newchpship) {
  for (y in years) {
    n <- n + 1
    newname <- paste0(c, "_", y)
    tempname <- paste0("df", n)
    assign(newname, as.data.frame(list_season[[tempname]]))
  }
}

# for (c in newchpship2nd) {
#   for (y in years2nd) {
#     n <- n + 1
#     newname <- paste0(c, "_", y)
#     tempname <- paste0("df", n)
#     assign(newname, as.data.frame(list_season[[tempname]]))
#   }
# }

n <- 0
seasons <- c()
for (c in newchpship) {
  for (y in years) {
    n <- n + 1
    newname <- paste0(c, "_", y)
    seasons[n] <- newname
  }
}

# for (c in newchpship2nd) {
#   for (y in years2nd) {
#     n <- n + 1
#     newname <- paste0(c, "_", y)
#     seasons[n] <- newname
#   }
# }


ResultsDB <- data.frame(get(seasons[1]))
for(d in seasons[-1]){
  ResultsDB <- rbind(ResultsDB, get(d))
}


ResultsDB$Date <- as.Date(parse_date_time(x = ResultsDB$Date,
                orders = c("d/m/y", "d/m/Y")))

ResultsDB$Season <- NA

# ResultsDB$Season[as.character(ResultsDB$Date) > "2014-07-01" & as.character(ResultsDB$Date) < "2015-06-31"] <- "20142015"
# ResultsDB$Season[as.character(ResultsDB$Date) > "2015-07-01" & as.character(ResultsDB$Date) < "2016-06-31"] <- "20152016"
# ResultsDB$Season[as.character(ResultsDB$Date) > "2016-07-01" & as.character(ResultsDB$Date) < "2017-06-31"] <- "20162017"
# ResultsDB$Season[as.character(ResultsDB$Date) > "2017-07-01" & as.character(ResultsDB$Date) < "2018-06-31"] <- "20172018"
# ResultsDB$Season[as.character(ResultsDB$Date) > "2018-07-01" & as.character(ResultsDB$Date) < "2019-06-31"] <- "20182019"
# ResultsDB$Season[as.character(ResultsDB$Date) > "2019-07-01" & as.character(ResultsDB$Date) < "2020-08-08"] <- "20192020"
ResultsDB$Season[as.character(ResultsDB$Date) > "2020-08-20" & as.character(ResultsDB$Date) < "2021-06-31"] <- "20202021"

# Rename and normalise teams' name
ResultsDB$HomeTeam <- as.character(ResultsDB$HomeTeam)
ResultsDB$AwayTeam <- as.character(ResultsDB$AwayTeam)
ResultsDB$HomeTeam[ResultsDB$HomeTeam == "Wolves"] <- "Wolverhampton"
ResultsDB$AwayTeam[ResultsDB$AwayTeam == "Wolves"] <- "Wolverhampton"
ResultsDB$HomeTeam[ResultsDB$HomeTeam == "Cardiff"] <- "Cardiff City"
ResultsDB$AwayTeam[ResultsDB$AwayTeam == "Cardiff"] <- "Cardiff City"
ResultsDB$HomeTeam[ResultsDB$HomeTeam == "Birmingham"] <- "Birmingham City"
ResultsDB$AwayTeam[ResultsDB$AwayTeam == "Birmingham"] <- "Birmingham City"
ResultsDB$HomeTeam[ResultsDB$HomeTeam == "Sheffield Weds"] <- "Sheffield Wednesday"
ResultsDB$AwayTeam[ResultsDB$AwayTeam == "Sheffield Weds"] <- "Sheffield Wednesday"
ResultsDB$HomeTeam[ResultsDB$HomeTeam == "Derby"] <- "Derby County"
ResultsDB$AwayTeam[ResultsDB$AwayTeam == "Derby"] <- "Derby County"
ResultsDB$HomeTeam[ResultsDB$HomeTeam == "Nott'm Forest"] <- "Nottingham"
ResultsDB$AwayTeam[ResultsDB$AwayTeam == "Nott'm Forest"] <- "Nottingham"
ResultsDB$HomeTeam[ResultsDB$HomeTeam == "Burton"] <- "Burton Albion"
ResultsDB$AwayTeam[ResultsDB$AwayTeam == "Burton"] <- "Burton Albion"
ResultsDB$HomeTeam[ResultsDB$HomeTeam == "Ajaccio GFCO"] <- "GFC Ajaccio"
ResultsDB$AwayTeam[ResultsDB$AwayTeam == "Ajaccio GFCO"] <- "GFC Ajaccio"
ResultsDB$HomeTeam[ResultsDB$HomeTeam == "Espanol"] <- "Esp Barcelona"
ResultsDB$AwayTeam[ResultsDB$AwayTeam == "Espanol"] <- "Esp Barcelona"
ResultsDB$HomeTeam[ResultsDB$HomeTeam == "Sp Gijon"] <- "Girona"
ResultsDB$AwayTeam[ResultsDB$AwayTeam == "Sp Gijon"] <- "Girona"
ResultsDB$HomeTeam[ResultsDB$HomeTeam == "Vallecano"] <- "Rayo Vallecano"
ResultsDB$AwayTeam[ResultsDB$AwayTeam == "Vallecano"] <- "Rayo Vallecano"
ResultsDB$HomeTeam[ResultsDB$HomeTeam == "Sociedad"] <- "Real Sociedad"
ResultsDB$AwayTeam[ResultsDB$AwayTeam == "Sociedad"] <- "Real Sociedad"
ResultsDB$HomeTeam[ResultsDB$HomeTeam == "Verona"] <- "Hellas Verona"
ResultsDB$AwayTeam[ResultsDB$AwayTeam == "Verona"] <- "Hellas Verona"
ResultsDB$HomeTeam[ResultsDB$HomeTeam == "Inter"] <- "Inter Milan"
ResultsDB$AwayTeam[ResultsDB$AwayTeam == "Inter"] <- "Inter Milan"
ResultsDB$HomeTeam[ResultsDB$HomeTeam == "Milan"] <- "AC Milan"
ResultsDB$AwayTeam[ResultsDB$AwayTeam == "Milan"] <- "AC Milan"
ResultsDB$HomeTeam[ResultsDB$HomeTeam == "Chievo"] <- "Chievo Verona"
ResultsDB$AwayTeam[ResultsDB$AwayTeam == "Chievo"] <- "Chievo Verona"
ResultsDB$HomeTeam[ResultsDB$HomeTeam == "Spal"] <- "SPAL"
ResultsDB$AwayTeam[ResultsDB$AwayTeam == "Spal"] <- "SPAL"
ResultsDB$HomeTeam[ResultsDB$HomeTeam == "RB Leipzig"] <- "Leipzig"
ResultsDB$AwayTeam[ResultsDB$AwayTeam == "RB Leipzig"] <- "Leipzig"
ResultsDB$HomeTeam[ResultsDB$HomeTeam == "Celta"] <- "Celta Vigo"
ResultsDB$AwayTeam[ResultsDB$AwayTeam == "Celta"] <- "Celta Vigo"
ResultsDB$HomeTeam[ResultsDB$HomeTeam == "Betis"] <- "Betis Sevilla"
ResultsDB$AwayTeam[ResultsDB$AwayTeam == "Betis"] <- "Betis Sevilla"
ResultsDB$HomeTeam[ResultsDB$HomeTeam == "West Brom"] <- "West Bromwich"
ResultsDB$AwayTeam[ResultsDB$AwayTeam == "West Brom"] <- "West Bromwich"

CleanDB <- ResultsDB

#Reorder columns order:
CleanDB <- CleanDB[c("Div", "Season", "Date", "HomeTeam", "AwayTeam", 
                     "FTHG", "FTAG", "FTR", "HTHG", "HTAG", "HTR", 
                     #"HomeTeamRank", "AwayTeamRank",
                     "HS", "AS", "HST", "AST", "HF", "AF", "HC", "AC", "HY", "AY", "HR", "AR")]

CleanDB$Div <- as.character(CleanDB$Div)

#write.table(CleanDB, "./CleanDB.csv", sep = ",", row.names = F)



# Source the script computeRanking.R containing the function to compute ranking from specific F
# Football result database
source("./computeRanking.R")

# Launch the function specified in the above script.
# The two arguments are the data frame with results and a boolean to save the comupted ranking as CSV
# Here CleanDB with saveCSV are the only arguments.
# Returns a dataframe with ranking for each date (might take a few minutes)
Computed_Ranking <- ComputeRanking(CleanDB, FALSE)

Last_computed_ranking <- read.csv("./Computed_ranking.csv", sep = ",")
Last_computed_ranking$Date <- as.Date(Last_computed_ranking$Date)

# If Last_computed_ranking, the output of last time the ranking was computed by the code has its latest 
# date strictly lower than the latest date of this time the code is running, then append the ranking computed 
# in this code to the previous time the ranking was computed. i.e. UPDATE RANKING WITH LATEST DATA
# Then the csv file is saved
if (max(Computed_Ranking$Date)>max(Last_computed_ranking$Date)) {
  # To avoid to get duplicates we use unique(rbindlist())
  Computed_Ranking <- unique(rbindlist(list(Last_computed_ranking, Computed_Ranking)), by = c("Date", "Team"))
  Computed_Ranking <- as.data.frame(Computed_Ranking)
  write.table(Computed_Ranking, "./Computed_Ranking.csv", sep = ",", row.names = F)
  print("------- Computed_Ranking has been updated ---------")
} else {
  print("------- Computed_Ranking has NOT been updated ---------")
}


Computed_Ranking[, c("GF", "GA")] <- list(NULL)

FootballDB <- merge(x = CleanDB, y = Computed_Ranking, by.x = c("Div", "Season", "Date", "HomeTeam"), 
                    by.y = c("Div", "Season", "Date", "Team"), all.x = TRUE)

FootballDB <- FootballDB %>% rename(OutcomeH = Outcome, PointsH = Points, PlayedH = Played, WinsH = Wins,
                                    DrawsH = Draws, LossesH = Losses, Goals_scoredH = Goals_scored, 
                                    Goals_againstH = Goals_against, Goal_avgH = Goal_avg, rankingH = ranking)

FootballDB <- merge(x = FootballDB, y = Computed_Ranking, by.x = c("Div", "Season", "Date", "AwayTeam"), 
                    by.y = c("Div", "Season", "Date", "Team"), all.x = TRUE)

FootballDB <- FootballDB %>% rename(OutcomeA = Outcome, PointsA = Points, PlayedA = Played, WinsA = Wins,
                                    DrawsA = Draws, LossesA = Losses, Goals_scoredA = Goals_scored, 
                                    Goals_againstA = Goals_against, Goal_avgA = Goal_avg, rankingA = ranking)

# testmerge <- merge(x = Computed_Ranking, y = CleanDB[ , c("Div", "Season", "Date", "HomeTeam", "Matchday", 
#                                                           "FTHG", "HTHG", "HS", "HST", "HF", "HC", "HY", "HR")], 
#                    by.x = c("Div", "Season", "Date", "Team", "Matchday"), 
#                     by.y = c("Div", "Season", "Date", "HomeTeam", "Matchday"), all.x = TRUE)
# testmerge <- merge(x = testmerge, y = CleanDB[ , c("Div", "Season", "Date", "AwayTeam", "Matchday", 
#                                                           "FTAG", "HTAG", "AS", "AST", "AF", "AC", "AY", "AR")], 
#                    by.x = c("Div", "Season", "Date", "Team", "Matchday"), 
#                    by.y = c("Div", "Season", "Date", "AwayTeam", "Matchday"), all.x = TRUE)
# 
# testmerge <- testmerge %>% filter(Team == "Hamburg")

#Cumulative
# FootballDB <- FootballDB %>%
#   group_by(Season, Div, HomeTeam) %>%
#   mutate(cum_HS = cumsum(HS))

### Create a database with Results for each team
# Merge Ranking with Results when the Team is the Away Team
mergeAway <- merge(x = Computed_Ranking, y = FootballDB, 
                   by.x = c("Div", "Season", "Date", "Team", "Outcome", "Points", "Played",
                            "Goals_scored", "Goals_against", "Wins", "Draws", "Losses", "Goal_avg", 
                            "ranking"), 
                   by.y = c("Div", "Season", "Date", "AwayTeam", "OutcomeA", "PointsA", "PlayedA",
                            "Goals_scoredA", "Goals_againstA", "WinsA", "DrawsA", "LossesA", "Goal_avgA",     
                            "rankingA"), 
                   all.x = TRUE)

# Merge Ranking with Results when the Team is the Home Team
mergeHome <- merge(x = Computed_Ranking, y = FootballDB, 
                   by.x = c("Div", "Season", "Date", "Team", "Outcome", "Points", "Played",
                            "Goals_scored", "Goals_against", "Wins", "Draws", "Losses", "Goal_avg", 
                            "ranking"), 
                   by.y = c("Div", "Season", "Date", "HomeTeam", "OutcomeH", "PointsH", "PlayedH",
                            "Goals_scoredH", "Goals_againstH", "WinsH", "DrawsH", "LossesH", "Goal_avgH",     
                            "rankingH"), 
                   all.x = TRUE)

names(mergeAway)[names(mergeAway) == "HomeTeam"] <- "Opponent"
names(mergeHome)[names(mergeHome) == "AwayTeam"] <- "Opponent"
names(mergeAway)[names(mergeAway) == "OutcomeH"] <- "Outcome_Opp"
names(mergeHome)[names(mergeHome) == "OutcomeA"] <- "Outcome_Opp"
names(mergeAway)[names(mergeAway) == "PointsH"] <- "Points_Opp"
names(mergeHome)[names(mergeHome) == "PointsA"] <- "Points_Opp"
names(mergeAway)[names(mergeAway) == "PlayedH"] <- "Played_Opp"
names(mergeHome)[names(mergeHome) == "PlayedA"] <- "Played_Opp"
names(mergeAway)[names(mergeAway) == "Goals_scoredH"] <- "Cum_Goals_scored_Opp"
names(mergeHome)[names(mergeHome) == "Goals_scoredA"] <- "Cum_Goals_scored_Opp"
names(mergeAway)[names(mergeAway) == "Goals_againstH"] <- "Cum_Goals_against_Opp"
names(mergeHome)[names(mergeHome) == "Goals_againstA"] <- "Cum_Goals_against_Opp"
names(mergeAway)[names(mergeAway) == "WinsH"] <- "Cum_Wins_Opp"
names(mergeHome)[names(mergeHome) == "WinsA"] <- "Cum_Wins_Opp"
names(mergeAway)[names(mergeAway) == "DrawsH"] <- "Cum_Draws_Opp"
names(mergeHome)[names(mergeHome) == "DrawsA"] <- "Cum_Draws_Opp"
names(mergeAway)[names(mergeAway) == "LossesH"] <- "Cum_Losses_Opp"
names(mergeHome)[names(mergeHome) == "LossesA"] <- "Cum_Losses_Opp"
names(mergeAway)[names(mergeAway) == "Goal_avgH"] <- "Goal_avg_Opp"
names(mergeHome)[names(mergeHome) == "Goal_avgA"] <- "Goal_avg_Opp"
names(mergeAway)[names(mergeAway) == "rankingH"] <- "ranking_Opp"
names(mergeHome)[names(mergeHome) == "rankingA"] <- "ranking_Opp"


# Remove days when the team did not play (i.e Opponent = NA)
mergeAway <- mergeAway[!is.na(mergeAway$Opponent), ]
mergeHome <- mergeHome[!is.na(mergeHome$Opponent), ]

# Create a dummy variables in each DS from Home games:
mergeAway$HomeGame <- 0
mergeHome$HomeGame <- 1

#Merge Away and Home Results
Teams_Result_DB <- rbind(mergeAway, mergeHome)

# Order the Data base
Teams_Result_DB <- Teams_Result_DB[order(Teams_Result_DB$Div, Teams_Result_DB$Season, 
                                         Teams_Result_DB$Team, Teams_Result_DB$Date),]

Teams_Result_DB$Div <- as.character(Teams_Result_DB$Div)
Teams_Result_DB$Div[Teams_Result_DB$Div == "E0"] <- "Premier League"
Teams_Result_DB$Div[Teams_Result_DB$Div == "E1"] <- "Championship"
Teams_Result_DB$Div[Teams_Result_DB$Div == "D1"] <- "Bundesliga"
Teams_Result_DB$Div[Teams_Result_DB$Div == "F1"] <- "Ligue 1"
Teams_Result_DB$Div[Teams_Result_DB$Div == "I1"] <- "Serie A"
Teams_Result_DB$Div[Teams_Result_DB$Div == "SP1"] <- "LaLiga"
Teams_Result_DB$Div[Teams_Result_DB$Div == "F2"] <- "Ligue 2"
Teams_Result_DB$Div[Teams_Result_DB$Div == "D2"] <- "Bundesliga 2"
Teams_Result_DB$Div[Teams_Result_DB$Div == "SP2"] <- "LaLiga 2"
Teams_Result_DB$Div[Teams_Result_DB$Div == "I2"] <- "Serie B"
Teams_Result_DB$Div[Teams_Result_DB$Div == "N1"] <- "Eredivisie"
Teams_Result_DB$Div[Teams_Result_DB$Div == "P1"] <- "Liga Portugal"


# Add hyphen after the 4th position
Teams_Result_DB$Season <- gsub('^([0-9]{4})([0-9]+)$', '\\1-\\2', Teams_Result_DB$Season)

# Rename variables:
names(Teams_Result_DB)[names(Teams_Result_DB) == "Goals_scored"] <- "Cum_Goals_scored"
names(Teams_Result_DB)[names(Teams_Result_DB) == "Goals_against"] <- "Cum_Goals_against"
names(Teams_Result_DB)[names(Teams_Result_DB) == "Wins"] <- "Cum_Wins"
names(Teams_Result_DB)[names(Teams_Result_DB) == "Draws"] <- "Cum_Draws"
names(Teams_Result_DB)[names(Teams_Result_DB) == "Losses"] <- "Cum_Losses"

# Create variables for Goals scored and against during the match (Full Time and Half Time):
Teams_Result_DB$Goals_scored <- NA
Teams_Result_DB$Goals_scored[Teams_Result_DB$HomeGame == 1] = Teams_Result_DB$FTHG[Teams_Result_DB$HomeGame == 1]  
Teams_Result_DB$Goals_scored[Teams_Result_DB$HomeGame == 0] = Teams_Result_DB$FTAG[Teams_Result_DB$HomeGame == 0]  
Teams_Result_DB$Goals_against <- NA
Teams_Result_DB$Goals_against[Teams_Result_DB$HomeGame == 0] = Teams_Result_DB$FTHG[Teams_Result_DB$HomeGame == 0]  
Teams_Result_DB$Goals_against[Teams_Result_DB$HomeGame == 1] = Teams_Result_DB$FTAG[Teams_Result_DB$HomeGame == 1]  
Teams_Result_DB$FTHG <- NULL
Teams_Result_DB$FTAG <- NULL

Teams_Result_DB$Goals_scored_HT <- NA
Teams_Result_DB$Goals_scored_HT[Teams_Result_DB$HomeGame == 1] = Teams_Result_DB$HTHG[Teams_Result_DB$HomeGame == 1]  
Teams_Result_DB$Goals_scored_HT[Teams_Result_DB$HomeGame == 0] = Teams_Result_DB$HTAG[Teams_Result_DB$HomeGame == 0]  
Teams_Result_DB$Goals_against_HT<- NA
Teams_Result_DB$Goals_against_HT[Teams_Result_DB$HomeGame == 0] = Teams_Result_DB$HTHG[Teams_Result_DB$HomeGame == 0]  
Teams_Result_DB$Goals_against_HT[Teams_Result_DB$HomeGame == 1] = Teams_Result_DB$HTAG[Teams_Result_DB$HomeGame == 1]  
Teams_Result_DB$HTHG <- NULL
Teams_Result_DB$HTAG <- NULL

# Remove variable FTR similar to Outcome:
Teams_Result_DB$FTR <- NULL

# Create a variable for the Half Time Result:
Teams_Result_DB$Outcome_HT <- NA
Teams_Result_DB$Outcome_HT[Teams_Result_DB$HomeGame == 1 & Teams_Result_DB$HTR == "H"] <- 'Win'
Teams_Result_DB$Outcome_HT[Teams_Result_DB$HomeGame == 0 & Teams_Result_DB$HTR == "A"] <- 'Win'
Teams_Result_DB$Outcome_HT[Teams_Result_DB$HomeGame == 1 & Teams_Result_DB$HTR == "A"] <- 'Loss'
Teams_Result_DB$Outcome_HT[Teams_Result_DB$HomeGame == 0 & Teams_Result_DB$HTR == "H"] <- 'Loss'
Teams_Result_DB$Outcome_HT[Teams_Result_DB$HTR == "D"] <- 'Draw'

Teams_Result_DB$HTR <- NULL

# Create variables for Shots for and against during the match:
Teams_Result_DB$Shots <- NA
Teams_Result_DB$Shots[Teams_Result_DB$HomeGame == 1] = Teams_Result_DB$HS[Teams_Result_DB$HomeGame == 1]  
Teams_Result_DB$Shots[Teams_Result_DB$HomeGame == 0] = Teams_Result_DB$AS[Teams_Result_DB$HomeGame == 0]  
Teams_Result_DB$Shots_against <- NA
Teams_Result_DB$Shots_against[Teams_Result_DB$HomeGame == 0] = Teams_Result_DB$HS[Teams_Result_DB$HomeGame == 0]  
Teams_Result_DB$Shots_against[Teams_Result_DB$HomeGame == 1] = Teams_Result_DB$AS[Teams_Result_DB$HomeGame == 1]  
Teams_Result_DB$HS <- NULL
Teams_Result_DB$AS <- NULL

Teams_Result_DB$Shots_target <- NA
Teams_Result_DB$Shots_target[Teams_Result_DB$HomeGame == 1] = Teams_Result_DB$HST[Teams_Result_DB$HomeGame == 1]  
Teams_Result_DB$Shots_target[Teams_Result_DB$HomeGame == 0] = Teams_Result_DB$AST[Teams_Result_DB$HomeGame == 0]  
Teams_Result_DB$Shots_target_against <- NA
Teams_Result_DB$Shots_target_against[Teams_Result_DB$HomeGame == 0] = Teams_Result_DB$HST[Teams_Result_DB$HomeGame == 0]  
Teams_Result_DB$Shots_target_against[Teams_Result_DB$HomeGame == 1] = Teams_Result_DB$AST[Teams_Result_DB$HomeGame == 1]  
Teams_Result_DB$HST <- NULL
Teams_Result_DB$AST <- NULL

# Create variables for Corners for and against during the match:
Teams_Result_DB$Corners <- NA
Teams_Result_DB$Corners[Teams_Result_DB$HomeGame == 1] = Teams_Result_DB$HC[Teams_Result_DB$HomeGame == 1]  
Teams_Result_DB$Corners[Teams_Result_DB$HomeGame == 0] = Teams_Result_DB$AC[Teams_Result_DB$HomeGame == 0]  
Teams_Result_DB$Corners_against <- NA
Teams_Result_DB$Corners_against[Teams_Result_DB$HomeGame == 0] = Teams_Result_DB$HC[Teams_Result_DB$HomeGame == 0]  
Teams_Result_DB$Corners_against[Teams_Result_DB$HomeGame == 1] = Teams_Result_DB$AC[Teams_Result_DB$HomeGame == 1]  
Teams_Result_DB$HC <- NULL
Teams_Result_DB$AC <- NULL

# Create variables for Fouls for and against during the match:
Teams_Result_DB$Fouls <- NA
Teams_Result_DB$Fouls[Teams_Result_DB$HomeGame == 1] = Teams_Result_DB$HF[Teams_Result_DB$HomeGame == 1]  
Teams_Result_DB$Fouls[Teams_Result_DB$HomeGame == 0] = Teams_Result_DB$AF[Teams_Result_DB$HomeGame == 0]  
Teams_Result_DB$Fouls_Opp <- NA
Teams_Result_DB$Fouls_Opp[Teams_Result_DB$HomeGame == 0] = Teams_Result_DB$HF[Teams_Result_DB$HomeGame == 0]  
Teams_Result_DB$Fouls_Opp[Teams_Result_DB$HomeGame == 1] = Teams_Result_DB$AF[Teams_Result_DB$HomeGame == 1]  
Teams_Result_DB$HF <- NULL
Teams_Result_DB$AF <- NULL

# Create variables for Yellow Cards for and against during the match:
Teams_Result_DB$Yellow_cards <- NA
Teams_Result_DB$Yellow_cards[Teams_Result_DB$HomeGame == 1] = Teams_Result_DB$HY[Teams_Result_DB$HomeGame == 1]  
Teams_Result_DB$Yellow_cards[Teams_Result_DB$HomeGame == 0] = Teams_Result_DB$AY[Teams_Result_DB$HomeGame == 0]  
Teams_Result_DB$Yellow_cards_Opp <- NA
Teams_Result_DB$Yellow_cards_Opp[Teams_Result_DB$HomeGame == 0] = Teams_Result_DB$HY[Teams_Result_DB$HomeGame == 0]  
Teams_Result_DB$Yellow_cards_Opp[Teams_Result_DB$HomeGame == 1] = Teams_Result_DB$AY[Teams_Result_DB$HomeGame == 1]  
Teams_Result_DB$HY <- NULL
Teams_Result_DB$AY <- NULL

# Create variables for Red Cards for and against during the match:
Teams_Result_DB$Red_cards <- NA
Teams_Result_DB$Red_cards[Teams_Result_DB$HomeGame == 1] = Teams_Result_DB$HR[Teams_Result_DB$HomeGame == 1]  
Teams_Result_DB$Red_cards[Teams_Result_DB$HomeGame == 0] = Teams_Result_DB$AR[Teams_Result_DB$HomeGame == 0]  
Teams_Result_DB$Red_cards_Opp <- NA
Teams_Result_DB$Red_cards_Opp[Teams_Result_DB$HomeGame == 0] = Teams_Result_DB$HR[Teams_Result_DB$HomeGame == 0]  
Teams_Result_DB$Red_cards_Opp[Teams_Result_DB$HomeGame == 1] = Teams_Result_DB$AR[Teams_Result_DB$HomeGame == 1]  
Teams_Result_DB$HR <- NULL
Teams_Result_DB$AR <- NULL

Teams_Result_DB <- Teams_Result_DB[c("Div", "Season", "Date", "Team",
                                     "Outcome", "Opponent", "ranking" , "ranking_Opp","Played", "Played_Opp", 
                                     "HomeGame", "Goal_avg", "Goals_scored", "Goals_against", "Shots","Shots_against", 
                                     "Shots_target", "Shots_target_against", "Points", "Points_Opp",
                                     "Corners", "Corners_against", "Fouls", "Fouls_Opp", "Yellow_cards",         
                                     "Yellow_cards_Opp", "Red_cards", "Red_cards_Opp", "Outcome_HT", 
                                     "Goals_scored_HT", "Goals_against_HT", "Cum_Goals_scored",
                                     "Cum_Goals_against", "Cum_Wins", "Cum_Draws", "Cum_Losses", 
                                     "Outcome_Opp", "Goal_avg_Opp", "Cum_Goals_scored_Opp", "Cum_Goals_against_Opp",
                                     "Cum_Wins_Opp", "Cum_Draws_Opp", "Cum_Losses_Opp" )]


Last_Teams_Result_DB <- read.csv("./Teams_Result_DB.csv", sep = ",")
Last_Teams_Result_DB$Date <- as.Date(Last_Teams_Result_DB$Date)

# UPDATE TEAMS RESULTS WITH LATEST DATA
# Then the csv file is saved
if (max(Teams_Result_DB$Date)>max(Last_Teams_Result_DB$Date)) {
  # To avoid to get duplicates we use unique(rbindlist())
  Teams_Result_DB <- unique(rbindlist(list(Last_Teams_Result_DB, Teams_Result_DB)), by = c("Date", "Team"))
  Teams_Result_DB <- as.data.frame(Teams_Result_DB)
  Teams_Result_DB <- Teams_Result_DB[order(Teams_Result_DB$Div, Teams_Result_DB$Season, 
                                           Teams_Result_DB$Team, Teams_Result_DB$Date),]
  write.table(Teams_Result_DB, "./Teams_Result_DB.csv", sep = ",", row.names = F)
  print("------- Teams_Result_DB has been updated ---------")
} else {
  print("------- Teams_Result_DB has NOT been updated ---------")
}

proc.time()
sink()
sink(type="message")
close(filelocation)
