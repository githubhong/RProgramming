## read only two days data 

  TwodaysData<-read.table("C:/Users/a0g331/Desktop/R4/ClassData/household_power_consumption/household_power_consumption.txt",
                        sep=";", header=FALSE,skip=66637, nrows=2880, as.is = c(1,2) )
  names(TwodaysData) <- c("Date", "Time", "Global_active_power","Global_reactive_power", "Voltage", "Global_intensity", 
                        "Sub_metering_1","Sub_metering_2","Sub_metering_3") 
## add a new column with date and time combined
  x<-  paste( TwodaysData[,1], TwodaysData[,2])
  datetime<- strptime(x, "%d/%m/%Y %H:%M:%S")
  AddedColData<- cbind(TwodaysData,datetime)      
## write Plot 3 to PNG file
  png(file = "plot3.png") 
  with(AddedColData, plot(datetime, Sub_metering_1,
                          type = "l", xlab="", ylab="Energy sub metering"))
  with(AddedColData,points(datetime, Sub_metering_2, type = "l", col ="red"))
  with(AddedColData,points(datetime, Sub_metering_3, type = "l", col ="blue"))      
  legend("topright", pch  = "-", col = c("black","blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
  
  dev.off()