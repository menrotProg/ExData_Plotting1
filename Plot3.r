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


# create a POSIXct column, to serve as the X-axis
wd[, "DateTime"] <- as.POSIXct(strptime(paste(wd[, "Date"], wd[, "Time"], sep=" "), "%d/%m/%Y %H:%M:%S", tz=""))


##
## Plot 3 - multiple lines adjusted to png
##

png(file="plot3.png", width = 480, height = 480)

plot(wd$DateTime, wd$Sub_metering_1, type="l", col="black",
     ylab="Energy Sub Metering", xlab="")

with(wd, lines(wd$DateTime, wd$Sub_metering_2, col="red"))

with(wd, lines(wd$DateTime, wd$Sub_metering_3, col="blue"))

legend("topright", legend=c(names(wd)[7:9]), col=c("black", "red", "blue"), lty=c(1,1))

dev.off()
