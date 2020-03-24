#Make sure the right folder has been located using getwd() and setwd() functions.

#Three things to notice:
#1. This txt uses ";" instead of "," to seperate contents.
#2. This file have missing values, and they use "?" instead of "NA"
#3. This file is very big. Since my computer have 16GB of memory, I'm not too worried about this.

HPC <- read.table("household_power_consumption.txt", header = TRUE, sep = ";",na.strings = "?", 
                  colClasses = c("character", "character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))

#Now that I named HPC as the abbreviation of Household_Power_Consumption, I need
#to organize the naming of time to match the requirement.

HPC$Date <- as.Date(HPC$Date, "%d/%m/%Y")

# After this, we only need to analyze the data between 02.01.2007 to 02.02.2007
# We will name this HPC_P1 (AKA HPC Project 1)

HPC_P1 <- subset(HPC, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

# Generetae a Date+Time combined rolumn
DateTime <- paste(HPC_P1$Date, HPC_P1$Time)
DateTime <- setNames(HPC_P1_DateTime, "DateTime")
DateTime <- as.POSIXct(DateTime)

# The name is slightly too long, let's simplify this and remove the seperate
# date and time columns.

P1 <- HPC_P1[,!(names(HPC_P1) %in% c("Date", "Time"))]

P1 <- cbind(DateTime, P1)

# Plot 3
with(P1, {
    plot(Sub_metering_1~DateTime, type="l",
         xlab="", ylab="Global Active Power (kilowatts)")
    lines(Sub_metering_2~DateTime,col='Red')
    lines(Sub_metering_3~DateTime,col='Blue')
})
legend("topright", col=c("black","red","blue"), lwd=c(1,1,1),
       c("Sub_metering_1","Sub_metering_2","Submetering_3"))

# Lastly, we should save the image and close the device.
dev.copy(png,"plot3.png", width=480, height=480)
dev.off()

