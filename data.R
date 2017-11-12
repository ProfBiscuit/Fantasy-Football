# https://rpubs.com/Radcliffe/superbowl

install.packages('rvest')
install.packages('stringr')
install.packages('tidyr')

library(rvest)
library(stringr)
library(tidyr)

url <- 'http://games.espn.com/ffl/schedule?leagueId=130349&teamId=2'
webpage <- read_html(url)

sb_table <- html_nodes(webpage, 'table')
sb <- html_table(sb_table, fill = TRUE)[[1]]
head(sb)

sb1 <- sb[3:36, 1:5]
names(sb1)[1] <- "Week"
names(sb1)
