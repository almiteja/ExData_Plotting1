#downloaded "household_power_consumption.txt" and stored it in my home directory.
#used grep to read the rows for the dates needed
hpc_data <- fread(
        paste("grep ^[12]/2/2007","~/household_power_consumption.txt"),
        na.strings = c("?", ""))
#read the header row of the file to get the column names back
setnames(hpc_data, colnames(fread("~/household_power_consumption.txt",nrows=0)))

hpc_data$Date <- as.Date(hpc_data$Date, "%d/%m/%Y")

hpc_data2 <- mutate(Time = hms(hpc_data$Time))

hpc_data3 <- mutate(hpc_data, Date_Time = paste(Date, Time))

png(filename = "~/plot4.png")

par(mfrow=c(2,2))
plot(hpc_data3$Date_Time, hpc_data3$Global_active_power, type = "l", xlab="", 
     ylab="Global Active Power (kilowatts)")
plot(hpc_data3$Date_Time, hpc_data3$Voltage, type = "l", xlab = "datetime", 
     ylab = "Voltage")
plot(hpc_data3$Date_Time, hpc_data3$Sub_metering_1, ylab="Energy Sub Metering", type = "l")
lines(hpc_data3$Date_Time, hpc_data3$Sub_metering_2, col = "red")
lines(hpc_data3$Date_Time, hpc_data3$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering 1", "Sub_metering 2", "Sub_metering 3"), 
       lwd = 1, col = c("black", "red", "blue"))
plot(hpc_data3$Date_Time, hpc_data3$Global_reactive_power, type = "l", 
     xlab = "datetime", ylab = "Global_reactive_power")
dev.off()
