# https://rpubs.com/Radcliffe/superbowl

ipak <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg)) 
    install.packages(new.pkg, dependencies = TRUE)
  sapply(pkg, require, character.only = TRUE)
}

packages <- c("rvest", "stringr", "tidyr")

ipak(packages)

player <- 1:10

url <- 'http://games.espn.com/ffl/schedule?leagueId=130349&teamId=2'
webpage <- read_html(url)

sb_table <- html_nodes(webpage, 'table')
sb <- html_table(sb_table, fill = TRUE)[[1]]
# head(sb)

sb1 <- sb[3:36, c(1, 2, 4, 5)]
sb1[1, 1] <- "Week"
names(sb1) <- c('Week', 'Result', 'Opponent', 'Owner')

sb2 <- sb1[-1, ]

sb2$Result <- gsub("-", " ", sb2$Result)

#sb2$Record <- substr(sb2$Opponent, nchar(sb2$Opponent)-5+1, nchar(sb2$Opponent))
#sb2$Record <- substr(sb2$Record, 2, 4)

sb2$Opponent <- substr(sb2$Opponent, 1, nchar(sb2$Opponent)-5)

sb3 <- separate(sb2, Result, c('Result', 'PF', 'PA'), sep = ' ', remove = TRUE)
sb3$PF <- as.numeric(sb3$PF)
sb3$PA <- as.numeric(sb3$PA)

# head(sb3, 13)

reg <- sb3[1:13, ]
reg

post <- sb3[14:16, ]
post

################### Draft Above Into a Function ###################

# might have to add column with player id

cleanify <- function(url){
  
  webpage <- read_html(url)

  sb_table <- html_nodes(webpage, 'table')
  sb <- html_table(sb_table, fill = TRUE)[[1]]
  
  sb1 <- sb[3:36, c(1, 2, 4, 5)]
  sb1[1, 1] <- "Week"
  names(sb1) <- c('Week', 'Result', 'Opponent', 'Owner')
  
  sb2 <- sb1[-1, ]
  sb2$Result <- gsub("-", " ", sb2$Result)
  sb2$Opponent <- substr(sb2$Opponent, 1, nchar(sb2$Opponent)-5)
  
  sb3 <- suppressWarnings(separate(sb2, Result, c('Result', 'PF', 'PA'), sep = ' ', remove = TRUE))
  sb3$PF <- suppressWarnings(as.numeric(sb3$PF))
  sb3$PA <- suppressWarnings(as.numeric(sb3$PA))
  
  reg <- sb3[1:13, ]
  
  post <- sb3[14:16, ]
  
  rm(webpage, sb_table, sb, sb1, sb2, sb3)
}

