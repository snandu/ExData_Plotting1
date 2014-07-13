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

# Create plot2
png("plot2.png")
with(df, plot(datetime, Global_active_power, type="l", xlab="", ylab="Global Active Power (Kilowatts)"))
dev.off()

