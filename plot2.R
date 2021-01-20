# PREP: 
# Download data.
filename <- "exdata_data_household_power_consumption.zip"

# Download if not already exist
if (!file.exists(filename)){
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileUrl, filename)
}

# Unzip if not already exist
if (!file.exists("household_power_consumption.txt")){
    unzip(filename)
}

# Read data into R
data <- read.table("household_power_consumption.txt", head = TRUE, sep = ";")
# Subset dat
subdata <- subset(data, data$Date=="1/2/2007" | data$Date =="2/2/2007")
# Convert data type
subdata$Date <- as.Date(subdata$Date, format = "%d/%m/%Y")
subdata$Time <- strptime(subdata$Time, format = "%H:%M:%S")
subdata[1:1440, "Time"] <- format(subdata[1:1440, "Time"], "2007-02-01 %H:%M:%S")
subdata[1441:2880, "Time"] <- format(subdata[1441:2880, "Time"], "2007-02-02 %H:%M:%S")

# PLOT 2
png("plot2.png", width = 480, height = 480)
plot(subdata$Time,
     as.numeric(subdata$Global_active_power),
     xlab = "",
     ylab = "Global Active Power (kilowatts)",
     main = "Global Active Power Vs Time",
     type = "l")
dev.off()