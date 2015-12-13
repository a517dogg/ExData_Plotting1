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

png(filename = "plot1.png", width = 480, height = 480, units = "px")
hist(set$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency")
dev.off()