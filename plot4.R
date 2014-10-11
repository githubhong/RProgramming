## read only two days data 

  TwodaysData<-read.table("C:/Users/a0g331/Desktop/R4/ClassData/household_power_consumption/household_power_consumption.txt",
                        sep=";", header=FALSE,skip=66637, nrows=2880, as.is = c(1,2) )
  names(TwodaysData) <- c("Date", "Time", "Global_active_power","Global_reactive_power", "Voltage", "Global_intensity", 
                        "Sub_metering_1","Sub_metering_2","Sub_metering_3") 
## add a new column with date and time combined
  x<-  paste( TwodaysData[,1], TwodaysData[,2])
  datetime<- strptime(x, "%d/%m/%Y %H:%M:%S")
  AddedColData<- cbind(TwodaysData,datetime)      
## write Plot 4 to PNG file
  png(file = "plot4.png") 
  par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
  with(AddedColData, {
    plot(datetime, Global_active_power, type = "l", xlab="", ylab="Global Active Power")
    plot(datetime, Voltage, type = "l")
    plot(datetime, Sub_metering_1,
         type = "l", xlab="", ylab="Energy sub metering")
    with(AddedColData,points(datetime, Sub_metering_2, type = "l", col ="red"))
    with(AddedColData,points(datetime, Sub_metering_3, type = "l", col ="blue"))      
    legend("topright", pch  = "-", col = c("black","blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
    plot(datetime, Global_reactive_power, type = "l")      
    
  })  
  dev.off()