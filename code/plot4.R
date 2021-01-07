### R Script for plot 2

library(tidyverse)

### read data
hpc_sub <- read.table("household_power_consumption.txt", header = T, sep = ";") %>%
  ### dates 2007-02-01 and 2007-02-02
  filter(as.Date(Date, "%d/%m/%Y") =="2007-02-01" | as.Date(Date, "%d/%m/%Y") == "2007-02-02")%>%
  ### convert Date and Time to DateTime 
  mutate(DateTime = strptime(paste(Date, Time, sep =""), "%d/%m/%Y %H:%M:%S")) %>%
  ### delete Date and Time
  select(-Date, -Time)%>%
  ### change type   
  mutate_at(vars(c(1:6)), as.numeric)

### plot
png("plot4.png", width=480, height=480)
### layout plot
par(mfrow=c(2,2))
### DateTime - GAP
with(hpc_sub, plot(DateTime, Global_active_power,type="l", xlab="", ylab="Global Active Power (kilowatts)"))
### DateTime - Voltage
with(hpc_sub, plot(DateTime, Voltage, type="l", xlab="datetime", ylab="Voltage"))
### DateTime - ESM
with(hpc_sub, plot(DateTime, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))
with(hpc_sub, lines(DateTime, Sub_metering_2, type ="l", col="red"))
with(hpc_sub, lines(DateTime, Sub_metering_3, type ="l", col="blue"))
legend("topright",lwd=c(1,1,1), col = c("black", "red","blue"),  bty = "n", 
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
### DateTime - GAP
with(hpc_sub, plot(DateTime, Global_reactive_power, type="l", xlab="datetime", ylab="Global_reative_power"))
dev.off()

