# Load dataset from household_power_consumption.txt
# Use grep to filter for dates Feb 1st and 2nd, 2007
tf <- tempfile()
writeLines(grep("^[1|2]/2/2007;.+$",  
                readLines("household_power_consumption.txt"), 
                perl = TRUE, value=TRUE), tf)

df <- read.table(tf, sep=";", na.strings='?')
colnames(df) <- c('Date','Time','Global_active_power',
                  'Global_reactive_power','Voltage',
                  'Global_intensity','Sub_metering_1',
                  'Sub_metering_2','Sub_metering_3')
time <- strptime(paste(df[,"Date"], df[,"Time"]), format="%e/%m/%Y %X")

# Create plot

png("plot3.png", width = 480, height = 480)
plot(time, df[,"Sub_metering_1"], type="l", 
     ylab="Energy sub metering",
     xlab="")
lines(time, df[,"Sub_metering_2"], col="red")
lines(time, df[,"Sub_metering_3"], col="blue")
legend('topright', 
       legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'), 
       lty=1, col=c('black', 'red', 'blue'))
dev.off()