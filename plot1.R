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
# Plot 1
png("plot1.png", width = 480, height = 480)
hist(datafiltered$Global_active_power, col = "red",
     main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()