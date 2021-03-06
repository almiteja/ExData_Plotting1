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

#plot 1:
png(filename = "~/plot1.png")
hist(hpc_data3$Global_active_power, breaks = 20, col="red", 
     xlab= "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()
