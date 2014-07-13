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

# Create plot4
png("plot4.png")
par(mfrow=c(2, 2))
# (1, 1)
with(df, plot(datetime, Global_active_power, type="l", xlab="", ylab="Global Active Power"))
# (1, 2)
with(df, plot(datetime, Voltage, type="l", ylab="Voltage"))
# (2, 1)
with(df, plot(datetime, Sub_metering_1, type="n", xlab="", ylab="Energy sub metering"))
with(df, lines(datetime, Sub_metering_1))
with(df, lines(datetime, Sub_metering_2, col="red"))
with(df, lines(datetime, Sub_metering_3, col="blue"))
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd=1, col=c("black", "red", "blue"), bty="n")
# (2 ,2)
with(df, plot(datetime, Global_reactive_power, type="l", ylab="Global_reactive_power"))
dev.off()

