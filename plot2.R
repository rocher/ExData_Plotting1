#
# Plot 2
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

# 4. Make plot2
#    note: I had to set this locale in order to get day names in english
#          remove if you don't need it
Sys.setlocale(category="LC_TIME", locale="en_US.UTF-8")

par(mrfow=c(1, 1), cex=0.75, mar=c(5, 4, 2, 1)+0.1)
with(hpc,
     plot(Date, Global_active_power, type="l",
          xlab="", ylab="Global Active Power (kilowatts)"))

# 5. Save plot2.png
dev.copy(png, file="plot2.png", width=480, height=480, units="px")
dev.off()
