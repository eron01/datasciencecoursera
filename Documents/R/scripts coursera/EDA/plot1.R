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

##Plot 1
par(mfrow = c(1,1), cex = 0.75)
hist(mySet$Global_active_power, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", ylab = "Frenquency") ##Create Histogram

dev.copy(png, file = "plot1.png") ##copy to png file device
dev.off() ##disconnect device
