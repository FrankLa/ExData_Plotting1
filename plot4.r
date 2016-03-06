## plot4.R
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

png(filename = "plot4.png", width = 480, height = 480, 
    units = "px", bg = "transparent")

par(mfcol = c(2,2))

## subfig 1 (top-left)
plot(datetime, householdPower$Global_active_power, xlab = "",
     ylab = "Global Active Power", type = "l")

## subfig 2 (bottom-left)
plot(datetime, householdPower$Sub_metering_1, type = "l", col = "black", 
     xlab = "", ylab = "Energy sub metering")
lines(datetime, householdPower$Sub_metering_2, col = "red")
lines(datetime, householdPower$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black","red","blue"), bty = "n",
       legend = names(householdPower)[7:9])

## subfig 3 (top-right)
plot(datetime, householdPower$Voltage, ylab = "Voltage", type = "l")


## subfig 4 (bottom-right)

plot(datetime, householdPower$Global_reactive_power, 
      ylab = "Global_reactive_power", type = "l")


dev.off()