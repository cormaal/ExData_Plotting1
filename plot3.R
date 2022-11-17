## Load dplyr to support the data preparation

library(dplyr)

## N.B. The size of the uncompressed source file "household_power_consumption.txt" is approximately 130 Mb.
## As this exceeds the GitHub limit and I had trouble setting up large file transfer in Github,
## I deleted several hundred thousand lines from the source file to be able to push it to my Github repo.

## I first inspected the source file with Notepad++ and identified the data required for this project (i.e. rows 66638-69518).
## Lines 17-18 read in the first line and create a vector with the variable names.
## Line 19 creates a dataframe by reading in the required data and separating the columns by the designated separator.
## The variable names created in line 18 are added as column names.
## Line 20 adds a new "datetime" column that pastes the values of the Date and Time columns together.
## Line 21 drops the Date and Time columns are they are no longer needed.
## Lastly Line 22 converts the datetime column from character to Date class - our dataset is clean and tidy!

header <- read.table("./data/household_power_consumption.txt", nrows = 1, sep = ";", header = TRUE)
col_names <- variable.names(header)
hpc <- read.table("./data/household_power_consumption.txt", skip = 66637, nrows = 2880, sep = ";", col.names = col_names) %>%
        mutate(datetime = paste(Date, Time)) %>%
        select(3:10) %>%
        mutate(datetime = strptime(datetime, format = "%d/%m/%Y %H:%M:%OS"))


## Line 32 opens the file device with specified file name and dimensions
## Line 34 plots the first line graph (type = "l") with the the specific x&y axis labels, colour and line type
## Line 35 adds the second line with the specific colour and line type
## Line 36 adds the third line with the specific colour and line type
## Line 37 adds the legend in the appropriate place, with the specific line types and colours and the appropriate legends
## Line 39 explicitly closes the graphics device

png(filename = "plot3.png", width = 480, height = 480)

with(hpc, plot(datetime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", col = "black", lty = 1))
with(hpc, lines(datetime, Sub_metering_2, col = "red", lty = 1))
with(hpc, lines(datetime, Sub_metering_3, col = "blue", lty = 1))
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()
