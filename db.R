install.packages("RODBC")

library(RODBC)

dbhandle <- odbcDriverConnect(
  'driver={SQL Server};server=satou.cset.oit.edu;database=KatieSP;uid=katie_hughes;pwd=Cactus#3')
dbinsert <- odbcDriverConnect(
  'driver={SQL Server};server=satou.cset.oit.edu;database=KatieSP;uid=katie_hughes;pwd=Cactus#3')

res <- sqlQuery(dbhandle, 'select * from test')

sqlSave(dbhandle, newInfo, tablename = 'test', rownames = FALSE, colnames = FALSE, append=TRUE)

newInfo <- data.frame(BookTitle = "Pride & Prejudice", Author = "Jane Austen")

sqlQuery(dbinsert, 'insert into test values', newInfo)

rm(res, dbhandle, newInfo)

rm(list=ls())
