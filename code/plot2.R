### R Script for plot 2

### read data
hpc_sub <- read.table("household_power_consumption.txt", header = T, sep = ";") %>%
  ### dates 2007-02-01 and 2007-02-02
  filter(as.Date(Date, "%d/%m/%Y") =="2007-02-01" | as.Date(Date, "%d/%m/%Y") == "2007-02-02")%>%
  ### convert Date and Time to DateTime 
  mutate(DateTime = strptime(paste(Date, Time, sep =""), "%d/%m/%Y %H:%M:%S")) %>%
  ### delete Date and Time
  select(-Date, -Time)%>%
  ### change object type   
  mutate_at(vars(c(1:6)), as.numeric)

### plot
png("plot2.png", width=480, height=480)
with(hpc_sub, plot(DateTime, Global_active_power,type="l", xlab="", ylab="Global Active Power (kilowatts)"))
dev.off()

