rm(list = ls())

setwd("C:/Users/pc/Desktop/Project/backend/Football_DB")

library(tidyverse)
library(plyr)
library(dplyr)
library(RCurl)
library(plotly)
library(lubridate)
library(zoo)


### Historical Results
# library(devtools)
# install_github('jalapic/engsoccerdata', username = "jalapic")
# install.packages("engsoccerdata")
# library(engsoccerdata)
# 
# data(package="engsoccerdata")  

years <- c("20152016", "20162017", "20172018", "20182019", "20192020")
chpship <- c("E0", "E1", "F1", "SP1", "I1", "D1")
newchpship <- c("PL", "Ch", "L1", "Liga", "SeA", "Bun1")

n <- 0
for (c in chpship) {
  for (y in years) {
    n <- n + 1
    newname <- paste0(newchpship[match(c, chpship)], "_", y)
    name <- paste0(c, "_", y, ".csv")
    tempname <- paste0("df", n)
    assign(newname, read.csv(name, sep = ";"))
    }
}


# PL_20192020 <- read.csv(textConnection(getURL("https://www.football-data.co.uk/mmz4281/1920/E0.csv")))
# Ch_20192020 <- read.csv(textConnection(getURL("https://www.football-data.co.uk/mmz4281/1920/E1.csv")))
# Bun1_20192020 <- read.csv(textConnection(getURL("https://www.football-data.co.uk/mmz4281/1920/D1.csv")))
# SeA_20192020 <- read.csv(textConnection(getURL("https://www.football-data.co.uk/mmz4281/1920/I1.csv")))
# L1_20192020 <- read.csv(textConnection(getURL("https://www.football-data.co.uk/mmz4281/1920/F1.csv")))
# Liga_20192020 <- read.csv(textConnection(getURL("https://www.football-data.co.uk/mmz4281/1920/SP1.csv")))


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

n <- 0
list_20192020 <- list()
for (c in newchpship) {
  n <- n + 1
    newname <- paste0(c, "_20192020")
    tempname <- paste0("df", n)
    newname <- get(newname)
    list_20192020[[tempname]] <- newname
}

list_20192020 <- lapply(list_20192020, function(df) { select(df, -Time) })

n <- 0
for (c in newchpship) {
    n <- n + 1
    newname <- paste0(c, "_20192020")
    tempname <- paste0("df", n)
    assign(newname, as.data.frame(list_20192020[[tempname]]))
}

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


