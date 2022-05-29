# Plot 4

# download file, unzip and load into R
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, "zipfile.zip")
unzip("zipfile.zip")

data <- read.table("household_power_consumption.txt", sep=";", header=TRUE)

# pre processing of columns into Date and Time formats, and numeric data
library(chron)
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$Time <- chron(times=data$Time)
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
data$Voltage <- as.numeric(data$Voltage)
data$Global_intensity <- as.numeric(data$Global_intensity)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

# create subset of the data with the relevant dates
data_subset <- subset(data, data$Date == "2007-02-01" |data$Date == "2007-02-02" )


# plot 4

# PNG device
png("plot4.png", width=480, height= 480)
par(mfrow = c(2,2))


# Code
library(lubridate)
data_subset$DateTime <- with(data_subset, ymd(data_subset$Date) + hms(data_subset$Time))

# top left - same as for plot 2
plot(data_subset$DateTime,data_subset$Global_active_power, type="l", ylab="Global Active Power" , xlab="")

# top right
plot(data_subset$DateTime,data_subset$Voltage, type="l", ylab="Voltage" , xlab="datetime")

# lower left - same as for plot 3
plot(data_subset$DateTime,data_subset$Sub_metering_1, type="l", col="black", ylim=c(0,38), xlab="", ylab="", axes = FALSE)
par(new=TRUE)
plot(data_subset$DateTime,data_subset$Sub_metering_2, type="l", col="red", ylim=c(0,38), xlab="", ylab="", axes = FALSE)
par(new=TRUE)
plot(data_subset$DateTime,data_subset$Sub_metering_3, type="l", col="blue", ylim=c(0,38), xlab="", ylab="Energy sub Metering")
axis(2, at = c(0, 10, 20 ,30))
legend(x = "topright",          # Position
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),  # Legend texts
       lty = c(1, 1, 1),           # Line types
       col = c("black", "red", "blue"),           # Line colors
       lwd = 2,                  # Line width
       bty = "n")                # no boundaries 


# lower right
plot(data_subset$DateTime,data_subset$Global_reactive_power, type="l", ylab="Global_reactive_power" , xlab="datetime")

# Close device
dev.off()

