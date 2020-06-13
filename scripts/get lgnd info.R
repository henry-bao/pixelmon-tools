install.packages("XML")
install.packages("RCurl")
install.packages("rlist")
library(XML)
library(RCurl)
library(rlist)
library(dplyr)

theurl <- getURL(
  "https://pixelmonmod.com/wiki/Legendary_Pokemon",
  .opts = list(ssl.verifypeer = FALSE))
tables <- readHTMLTable(theurl)
tables <- list.clean(tables, fun = is.null, recursive = FALSE)
n.rows <- unlist(lapply(tables, function(t) dim(t)[1]))

table <- tables[[which.max(n.rows)]]

lgnd_info <- data.frame(table, stringsAsFactors = FALSE)

lgnd_info <- lgnd_info %>% 
  slice(2:71)

write.csv(lgnd_info, "lgnd_info.csv", row.names = FALSE)
