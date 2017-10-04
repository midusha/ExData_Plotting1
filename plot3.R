#read data
alldata <- read.csv2("household_power_consumption.txt", na.strings="?")
alldata$Date <- as.Date(alldata$Date, "%d/%m/%Y")
#subset data for 2 dates
reqData <- subset(alldata, Date == as.Date("01/02/2007", "%d/%m/%Y") | Date == as.Date("02/02/2007", "%d/%m/%Y"))
rm(alldata)
#convert data to required formats
reqData$Time <- format(strptime(reqData$Time, "%H:%M:%S"),"%H:%M:%S")
reqData[] <- lapply(reqData, function(x) if(is.factor(x)) as.numeric(as.character(x)) else x)
#concat date and time
reqData$Time <- strptime(paste(reqData$Date, reqData$Time), "%Y-%m-%d %H:%M:%S")

#start plot 3
par(mar=c(2,2,1,1))
png(file = "plot3.png", bg = "white",  width = 480, height = 480, units = "px")
with(reqData, plot(Time, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))
with(reqData, lines(Time, Sub_metering_2, col="red"))
with(reqData, lines(Time, Sub_metering_3, col="blue"))
legend("topright", lty="solid", col = c("black","red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()