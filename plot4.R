# This assignment uses data from the UC Irvine Machine Learning Repository,
# a popular repository for machine learning datasets. In particular, we will be using
# the “Individual household electric power consumption Data Set”.
# The dataset contains measurements of electric power consumption in one household
# with a one-minute sampling rate over a period of almost 4 years. Different electrical
# quantities and some sub-metering values are available.

# The following script creates four different plots related to the dates "2007-02-01" "2007-02-02"
# Plot 1: Global Active Power vs time of the day
# Plot 2: Voltage vs time of the day
# Plot 3: Different energy sub meterings vs time of the day
# Plot 4: Global Reactive Power vs time of the day

# Load used library
library(data.table)

# File Url
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# Zip Folder Name
zipFolder <- "exdata-data-household_power_consumption.zip"

# File Name
fileName <- "household_power_consumption.txt"

# Downloading the data if not done yet
if (!file.exists(zipFolder)) {
    
    # File Destination
    destFile <- paste("./", zipFolder, sep = "")
    
    # File Download
    download.file(fileUrl, destfile=destFile, method = "curl")
    
}

# Unzipping folder if not done yet

if (!file.exists(fileName)) {
    
    # Extract File from zip folder
    unzip(zipFolder)
    
}

# Load Data in R, the separator is ";" and the na strings are denoted with question mark
# verbose = TRUE allows us to analyze how much memory capacity is required to read the file
data <- fread(fileName, sep = ";", header = TRUE, na.strings = c('?'), verbose = TRUE)

# Change the class of Date into Date
data$Date = as.Date(data$Date, format = "%d/%m/%Y")

# Store dates we want to analyze in a vector
dates <- c(as.Date("2007-02-01"), as.Date("2007-02-02"))

# Subset of the data, limited to the dates we need
data <- data[data$Date %in% dates]

# Create a vector called datetime which is the combination of date and time
datetime <- strptime(paste(data$Date, data$Time), format = "%Y-%m-%d %H:%M:%S", tz = "UTC")

# Open the png graphics device
png ("plot4.png", width = 480, height = 480)

# Set up the plot window
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0), bg = "transparent")

# Build the plot n. 1
plot(datetime, data$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")

# Build the plot n. 2
plot(datetime, data$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")

# Build the plot n. 3
plot(datetime, data$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "", col = "black")
lines(datetime, data$Sub_metering_2, type = "l", col = "red")
lines(datetime, data$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = rep("solid",3), col = c("black", "red", "blue"))

# Build the plot n. 4
plot(datetime, data$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime")

# Close the graphics device
dev.off()
