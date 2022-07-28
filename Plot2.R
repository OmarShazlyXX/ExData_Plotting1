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
data <- mutate(dataset, V1 = as.Date(dataset$V1, format = "%d/%m/%Y"),
               V2 = strptime(dataset$V2, format = "%H:%M:%S"))
data[1:1440,"V2"] <- format(data[1:1440,2],"2007-02-01 %H:%M:%S")
data[1441:2880,"V2"] <- format(data[1441:2880,2],"2007-02-02 %H:%M:%S")
names(data) <- c("Date", "Time", "Global_active_power", "Global_reactive_power",
                 "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2",
                 "Sub_metering_3")
png("Plot2.png", length= 480, width = 480)
with(data, plot(Time, as.numeric(data$Global_active_power), 
                ,type="l",xlab="",ylab="Global Active Power (kilowatts)"))
dev.off()