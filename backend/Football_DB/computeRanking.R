# Function computing ranking for a dataset of Football Results from a specific format
#The arguments are the dataset and a Boolean for saving the file as CSV or not

ComputeRanking <- function(db, saveCSV){
  #db <- CleanDB
  teams <- as.character(unique(db$HomeTeam))
  teams <- teams[teams != ""]
  
  Team <- c()
  Outcome <- c()
  Div <- c()
  Season <- c()
  Date <- c()
  GF <- c()
  GA <- c()
  
  for(t in teams) {
    df <- db %>% filter(HomeTeam == t | AwayTeam == t) %>%
      select("Div", "Date", "HomeTeam",
             "AwayTeam", "Season", "FTR", "FTHG", "FTAG")
    Result <- c()
    Division <- c()
    Seas <- c()
    Date2 <- c()
    MD <- c()
    MD_played <- c()
    GFor <- c()
    GAga <- c()
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
      
      if (df$HomeTeam[i] == t) {
        GFor[i] <- df$FTHG[i]
        GAga[i] <- df$FTAG[i]
      } else if (df$AwayTeam[i] == t) {
        GFor[i] <- df$FTAG[i]
        GAga[i] <- df$FTHG[i]
      }else{
        GFor[i] <- NA
        GAga[i] <- NA
      }
      
      Division[i] <- df$Div[i]
      Seas[i] <- df$Season[i]
      Date2[i] <- df$Date[i]
    }
    
    No <- match(t, teams)
    print(paste(No, " ", t))
    
    #RepTeam <- rep(sub(" ", "_", t), nrow(df))
    RepTeam <- rep(t, nrow(df))
    
    Team[[No]] <- RepTeam
    Outcome[[No]] <- Result
    Div[[No]] <- Division
    Season[[No]] <- Seas
    Date[[No]] <- Date2
    GF[[No]] <- GFor
    GA[[No]] <- GAga
    
    t <- sub(" ", "_", t)
    
    Res <- paste("Result", t, sep = "_")
    assign(Res, Result)
  }
  
  Team <- unlist(Team, recursive = TRUE, use.names = TRUE)
  Outcome <- unlist(Outcome, recursive = TRUE, use.names = TRUE)
  Div <- unlist(Div, recursive = TRUE, use.names = TRUE)
  Season <- unlist(Season, recursive = TRUE, use.names = TRUE)
  Date <- unlist(Date, recursive = TRUE, use.names = TRUE)
  GF <- unlist(GF, recursive = TRUE, use.names = TRUE)
  GA <- unlist(GA, recursive = TRUE, use.names = TRUE)
  
  Finaldf <- data.frame(cbind(Div, Season, Date, Team, Outcome, GF, GA))
  
  Finaldf$Team <- as.character(Finaldf$Team)
  Finaldf$Outcome <- as.character(Finaldf$Outcome)
  Finaldf$Date <- as_date(as.numeric(as.character(Finaldf$Date)))
  Finaldf$GF <- as.numeric(as.character(Finaldf$GF))
  Finaldf$GA <- as.numeric(as.character(Finaldf$GA))
  Finaldf$Div <- as.character(Finaldf$Div)
  Finaldf$Season <- as.character(Finaldf$Season)
  
  
  ##### Creation of tables:
  
  Divisions <- unique(Finaldf$Div)
  Seasons <- unique(Finaldf$Season)
  
  Ranking_stats <- data.frame()
  for (t in teams) {
    df <- Finaldf %>% 
      filter(Team == t)
    for (S in unique(df$Season)) {
      print(paste0(t,": ", S))
      df2 <- df %>% 
        filter(Season == S)
      df2 <- df2[order(df2$Date),]
      
      Points <- c()
      Goals_scored <- c()
      Goals_against <- c()
      Wins <- c()
      Draws <- c()
      Losses <- c()
      Played <- c()
      for (i in 1:nrow(df2)) {
        if (i == 1) {
          if (df2$Outcome[i] == "Win") {
            Points[i] <- 3
            Wins[i] <- 1
            Draws[i] <- 0
            Losses[i] <- 0
          } else if (df2$Outcome[i] == "Loss"){
            Points[i] <- 0
            Wins[i] <- 0
            Draws[i] <- 0
            Losses[i] <- 1
          } else if (df2$Outcome[i] == "Draw"){
            Points[i] <- 1
            Wins[i] <- 0
            Draws[i] <- 1
            Losses[i] <- 0
          }
        } else {
          if (df2$Outcome[i] == "Win") {
            Points[i] <- Points[i-1] + 3
            Wins[i] <- Wins[i-1] + 1
            Draws[i] <- Draws[i-1]+ 0
            Losses[i] <- Losses[i-1] + 0
          } else if (df2$Outcome[i] == "Loss"){
            Points[i] <- Points[i-1] + 0
            Wins[i] <- Wins[i-1] + 0
            Draws[i] <- Draws[i-1] + 0
            Losses[i] <- Losses[i-1] + 1
            
          } else if (df2$Outcome[i] == "Draw"){
            Points[i] <- Points[i-1] + 1
            Wins[i] <- Wins[i-1] + 0
            Draws[i] <- Draws[i-1] + 1
            Losses[i] <- Losses[i-1] + 0
          } 
        }
        if (i == 1) {
          Goals_scored[i] <- df2$GF[i]
          Goals_against[i] <- df2$GA[i]
          Played[i] <- 1
        } else {
          Goals_scored[i] <- Goals_scored[i-1] + df2$GF[i]
          Goals_against[i] <- Goals_against[i-1] + df2$GA[i]
          Played[i] <- Played[i-1] + 1
        }
      }
      temp_df <- data.frame(cbind(df2, Points, Played, Goals_scored, Goals_against, Wins, Draws, Losses))
      Ranking_stats <- data.frame(rbind(Ranking_stats, temp_df))
    }
    
  }
  Ranking_stats$Goal_avg <- Ranking_stats$Goals_scored - Ranking_stats$Goals_against
  
  # Function to fill NA with previous value.
  # Arugments are:
  #    1. the object
  #    2. If the first value should it be removed ("rm"), kept as NA ("NA") or filled as 0 ("zero")
  fill <- function(x, first_fill, blank = is.na) {
    
    # Find the values
    if (is.function(blank)) {
      isnotblank <- !blank(x)
    } else {
      isnotblank <- x != blank
    }
    
    # Fill down
    if (first_fill == "rm") {
      x[which(isnotblank)][cumsum(isnotblank)]
    } else if(first_fill == "NA") {
      xfill <- cumsum(isnotblank) 
      xfill[xfill == 0] <- NA
      x[which(isnotblank)][xfill]
    } else if (first_fill == "zero") {
      if (is.numeric(x)==TRUE) {
        xfill <- cumsum(isnotblank) 
        xfill[xfill == 0] <- NA
        x <- x[which(isnotblank)][xfill]
        x[is.na(x)] <- 0
        x
      } else {
        message("Warning: Not feasible for non-numeric argument. NA introduced ")
        xfill <- cumsum(isnotblank) 
        xfill[xfill == 0] <- NA
        x[which(isnotblank)][xfill]
      }
      
    } else {
      message("!Argument 'first_fill' not specified! Arguments are 'rm', 'NA' or 'zero'")
    }
    
  }
  
  
  # Compute the ranking by ordering by points, goal average and goal scored
  All_dates_results <- c()
  for (d in unique(Ranking_stats$Div)) {
    res <- Ranking_stats %>% filter(Div==d)
    
    for (s in unique(res$Season)) {
      res2 <- res %>% filter(Season==s)
      
      # Dataframe with all dates and teams for a given Division and Season
      combs <- merge(unique(res2$Date), unique(res2$Team), all = TRUE)
      names(combs)[names(combs) == 'x'] <- 'Date'
      names(combs)[names(combs) == 'y'] <- 'Team'
      
      # Merge above dataframe with "res2" dataframe to get a DF with results for all dates
      dfm1 <- merge(combs, res2, by = c("Date", "Team"), all.x = TRUE)
      dfm1$Team <- as.character(dfm1$Team)
      # Loop over teams and fill NA with previous value
      for (t in unique(dfm1$Team)) {
        df_team <- dfm1 %>% filter(Team == t)
        df_team <- df_team[order(df_team$Date), ]
        
        df_team$Div <- rep(d, nrow(df_team))
        df_team$Season <- rep(s, nrow(df_team))
        
        
        for (c in names(df_team)) {
          df_team[,c] <- fill(df_team[,c], "zero")
        }
        All_dates_results <- rbind(All_dates_results, df_team)
      }
    }
  }
  
  
  Computed_Ranking <- c()
  for (d in unique(All_dates_results$Div)) {
    rank <- All_dates_results %>% filter(Div==d)
    
    for (s in unique(rank$Season)) {
      rank2 <- rank %>% filter(Season==s)
      
      for (i in unique(rank2$Date)) {
        rank3 <- rank2 %>% filter(Date==i)
        
        rank3 <- rank3[with(rank3, order(-Points, -Goal_avg, -Goals_scored)), ]
        rank3$ranking <- seq.int(nrow(rank3))
        Computed_Ranking <- rbind(Computed_Ranking, rank3)
      }
    }
  }
  if (saveCSV == TRUE) {
    write.table(Computed_Ranking, "./Computed_Ranking.csv", sep = ",", row.names = F)
  }
  
  
  return(Computed_Ranking)
  
}






