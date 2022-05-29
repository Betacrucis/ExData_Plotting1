# plot 2

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


# plot 2

# PNG device
png("plot2.png", width=480, height= 480)

# Code
library(lubridate)
data_subset$DateTime <- with(data_subset, ymd(data_subset$Date) + hms(data_subset$Time))

plot(data_subset$DateTime,data_subset$Global_active_power, type="l", ylab="Global Active Power (kilowatts)" , xlab="")

# Close device
dev.off()
