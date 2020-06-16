
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
png(file="Plot2.png",width=480,height = 480)
plot(mydf$DateTime,mydf$Global_active_power,type="l",xlab="",ylab="Global Active Power(kilowatts)",lwd=2)
dev.off()