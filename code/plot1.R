### R Script for plot 1

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
png("plot1.png", width=480, height=480)
with(hpc_sub,hist(Global_active_power, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", ylab ="Frequency"))
dev.off()


