############################################################
# This code creates the Plot 4 required for the Week 1 
#    Project of Coursera's "Exploratory Data Analysis"
# K.A. Somers
# 09/11/2015
############################################################

# read in data - note missing values are '?'
	hh.data <- read.table("household_power_consumption.txt", header=T, sep=";", na.strings="?")
	
# confirm dimensions are correct - should be 2,075,259 rows and 9 columns
	dim(hh.data)

# re format date/time for easier manipulation
	hh.data$date.fmt <- as.POSIXct(strptime(paste(hh.data$Date, hh.data$Time, sep=" "), format="%d/%m/%Y %H:%M:%S"))
	
# clean data, replacing '?' with NA
	
# select out needed data - Feb 1 and 2 2007
	hh.sub <- hh.data[which(hh.data$date.fmt >= as.POSIXct("2007-02-01 00:00:00 PST") 
						& hh.data$date.fmt < as.POSIXct("2007-02-03 00:00:00 PST")),]
	
# confirm this worked
	unique(hh.sub$Date)	
	dim(hh.sub) # 2880 10
	

	
# Plot 4
# make background white rather than transparent
# also set up 2 x 2 
	par(bg="white", mfrow=c(2,2))

# first panel - top left - same as Plot 2
	plot(hh.sub$date.fmt, hh.sub$Global_active_power, 
			type="l",
			xlab="", ylab="Global Active Power (kilowatts)")

# second panel
	plot(hh.sub$date.fmt, hh.sub$Voltage, 
			type="l",
			xlab="datetime", ylab="Voltage")


# third panel - bottom left - same as Plot 3		
plot(hh.sub$date.fmt, hh.sub$Sub_metering_1, 
			type="l",
			xlab="", ylab="Energy sub metering")
			
# add second sub metering line, colored red
	lines(hh.sub$date.fmt, hh.sub$Sub_metering_2, col="red")

# add third sub metering line, colored blue
	lines(hh.sub$date.fmt, hh.sub$Sub_metering_3, col="blue")

# add legend in top right
	legend("topright", 
				lty=c(1,1,1),
				col=c("black", "red", "blue"),
				legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
				bty="n")
				
				
# fourth panel - bottom right
	plot(hh.sub$date.fmt, hh.sub$Global_reactive_power,
			type="l",
			xlab="datetime", ylab="Global_reactive_power")

# save as 480 px by 480 px
	dev.copy(png, file="plot4.png", width=480, height=480, unit="px")
	dev.off()
