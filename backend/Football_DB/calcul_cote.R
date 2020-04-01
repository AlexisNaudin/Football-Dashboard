rm(list = ls())

cote <- c(3.5, 3.6, 4, 3.7)
bet <- c(30, 30, 100, 100)

probabilities_win <- c()
probabilities_lose <- c()
#proba <- function(cote) {
  for (i in 1:length(cote)) {
    inversion <- 1/cote[i]
    probability_win <- inversion*0.875 # avg margin of bookmakers of 12.5%
    probability_lose <- 1-probability_win
    probabilities_win[i] <- probability_win
    probabilities_lose[i] <- probability_lose
    }

all_win <- prod(probabilities_win)
paste0('probability to win all bets: ', round(all_win*100, 3), ' %')
all_lose <- prod(probabilities_lose)
paste0('probability to lose all bets: ', round(all_lose*100, 3), ' %')
at_least_one_win <- 1-all_lose
paste0('probability to win at least one bet: ', round(at_least_one_win*100, 3), ' %')
expected_gains <- sum(bet*probabilities_win)
paste0('Expected gains: ', round(expected_gains, 3), ' €')

  
#}

