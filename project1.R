
# download file, unzip and load into R
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, "zipfile.zip")
unzip("zipfile.zip")
data <- read.table("household_power_consumption.txt", sep=";", header=TRUE)

# pre processing of columns into Date and Time formats
library(chron)
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$Time <- chron(times=data$Time)

# create subset of the data with the relevant dates
data_subset <- subset(data, data$Date == "2007-02-01" |data$Date == "2007-02-02" )