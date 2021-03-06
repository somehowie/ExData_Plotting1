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

# PLOT 3
png("plot3.png", width = 480, height = 480)
# Construct a coordinate system
plot(subdata$Time,
     as.numeric(subdata$Sub_metering_1),
     type = "n",
     xlab = "",
     ylab = "Energy sub metering",
     main = "Energy sub-metering")
# Add lines
with(subdata, lines(Time, as.numeric(Sub_metering_1)))
with(subdata, lines(Time, as.numeric(Sub_metering_2), col = "red"))
with(subdata, lines(Time, as.numeric(Sub_metering_3), col = "blue"))
legend("topright",
       lty = 1,
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1",
                  "Sub_metering_2",
                  "Sub_metering_3"))
dev.off()