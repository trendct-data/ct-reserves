library(readxl)
library(dplyr)

pew <- read_excel("data/ReservesBalancesData.xlsx", sheet=2, skip=5)
states <- pew[,1]


days <- pew[,1:18]
colnames(days) <- c("state", "fy2000", "fy2001", "fy2002", "fy2003",
                    "fy2004", "fy2005", "fy2006", "fy2007", "fy2008",
                    "fy2009", "fy2010", "fy2011", "fy2012", "fy2013",
                    "fy2014", "fy2015", "fy2016")

colnames(states) <- "state"

balance_rainy <- pew[,20:36]
balance_rainy <- cbind(states, balance_rainy)
colnames(balance_rainy) <- c("state", "fy2000", "fy2001", "fy2002", "fy2003",
                    "fy2004", "fy2005", "fy2006", "fy2007", "fy2008",
                    "fy2009", "fy2010", "fy2011", "fy2012", "fy2013",
                    "fy2014", "fy2015", "fy2016")

reserves_percent <- pew[,38:54]
reserves_percent <- cbind(states, reserves_percent)
colnames(reserves_percent) <- c("state", "fy2000", "fy2001", "fy2002", "fy2003",
                             "fy2004", "fy2005", "fy2006", "fy2007", "fy2008",
                             "fy2009", "fy2010", "fy2011", "fy2012", "fy2013",
                             "fy2014", "fy2015", "fy2016")

df1 <- select(days, state, fy2016)
df2 <- select(balance_rainy, state, fy2016)
df16 <- left_join(df1, df2, by="state")
df3 <- select(reserves_percent, state, fy2016)
df16 <- left_join(df16, df3, by="state")

colnames(df16) <- c("state", "Reserve days", "Balance", "Reserves as percent of budget")
df16 <- subset(df16, !is.na(state))
