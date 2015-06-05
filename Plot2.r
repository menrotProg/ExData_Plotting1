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


## Plot 2 - Line graph

# create a POSIXct column, to serve as the X-axis
wd[, "DateTime"] <- as.POSIXct(strptime(paste(wd[, "Date"], wd[, "Time"], sep=" "), "%d/%m/%Y %H:%M:%S", tz=""))

plot(wd$DateTime, wd$Global_active_power, type="l", ylab="Global Active Power (killowatts)", xlab="")

## Copy to the desired file
dev.copy(png, file="plot2.png", width = 480, height = 480)
dev.off()

