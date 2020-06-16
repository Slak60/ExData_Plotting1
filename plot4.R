temp <- tempfile() ## create a temp file to download the .zip file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)##download zip file
power_consumption <- unzip(temp)## unzip file
## read the .txt file
mydata<- read.table("./household_power_consumption.txt", header=TRUE, sep=";",na.strings="?",stringsAsFactors = FALSE)
library(lubridate)
mydf <- transform(subset(mydata, Date=="1/2/2007"| Date =="2/2/2007"),
                  Date=format(as.Date(Date, format="%d/%m/%Y"),"%Y-%m-%d"), 
                  Time=format(strptime(Time, format="%H:%M:%S"),"%H:%M:%S"))
mydf$DateTime <- as.POSIXct(paste(mydf$Date,mydf$Time))
png(file="Plot4.png",width=480,height=480)
my.par <- par(mfrow=c(2,2))
plot(mydf$DateTime,mydf$Global_active_power,type="l",xlab="",ylab="Global Active Power(kilowatts)")
plot(mydf$DateTime,mydf$Voltage,type="l",xlab="datetime",ylab="Voltage")
plot(mydf$DateTime,mydf$Sub_metering_1,type="l",col="black",xlab="",ylab="Energy sub metering")
lines(mydf$DateTime,mydf$Sub_metering_2, col="red")
lines(mydf$DateTime,mydf$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"),
       pch=c("-","-","-"), lty=c(1,1,1),lwd=c(2,2,2), ncol=1)
plot(mydf$DateTime,mydf$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")
par(my.par)
dev.off()