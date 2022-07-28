if(!file.exists("data.zip")){
  url <- "https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
  download.file(url, destfile = "data.zip", method = "curl")
}
if(!file.exists("Electric power consumption")){
  unzip("data.zip")
}
library(dplyr)
dataset <- read.table("household_power_consumption.txt", nrows = 2880, skip = 66637,
                      na.strings = '?', sep = ";")  #####you can use %in% instead####
names(data) <- c("Date", "Time", "Global_active_power", "Global_reactive_power",
                 "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2",
                 "Sub_metering_3")
png("plot1.png", width=480, height=480)
hist(data$Global_active_power, col = "red", xlab = "Global Active Power(kilowatts)",
     main = "Global Active Power")
dev.off()