list_season <- lapply(list_season, function(df) {
  df <- df[,c(1:24)]
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

n <- 0
seasons <- c()
for (c in newchpship) {
  for (y in years) {
    n <- n + 1
    newname <- paste0(c, "_", y)
    seasons[n] <- newname
    }
}

ResultsDB <- data.frame(get(seasons[1]))
for(d in seasons[-1]){
  ResultsDB <- rbind(ResultsDB, get(d))
}


ResultsDB$Date <- as.Date(ResultsDB$Date, format = '%d/%m/%Y')

ResultsDB$Season <- NA

ResultsDB$Season[as.character(ResultsDB$Date) > "2015-07-01" & as.character(ResultsDB$Date) < "2016-06-31"] <- "20152016"
ResultsDB$Season[as.character(ResultsDB$Date) > "2016-07-01" & as.character(ResultsDB$Date) < "2017-06-31"] <- "20162017"
ResultsDB$Season[as.character(ResultsDB$Date) > "2017-07-01" & as.character(ResultsDB$Date) < "2018-06-31"] <- "20172018"
ResultsDB$Season[as.character(ResultsDB$Date) > "2018-07-01" & as.character(ResultsDB$Date) < "2019-06-31"] <- "20182019"
ResultsDB$Season[as.character(ResultsDB$Date) > "2019-07-01" & as.character(ResultsDB$Date) < "2020-06-31"] <- "20192020"


# Bun1_Ranking <- read.csv("Bun1Ranking.csv", sep = ";")
# Bun1_Ranking$Div <- "D1"
# Ch_Ranking <- read.csv("ChRanking.csv", sep = ";")
# Ch_Ranking$Div <- "E1"
# L1_Ranking <- read.csv("L1Ranking.csv", sep = ";")
# L1_Ranking$Div <- "F1"
# Liga_Ranking <- read.csv("LigaRanking.csv", sep = ";")
# Liga_Ranking$Div <- "SP1"
# PL_Ranking <- read.csv("PLRanking.csv", sep = ";")
# PL_Ranking$Div <- "E0"
# SerieA_Ranking <- read.csv("SerieARanking.csv", sep = ";")
# SerieA_Ranking$Div <- "I1"

# RankingDB <- rbind.data.frame(Bun1_Ranking, Ch_Ranking, PL_Ranking, L1_Ranking, Liga_Ranking, SerieA_Ranking)
# RankingDB$Season <- as.character(RankingDB$Season)

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

# RankingDB$Team <- as.character(RankingDB$Team)
# RankingDB$Team[RankingDB$Team == "Munich"] <- "Bayern Munich"
# RankingDB$Team[RankingDB$Team == "Mayence"] <- "Mainz"
# RankingDB$Team[RankingDB$Team == "Berlin"] <- "Hertha"
# RankingDB$Team[RankingDB$Team == "Wolfsbourg"] <- "Wolfsburg"
# RankingDB$Team[RankingDB$Team == "Cologne"] <- "FC Koln"
# RankingDB$Team[RankingDB$Team == "Hambourg"] <- "Hamburg"
# RankingDB$Team[RankingDB$Team == "Augsbourg"] <- "Augsburg"
# RankingDB$Team[RankingDB$Team == "Brême"] <- "Werder Bremen"
# RankingDB$Team[RankingDB$Team == "Francfort"] <- "Ein Frankfurt"
# RankingDB$Team[RankingDB$Team == "Hanovre"] <- "Hannover"
# RankingDB$Team[RankingDB$Team == "Fribourg"] <- "Freiburg"
# RankingDB$Team[RankingDB$Team == "M'Gladbach"] <- "M'gladbach"
# RankingDB$Team[RankingDB$Team == "Düsseldorf"] <- "Fortuna Dusseldorf"
# RankingDB$Team[RankingDB$Team == "Nuremberg"] <- "Nurnberg"
# RankingDB$Team[RankingDB$Team == "Hertha BSC"] <- "Hertha"
# RankingDB$Team[RankingDB$Team == "Un. Berlin"] <- "Union Berlin"
# RankingDB$Team[RankingDB$Team == "Ipswich Town"] <- "Ipswich"
# RankingDB$Team[RankingDB$Team == "Milton KD"] <- "Milton Keynes Dons"
# RankingDB$Team[RankingDB$Team == "Saint-Étienne"] <- "St Etienne"
# RankingDB$Team[RankingDB$Team == "St-Étienne"] <- "St Etienne"
# RankingDB$Team[RankingDB$Team == "Málaga CF"] <- "Malaga"
# RankingDB$Team[RankingDB$Team == "Espanyol Barcelone"] <- "Esp Barcelona"
# RankingDB$Team[RankingDB$Team == "Deportivo La Corogne"] <- "La Coruna"
# RankingDB$Team[RankingDB$Team == "D. La Corogne"] <- "La Coruna"
# RankingDB$Team[RankingDB$Team == "At. Madrid"] <- "Ath Madrid"
# RankingDB$Team[RankingDB$Team == "La Corogne"] <- "La Coruna"
# RankingDB$Team[RankingDB$Team == "Málaga"] <- "Malaga"
# RankingDB$Team[RankingDB$Team == "Man. City"] <- "Man City"
# RankingDB$Team[RankingDB$Team == "Man. United"] <- "Man United"
# RankingDB$Team[RankingDB$Team == "Bologne FC"] <- "Bologna"
# RankingDB$Team[RankingDB$Team == "Carpi FC"] <- "Carpi"
# RankingDB$Team[RankingDB$Team == "Chievo Vérone"] <- "Chievo Verona"
# RankingDB$Team[RankingDB$Team == "Empoli FC"] <- "Empoli"
# RankingDB$Team[RankingDB$Team == "Genoa CFC"] <- "Genoa"
# RankingDB$Team[RankingDB$Team == "Hellas Vérone"] <- "Hellas Verona"
# RankingDB$Team[RankingDB$Team == "SS Lazio"] <- "Lazio"
# RankingDB$Team[RankingDB$Team == "SSC Naples"] <- "Napoli"
# RankingDB$Team[RankingDB$Team == "US Palerme"] <- "Palermo"
# RankingDB$Team[RankingDB$Team == "AS Rome"] <- "Roma"	
# RankingDB$Team[RankingDB$Team == "US Sassuolo"] <- "Sassuolo"	
# RankingDB$Team[RankingDB$Team == "Cagliari Calcio"] <- "Cagliari"	
# RankingDB$Team[RankingDB$Team == "Crotone FC"] <- "Crotone"	
# RankingDB$Team[RankingDB$Team == "Bénévent Calcio"] <- "Benevento"	
# RankingDB$Team[RankingDB$Team == "Torino FC"] <- "Torino"	
# RankingDB$Team[RankingDB$Team == "Parme"] <- "Parma"	
# RankingDB$Team[RankingDB$Team == "US Lecce"] <- "Lecce"
# RankingDB$Team[RankingDB$Team == "Parme Calcio"] <- "Parma"	
# RankingDB$Team[RankingDB$Team == "Schalke"] <- "Schalke 04"
# RankingDB$Team[RankingDB$Team == "Nîmes"] <- "Nimes"
# RankingDB$Team[RankingDB$Team == "Paris"] <- "Paris SG"
# RankingDB$Team[RankingDB$Team == "Leicester City"] <- "Leicester"
# RankingDB$Team[RankingDB$Team == "Huddersfield Town"] <- "Huddersfield"
# RankingDB$Team[RankingDB$Team == "ACF Fiorentina"] <- "Fiorentina"
# RankingDB$Team[RankingDB$Team == "Atalanta Bergame"] <- "Atalanta"
# RankingDB$Team[RankingDB$Team == "Udinese Calcio"] <- "Udinese"
# RankingDB$Team[RankingDB$Team == "Juventus FC"] <- "Juventus"
# RankingDB$Team[RankingDB$Team == "UC Sampdoria"] <- "Sampdoria"
# RankingDB$Team[RankingDB$Team == "Frosinone Calcio"] <- "Frosinone"
# RankingDB$Team[RankingDB$Team == "AC Fiorentina"] <- "Fiorentina"
# RankingDB$Team[RankingDB$Team == "Rayo"] <- "Rayo Vallecano"
# RankingDB$Team[RankingDB$Team == "Celta"] <- "Celta Vigo"
# RankingDB$Team[RankingDB$Team == "Levante UD"] <- "Levante"

### Test differences between teams in both DB
# setdiff(DATABASE$HomeTeam, RankingDB$Team)
# setdiff(RankingDB$Team, DATABASE$HomeTeam)

# names(RankingDB)[names(RankingDB) == 'Team'] <- 'HomeTeam'
# names(RankingDB)[names(RankingDB) == 'Matchday'] <- 'MD_when_played'

# CleanDB <- merge(ResultsDB, RankingDB, by=c("Div", "HomeTeam", "Season", "MD_when_played"), all.x = T)
# names(CleanDB)[names(CleanDB) == "Ranking"] <- "HomeTeamRank"
# names(RankingDB)[names(RankingDB) == 'HomeTeam'] <- 'AwayTeam'
# CleanDB <- merge(CleanDB, RankingDB, by=c("Div", "AwayTeam", "Season", "MD_when_played"), all.x = T)
# names(CleanDB)[names(CleanDB) == "Ranking"] <- "AwayTeamRank"
# 
# names(RankingDB)[names(RankingDB) == 'AwayTeam'] <- 'Team'
# names(RankingDB)[names(RankingDB) == 'MD_when_played'] <- 'Matchday'

CleanDB <- ResultsDB

#Reorder columns order:
CleanDB <- CleanDB[c("Div", "Season", "Matchday", "MD_when_played", "Date", "HomeTeam", "AwayTeam", 
                     "FTHG", "FTAG", "FTR", "HTHG", "HTAG", "HTR", 
                     #"HomeTeamRank", "AwayTeamRank",
                     "HS", "AS", "HST", "AST", "HF", "AF", "HC", "AC", "HY", "AY", "HR", "AR")]

CleanDB$Div <- as.character(CleanDB$Div)

#write.table(CleanDB, "./CleanDB.csv", sep = ",", row.names = F)



# Source the script computeRanking.R containing the function to compute ranking from specific F
# Football result database
source("./computeRanking.R")

# Launch the function specified in the above script. 
# The CleanDB with saveCSV = TRUE are the only arguments.
# Returns a dataframe with ranking for each date
Computed_Ranking <- ComputeRanking(CleanDB, TRUE)

Computed_Ranking[, c("MD_when_played", "GF", "GA")] <- list(NULL)


FootballDB <- merge(x = CleanDB, y = Computed_Ranking, by.x = c("Div", "Season", "Date", "HomeTeam", "Matchday"), 
                    by.y = c("Div", "Season", "Date", "Team", "Matchday"), all.x = TRUE)

FootballDB <- FootballDB %>% rename(OutcomeH = Outcome, PointsH = Points, PlayedH = Played, WinsH = Wins,
                                    DrawsH = Draws, LossesH = Losses, Goals_scoredH = Goals_scored, 
                                    Goals_againstH = Goals_against, Goal_avgH = Goal_avg, rankingH = ranking)

FootballDB <- merge(x = FootballDB, y = Computed_Ranking, by.x = c("Div", "Season", "Date", "AwayTeam", "Matchday"), 
                    by.y = c("Div", "Season", "Date", "Team", "Matchday"), all.x = TRUE)

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
                   by.x = c("Div", "Season", "Date", "Team", "Matchday", "Outcome", "Points", "Played",
                            "Goals_scored", "Goals_against", "Wins", "Draws", "Losses", "Goal_avg", 
                            "ranking"), 
                   by.y = c("Div", "Season", "Date", "AwayTeam", "Matchday", "OutcomeA", "PointsA", "PlayedA",
                            "Goals_scoredA", "Goals_againstA", "WinsA", "DrawsA", "LossesA", "Goal_avgA",     
                            "rankingA"), 
                   all.x = TRUE)

# Merge Ranking with Results when the Team is the Home Team
mergeHome <- merge(x = Computed_Ranking, y = FootballDB, 
                   by.x = c("Div", "Season", "Date", "Team", "Matchday", "Outcome", "Points", "Played",
                            "Goals_scored", "Goals_against", "Wins", "Draws", "Losses", "Goal_avg", 
                            "ranking"), 
                   by.y = c("Div", "Season", "Date", "HomeTeam", "Matchday", "OutcomeH", "PointsH", "PlayedH",
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

Teams_Result_DB$Div[Teams_Result_DB$Div == "E0"] <- "Premier League"
Teams_Result_DB$Div[Teams_Result_DB$Div == "E1"] <- "Championship"
Teams_Result_DB$Div[Teams_Result_DB$Div == "D1"] <- "Bundesliga"
Teams_Result_DB$Div[Teams_Result_DB$Div == "F1"] <- "Ligue 1"
Teams_Result_DB$Div[Teams_Result_DB$Div == "I1"] <- "Serie A"
Teams_Result_DB$Div[Teams_Result_DB$Div == "SP1"] <- "LaLiga"

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

# Create variables for Yellow Cards for and against during the match:
Teams_Result_DB$Red_cards <- NA
Teams_Result_DB$Red_cards[Teams_Result_DB$HomeGame == 1] = Teams_Result_DB$HR[Teams_Result_DB$HomeGame == 1]  
Teams_Result_DB$Red_cards[Teams_Result_DB$HomeGame == 0] = Teams_Result_DB$AR[Teams_Result_DB$HomeGame == 0]  
Teams_Result_DB$Red_cards_Opp <- NA
Teams_Result_DB$Red_cards_Opp[Teams_Result_DB$HomeGame == 0] = Teams_Result_DB$HR[Teams_Result_DB$HomeGame == 0]  
Teams_Result_DB$Red_cards_Opp[Teams_Result_DB$HomeGame == 1] = Teams_Result_DB$AR[Teams_Result_DB$HomeGame == 1]  
Teams_Result_DB$HR <- NULL
Teams_Result_DB$AR <- NULL

Teams_Result_DB <- Teams_Result_DB[c("Div", "Season", "Date", "Team", "Matchday", "MD_when_played",
                                     "Outcome", "Opponent", "ranking" , "ranking_Opp","Played", "Played_Opp", 
                                     "HomeGame", "Goal_avg", "Goals_scored", "Goals_against", "Shots","Shots_against", 
                                     "Shots_target", "Shots_target_against", "Points", "Points_Opp",
                                     "Corners", "Corners_against", "Fouls", "Fouls_Opp", "Yellow_cards",         
                                     "Yellow_cards_Opp", "Red_cards", "Red_cards_Opp", "Outcome_HT", 
                                     "Goals_scored_HT", "Goals_against_HT", "Cum_Goals_scored",
                                     "Cum_Goals_against", "Cum_Wins", "Cum_Draws", "Cum_Losses", 
                                     "Outcome_Opp", "Goal_avg_Opp", "Cum_Goals_scored_Opp", "Cum_Goals_against_Opp",
                                     "Cum_Wins_Opp", "Cum_Draws_Opp", "Cum_Losses_Opp", )]


### New variables
Teams_Result_DB <- Teams_Result_DB %>%
  group_by(Season, Div, Team) %>%
  mutate(Shots_avg = mean(Shots, na.rm = TRUE), Shots_target_avg = mean(Shots_target, na.rm = TRUE),
         Goals_scored_avg = mean(Goals_scored, na.rm = TRUE), Goals_against_avg = mean(Goals_against, na.rm = TRUE))

#write.table(Teams_Result_DB, "./Teams_Result_DB.csv", sep = ",", row.names = F)


# Compute Team Stats
team <- 'Toulouse'
df <- CleanDB %>% filter(HomeTeam == team | AwayTeam == team)

df <- df[order(df$Date),]

df$Result <- rep(NA, nrow(df))

for (i in 1:nrow(df)) {
  if ((df$HomeTeam[i] == team & df$FTR[i] == 'H') | (df$AwayTeam[i] == team & df$FTR[i] == 'A')) {
    df$Result[i] <- 'Win'
  } else if ((df$HomeTeam[i] != team & df$FTR[i] == 'H') | (df$AwayTeam[i] != team & df$FTR[i] == 'A')) {
    df$Result[i] <- 'Loss'
  } else if (df$FTR[i] == 'D') {
    df$Result[i] <- 'Draw'
  }else{
    df$Result[i] <- NA
  }
  
}

# Table of last 10 results
Res <- as.data.frame(table(tail(df$Result, 10)))
Res$Percent <- (Res$Freq/sum(Res$Freq))*100

# Last 5 Results
tail(df$Result, 5)

#Ranking

Rank <- RankingDB %>% filter(Team == team)
Rank$Ranking <- as.integer(Rank$Ranking)

p <- plot_ly(Rank, x = ~Matchday, y = ~Ranking, name = Rank$Season, mode = 'lines+markers', color = ~Season) %>%
  layout(yaxis = list(range = c(20, 1), autorange = F, autorange="reversed"))

p

p <- plot_ly(Rank, type = 'scatter', mode = 'lines+markers') %>%
  add_trace(x = ~Matchday, y = ~Ranking, name = Rank$Season, color = ~Season,
    hovertemplate = paste('<b>Position</b>: %{y}',
                          '<br><b>Matchday</b>: %{x}<br>')
  ) %>% 
  layout(yaxis = list(range = c(20, 1), autorange = F, autorange="reversed"))

p

# Choose team
###########

team <- 'Lyon'
df <- CleanDB %>% filter(HomeTeam == team | AwayTeam == team)

df <- df[order(df$Date),]

df$Result <- rep(NA, nrow(df))

for (i in 1:nrow(df)) {
  if ((df$HomeTeam[i] == team & df$FTR[i] == 'H') | (df$AwayTeam[i] == team & df$FTR[i] == 'A')) {
    df$Result[i] <- 'Win'
  } else if ((df$HomeTeam[i] != team & df$FTR[i] == 'H') | (df$AwayTeam[i] != team & df$FTR[i] == 'A')) {
    df$Result[i] <- 'Loss'
  } else if (df$FTR[i] == 'D') {
    df$Result[i] <- 'Draw'
  }else{
    df$Result[i] <- NA
  }
  
}

serie <- c(0)
for (i in 2:nrow(df)) {
  if (df$Result[i] == df$Result[i-1]) {
    serie[i] <- serie[i-1] + 1
  } else if (df$Result[i] != df$Result[i-1]) {
    serie[i] <- 0
  } else {
    serie[i] <- NA
  }
}

serieDraw <- c(0)
for (i in 1:nrow(df)) {
  if (df$Result[i] == 'Win' | df$Result[i] == 'Loss') {
    serieDraw[i+1] <- serieDraw[i] + 1
  } else if (df$Result[i] == 'Draw') {
    serieDraw[i+1] <- 0
  } else {
    serieDraw[i+1] <- NA
  }
}


df$serieDraw <- serieDraw[-length(serieDraw)]

freq_table <- ddply(df, ~Result, summarize, nd0=sum(serieDraw==0),
                    nd1=sum(serieDraw==1), nd2=sum(serieDraw==2), nd3= sum(serieDraw==3),
                    nd4 = sum(serieDraw==4), nd5=sum(serieDraw==5), nd6=sum(serieDraw==6),
                    nd7 = sum(serieDraw==7), nd8 = sum(serieDraw==8), nd9 = sum(serieDraw==9),
                    nd10 = sum(serieDraw==10), nd11 = sum(serieDraw==11), nd12 = sum(serieDraw==12),
                    nd13 = sum(serieDraw==13), nd14 = sum(serieDraw==14), nd15 = sum(serieDraw==15))
totalR <- as.numeric(apply(freq_table[,2:ncol(freq_table)], 2, sum))
totalND <- as.numeric(apply(freq_table[,2:ncol(freq_table)], 1, sum))
freq_table <- rbind(freq_table, c('totalR', totalR))
freq_table$TotalND <- c(totalND, sum(totalR))

Cdl_draw_proba <- c('Cdl_draw_proba')
for (i in 2:ncol(freq_table)) {
  Cdl_draw_proba[i] <- round((as.numeric(freq_table[1,i])/as.numeric(freq_table[4,i]))*100, 2)
}

freq_table <- rbind(freq_table, Cdl_draw_proba)
freq_table

###########

###########
# Whole DB
###########
teams <- as.character(unique(CleanDB$HomeTeam))
teams <- teams[teams != ""]

Team <- c()
Outcome <- c()
Serie_Draw <- c()

for(t in teams) {
  df <- CleanDB %>% filter(HomeTeam == t | AwayTeam == t)
  Result <- c()
  serieDraw <- c(0)
  print(t)
  for (i in 1:nrow(df)) {
    if ((df$HomeTeam[i] == t & df$FTR[i] == 'H') | (df$AwayTeam[i] == t & df$FTR[i] == 'A')) {
      Result[i] <- 'Win'
    } else if ((df$HomeTeam[i] != t & df$FTR[i] == 'H') | (df$AwayTeam[i] != t & df$FTR[i] == 'A')) {
      Result[i] <- 'Loss'
    } else if (df$FTR[i] == 'D') {
      Result[i] <- 'Draw'
    }else{
      Result[i] <- NA
    }
    
    if (Result[i] == 'Win' | Result[i] == 'Loss') {
      serieDraw[i+1] <- serieDraw[i] + 1
    } else if (Result[i] == 'Draw') {
      serieDraw[i+1] <- 0
    } else {
      serieDraw[i+1] <- NA
    }
  }
  serieDraw <- serieDraw[-length(serieDraw)]
  
  No <- match(t, teams)
  print(No)
  
  RepTeam <- rep(sub(" ", "_", t), nrow(df))
  
  Team[[No]] <- RepTeam
  Outcome[[No]] <- Result
  Serie_Draw[[No]] <- serieDraw
  
  t <- sub(" ", "_", t)
  
  Res <- paste("Result", t, sep = "_")
  SD <- paste("serieDraw", t, sep = "_")
  assign(Res, Result)
  assign(SD, serieDraw)
}

Team <- unlist(Team, recursive = TRUE, use.names = TRUE)
Outcome <- unlist(Outcome, recursive = TRUE, use.names = TRUE)
Serie_Draw <- unlist(Serie_Draw, recursive = TRUE, use.names = TRUE)

Finaldf <- data.frame(cbind(Team, Outcome, Serie_Draw))

Finaldf$Team <- as.character(Team)
Finaldf$Outcome <- as.character(Outcome)
Finaldf$Serie_Draw <- as.numeric(Serie_Draw)

freq_table <- ddply(Finaldf, ~Outcome, summarize, nd0=sum(Serie_Draw==0),
                    nd1=sum(Serie_Draw==1), nd2=sum(Serie_Draw==2), nd3= sum(Serie_Draw==3),
                    nd4 = sum(Serie_Draw==4), nd5=sum(Serie_Draw==5), nd6=sum(Serie_Draw==6),
                    nd7 = sum(Serie_Draw==7), nd8 = sum(Serie_Draw==8), nd9 = sum(Serie_Draw==9),
                    nd10 = sum(Serie_Draw==10), nd11 = sum(Serie_Draw==11), nd12 = sum(Serie_Draw==12),
                    nd13 = sum(Serie_Draw==13), nd14 = sum(Serie_Draw==14), nd15 = sum(Serie_Draw==15),
                    nd16 = sum(Serie_Draw==16), nd17 = sum(Serie_Draw==17), nd18 = sum(Serie_Draw==18),
                    nd19 = sum(Serie_Draw==19), nd20 = sum(Serie_Draw==20), nd21 = sum(Serie_Draw==21))
totalR <- as.numeric(apply(freq_table[,2:ncol(freq_table)], 2, sum))
totalND <- as.numeric(apply(freq_table[,2:ncol(freq_table)], 1, sum))
freq_table <- rbind(freq_table, c('totalR', totalR))
freq_table$TotalND <- c(totalND, sum(totalR))

Cdl_draw_proba <- c('Cdl_draw_proba')
for (i in 2:ncol(freq_table)) {
  Cdl_draw_proba[i] <- round((as.numeric(freq_table[1,i])/as.numeric(freq_table[4,i]))*100, 2)
}

freq_table <- rbind(freq_table, Cdl_draw_proba)
freq_table






