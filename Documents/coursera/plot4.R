## Data reading and subsetting
file.info("~/R/household_power_consumption.txt")$size ##Checks file size in bytes
hpc <- read.table("~/R/household_power_consumption.txt", sep = ";" , 
                  header = TRUE, na.strings = "?") ##Read data
mySet <- subset(hpc, Date == "1/2/2007" | Date == "2/2/2007" , 
                select = Date:Sub_metering_3 ) ##Creates a subset on required dates
library(stringr)
mySet$DateTime <- with(mySet,paste(Date, Time)) #Joins date and time in single column
mySet$DateTime <- strptime(mySet$DateTime, format = "%d/%m/%Y %H:%M:%S" ) ##Put data in correct class
mySet$Global_active_power<- as.numeric(mySet$Global_active_power)    ##Put data in correct class

##Plot 4
par(mfrow = c(2,2), cex = 0.5) ##Sets smaller font and 2 x 2 chart matrix

## first plot
with(mySet,plot(DateTime, Global_active_power, ##Create Line chart
     type = "l", 
     ylab = "Global Active Power (kilowatts)", 
     xlab = "")
)

## secont plot
mySet$Voltage = as.numeric(mySet$Voltage)
with(mySet, plot(DateTime, Voltage, ##Create Line chart
     type = "l", 
     ))

## third plot
with(mySet, plot(DateTime,Sub_metering_1 , type = "l", col = "black", ylab = "Energy sub metering", xlab = ""))
with(mySet, points(DateTime,Sub_metering_2 , type = "l", col = "red"))
with(mySet, points(DateTime,Sub_metering_3 , type = "l", col = "blue"))
legend("topright", lwd = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")) ## legend creation

## fourth plot
MySet$Global_reactive_power = as.numeric(mySet$Global_reactive_power)
with(mySet, plot(DateTime, Global_reactive_power, ##Create Line chart
     type = "l" 
     ))

dev.copy(png, file = "plot4.png") ##copy to png file device
dev.off() ##disconnect device
