# Read in Electric Consumption data 
raw <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?")

# Create column with date class
raw$rdate <- as.Date(raw$Date, "%d/%m/%Y")

# Extract rows with dates 2007-02-01 or 2007-02-02
d1 <- as.Date("2007-02-01")
d2 <- as.Date("2007-02-02")
df <- raw[(raw$rdate == d1) | (raw$rdate == d2), ]

# Create column for date time
df$datetime <- strptime(paste(df$Date, df$Time), "%d/%m/%Y %H:%M:%S")
origin <- strptime("01/02/2007 00:00:00", "%d/%m/%Y %H:%M:%S")
df$diff <- difftime(df$datetime, origin, units="secs")

# Create plot3
png("plot3.png")
with(df, plot(datetime, Sub_metering_1, type="n", xlab="", ylab="Energy sub metering"))
with(df, lines(datetime, Sub_metering_1))
with(df, lines(datetime, Sub_metering_2, col="red"))
with(df, lines(datetime, Sub_metering_3, col="blue"))
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd=1, col=c("black", "red", "blue"))
dev.off()

