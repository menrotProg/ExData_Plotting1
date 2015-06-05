rm(list=ls())

library(sqldf)

##
## Read from the dataset only the relevant 2 days, using SQL query
##
## Assumes dataset is in the working directory
##


wd <- read.csv.sql(
  "household_power_consumption.txt",
  sql = "select * from file where Date='1/2/2007' OR Date='2/2/2007' ", 
  sep=";",head=TRUE)


## Plot 1 - Histogram

hist(wd$Global_active_power, col="red", main = "Global Active Power")

## Copy to the desired file 
dev.copy(png, file="plot1.png", width = 480, height = 480)
dev.off()

