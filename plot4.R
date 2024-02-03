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
          
          png(filename = "plot4.png") 
          
          
#Setting a 2 by 2 diagram
          
          par(mfrow = c(2, 2), mar = c(4,4,2,1))

          
#Plot the diagram
          
          plot(data$Global_active_power~data$DateTime, type="l",ylab = "Global Active Power (kilowatts)", xlab="")
          
          plot(data$Voltage~data$DateTime, type="l",ylab = "Voltage", xlab="")
          
          with(data, {plot(data$Sub_metering_1~data$DateTime,type="l", ylab = "Energy sub metering", xlab ="")
                    lines(data$Sub_metering_2~data$DateTime, col="red")
                    lines(data$Sub_metering_3~data$DateTime, col="blue")})
          legend("topright", col=c("black","red","blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty =1
          ) 
          
          plot(data$Global_reactive_power~data$DateTime, type="l",ylab = "Global_reactive_power", xlab="")

#Close the device
          dev.off()          
          