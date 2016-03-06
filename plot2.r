## plot2.R
## Author: FrankLa
## Last modified: Mar 06, 2016

## 1. Reading the data -------------------------------------------------

## Assuming the file exists in the working directory
## and we know the desired data lie within the first 100k rows of the file
householdPower <- read.table("household_power_consumption.txt", header = TRUE,
                             sep =";", nrows = 100000, na.strings = "?")

householdPower$Date <- as.Date(householdPower$Date, "%d/%m/%Y")


## next, extract the rows from 2007-02-01 to 2007-02-02
householdPower <- subset(householdPower, Date >= as.Date("2007-02-01") 
                         & Date <= as.Date("2007-02-02"))

# create a new date-time variable to be used along x-axis of plots
library(lubridate)
datetime <- hms(householdPower$Time) + householdPower$Date

## 2. Plot the figure on PNG file -----------------------------------

png(filename = "plot2.png", width = 480, height = 480, 
    units = "px", bg = "transparent")
plot(datetime, householdPower$Global_active_power, xlab = "",
     ylab = "Global Active Power (kilowatts)", type = "l")

dev.off()