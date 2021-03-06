library(data.table)
hpc <- fread("household_power_consumption.txt", 
             stringsAsFactors = FALSE, header = TRUE)
hpc$Date <- as.Date(hpc$Date, format = "%d/%m/%Y")

#subset
set <- hpc[which(hpc$Date == "2007-02-01" | hpc$Date == "2007-02-02"), ]
save <- set
set$Datetime <- as.POSIXct(strptime(paste(set$Date, set$Time), format = "%Y-%m-%d %H:%M:%S"))
set$Global_active_power <- as.numeric(set$Global_active_power)
set$Global_reactive_power <- as.numeric(set$Global_reactive_power)
set$Voltage <- as.numeric(set$Voltage)
set$Global_intensity <- as.numeric(set$Global_intensity)
set$Sub_metering_1 <- as.numeric(set$Sub_metering_1)
set$Sub_metering_2 <- as.numeric(set$Sub_metering_2)
set$Sub_metering_3 <- as.numeric(set$Sub_metering_3)

png(filename = "plot4.png", width = 480, height = 480, units = "px")
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1))
plot(set$Datetime, set$Global_active_power, type = "l", 
     main = "", xlab = "", ylab = "Global Active Power")
plot(set$Datetime, set$Voltage, type = "l", xlab = "datetime",
     ylab = "Voltage")
plot(set$Datetime, set$Sub_metering_1, type = "l", col = "black",
     main = "", xlab = "", ylab = "Energy sub metering")
lines(set$Datetime, set$Sub_metering_2, col = "red")
lines(set$Datetime, set$Sub_metering_3, col = "blue")
legend("topright", col = c("black", "red", "blue"), lty = 1, bty = "n",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(set$Datetime, set$Global_reactive_power, type = "l",
     xlab = "datetime", ylab = "Global_reactive_power")
dev.off()