# Load used library
library(data.table)

# File Url
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# Download the file
download.file(fileUrl, destfile="./exdata-data-household_power_consumption.zip", method = "curl")

# Extract File from zip folder
unzip("exdata-data-household_power_consumption.zip")

# Filename
filename <- "household_power_consumption.txt"

# Load Data in R, the separator is ";" and the na strings are denoted with question mark
# verbose = TRUE allows us to analyze how much memory capacity is required to read the file
data <- fread(filename, sep = ";", header = TRUE, na.strings = "?", verbose = TRUE)

# Change the class of Date into Date
data$Date = as.Date(data$Date, "%d/%m/%Y")

# Store dates we want to analyze in a vector
dates <- c(as.Date("2007-02-01"), as.Date("2007-02-02"))

# Subset of the data, limited to the dates we need
data <- data[data$Date %in% dates]

# Building the first plot
hist(as.numeric(data$Global_active_power), col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

# Copy the plot into a png file with the size required
dev.copy(png, file = "plot1.png", width = 480, height = 480)

# Close the graphics device
dev.off()


