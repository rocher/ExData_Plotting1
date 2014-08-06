#
# Plot 3
# ------
#
# To create this plot we assume that:
#
#   • you have unzipped the file exdata-data-household_power_consumption.zip
#   • you have the file household_power_consumption.txt in the current dir
#

# 1. Read only data from the dates 2007-02-01 and 2007-02-02
hpc <- read.csv("household_power_consumption.txt", header=FALSE, sep=";",
                na.strings="?", skip=66637, nrows=2880, stringsAsFactors=FALSE)

# 2. Assign col names
names(hpc) <- c("V1", "V2",  # will be transformed to Date
                "Global_active_power",
                "Global_reactive_power",
                "Voltage",
                "Global_intensity",
                "Sub_metering_1",
                "Sub_metering_2",
                "Sub_metering_3")

# 3. Transform V1+V2 to Date
hpc <- transform(hpc, Date=strptime(paste(V1, V2),
                                    format="%d/%m/%Y %H:%M:%S"))

# 4. Make plot3
#    note: I had to set this locale in order to get day names in english
#          remove if you don't need it
Sys.setlocale(category="LC_TIME", locale="en_US.UTF-8")
par(mfrow=c(1, 1), cex=1, mar=c(5, 4, 2, 1)+0.1)
with(hpc, {
    plot(Date, Sub_metering_1, type="l", col="black",
         xlab="", ylab="Energy sub metering")
    points(Date, Sub_metering_2, type="l", col="red", xlab="", ylab="")
    points(Date, Sub_metering_3, type="l", col="blue", xlab="", ylab="")
})
legend("topright", pch=NA, lwd=1, seg.len=1.5,
       # These params may depend on graphic device and font used, in this case
       # an x11 device (and the image on the x11 device is different from the
       # png file!)
       y.intersp=0.66, text.width=40000,
       col=c("black", "red", "blue"),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# 5. Save plot3.png
dev.copy(png, file="plot3.png", width=480, height=480, units="px")
dev.off()
