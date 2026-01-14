library(haven)

number_consumers <- 550000
mean_use <- c()






party_panel <- read.csv("Party_Panel.csv") 
party_panel <- party_panel[-27,] # remove final row with summed rows
party_panel <- as.party_panel.frame(apply(party_panel, 2, as.numeric))

frequency_use <- with(party_panel, sum(Gebruik * Frequencies) / sum(Frequencies)) 
















w_var  <- with(party_panel,
               sum(Frequencies * (Gebruik - mean_use)^2) /
                 (sum(Frequencies) - 1) ) 

w_sd   <- sqrt(w_var); w_sd



