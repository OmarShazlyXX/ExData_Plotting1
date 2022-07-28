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
par(mfrow = c(2,2), cex=0.5)
with(data, {
plot(Time, Global_reactive_power, type="l",xlab="datetime", 
          ylab="Global_reactive_power")
plot(Time, Voltage, type="l",xlab="datetime", ylab="Voltage")
plot(Time, Sub_metering_1, type="n", xlab="",
                ylab= "Energy sub metering",)
lines(Time, Sub_metering_1,)
lines(Time, Sub_metering_2, col="red")
lines(Time, Sub_metering_3, col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty= 1, col=c("black", "red", "blue"), lwd=2)
plot(Time, Global_reactive_power, type="l",xlab="datetime", 
     ylab="Global_reactive_power")
})
dev.copy(png, file = "Plot4.png")
dev.off()