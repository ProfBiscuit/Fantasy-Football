test <- "http://games.espn.com/ffl/boxscore?leagueId=130349&teamId=2&scoringPeriodId=1&seasonId=2017&view=scoringperiod&version=scoring&mode=h2h"
# teamId, scoringPeriodId, season

# https://rpubs.com/Radcliffe/superbowl

ipak <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg)) 
    install.packages(new.pkg, dependencies = TRUE)
  sapply(pkg, require, character.only = TRUE)
}

packages <- c("rvest", "stringr", "tidyr")

ipak(packages)

sb_table <- html_nodes(read_html(test), 'table')
sb <- html_table(sb_table, fill = TRUE)[[2]]
# head(sb)

# sb[1,]

offense <- sb[3:10,1:34]
# names(offense)
names(offense) <- offense[1, ]
offense <- offense[-1,]

kicker <- html_table(sb_table, fill = TRUE)[[3]]
# names(kicker)
names(kicker) <- kicker[2, ]
kicker <- kicker[-c(1, 2),]
names(kicker)[5]<-""
names(kicker)[33]<-""

dst <- html_table(sb_table, fill = TRUE)[[4]]
# names(dst)
names(dst) <- dst[2, ]
dst <- dst[-c(1, 2),]

# names(offense) == names(kicker)

bench <- html_table(sb_table, fill = TRUE)[[5]]
names(bench) <- bench[2, ]
bench <- bench[-c(1, 2),]

dunno <- union(kicker, dst)



