library(data.table)
library(dplyr)

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
dir <- getwd()
download.file(url, file.path(dir, "data.zip"))
unzip(zipfile = "data.zip")

data <- fread(file.path(dir, "household_power_consumption.txt"), na.strings = "?")

datafiltered <- data %>% filter(Date %in% c("1/2/2007","2/2/2007")) %>% 
        mutate(dateTime = as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S"),
               Date = as.Date(Date, tryFormats = "%d/%m/%Y"))

# Plot 3
png("plot3.png", width = 480, height = 480)
plot(x = datafiltered$dateTime, y = datafiltered$Sub_metering_1,
     type = "l", xlab = "", ylab = "Energy sub metering")
lines(x = datafiltered$dateTime, y = datafiltered$Sub_metering_2, col = "red")
lines(x = datafiltered$dateTime, y = datafiltered$Sub_metering_3, col = "blue")
legend("topright",
       col = c("black","red","blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1, lwd = 1)
dev.off()