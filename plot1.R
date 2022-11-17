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


## Line 29 opens the file device with specified file name and dimensions
## Line 31 plots the histogram with the specific colour, title and x axis label
## Line 33 explicitly closes the graphics device

png(filename = "plot1.png", width = 480, height = 480)

with(hpc, hist(Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)"))

dev.off()
