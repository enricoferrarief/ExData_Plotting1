# This assignment uses data from the UC Irvine Machine Learning Repository,
# a popular repository for machine learning datasets. In particular, we will be using
# the “Individual household electric power consumption Data Set”.
# The dataset contains measurements of electric power consumption in one household
# with a one-minute sampling rate over a period of almost 4 years. Different electrical
# quantities and some sub-metering values are available.

# The following script plots the Global Active Power against time of the day
# during the dates 2007-02-01" and "2007-02-02"

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
png ("plot2.png", width = 480, height = 480)

# Build the second plot
par(bg = "transparent")
plot(datetime, data$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")

# Close the graphics device
dev.off()