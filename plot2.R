#Preparation Work


#Download the dataset

          filename <- "exdata-data-household_power_consumption.zip"

#Check if dataset existed
          if (!file.exists("exdata-data-household_power_consumption.zip")){
          fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
          download.file(fileURL, filename, method = "curl")
}

#Check if folder existed
          if(!file.exists("household_power_consumption.txt"))
          unzip(filename)
#Load the data

          data <-read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.string = "?", check.names = FALSE,stringsAsFactors = FALSE,comment.char = "",quote = '\"')

#Convert the Date and Time variable to Date/Time class

          data$Date <- as.Date(data$Date, format = "%d/%m/%Y")


#Select the data from 2007/02/01-2007/02/02
          data <- subset(data, data$Date >= '2007-02-01' & data$Date <= '2007-02-02')

#Combine the Date and Time

          datetime <-paste(data$Date,data$Time)
#Add Datetime to original data
          data$DateTime <- as.POSIXct(datetime)
          
#Export the PNG file
          png(filename = "plot2.png") 

#Draw the diagram

          plot(data$Global_active_power~data$DateTime, type="l",ylab = "Global Active Power (kilowatts)", xlab="")

#Close the device
          dev.off()
          
          