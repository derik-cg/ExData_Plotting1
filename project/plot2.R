### this script is for data science specialization, the course is exploratory data 
### analysis. This is project for week 1
### this script produces figure 2 in the project

####### get the data and clean it
library(data.table)
library(lubridate)
library(dplyr)
#1 load the data
#create a working directory 
if(!file.exists("~/R/coursera/power"))
{
  #create the directory
  dir.create("~/R/coursera/power")
}
#change to working directory
setwd("~/R/coursera/power")
# if file is not there, download the zipped file
if(!file.exists("power.zip"))
{
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile="power.zip")
  #unzip the file
  unzip("power.zip")
}
#read the file
power<-fread("household_power_consumption.txt",na.strings = "?")
#convert dates and times
dates<-strptime(power$Date,format="%d/%m/%Y")
#save row positions to subset
#dates one is 2007/o2/01 
date1<-which(dates==as.POSIXct("2007-02-01"))
#date two is and 2007/02/02
date2<-which(dates==as.POSIXct("2007-02-02"))
#the first row to subset is
rowstart<-min(date1)
#the last row to subset is
rowend<-max(date2)
#now do the subsetting of the whole data.table
power2days<-power[rowstart:rowend,]
#subset the dates vector in the same rows
dates2days<-dates[rowstart:rowend]
#delete the original data.table to free memory
rm(power)
#delete dates vector to free memory
rm(dates)

################
### figure 2
###############
#this figure is a line plot of global active power
#to make the label, locate the row index where Thu, Fri and Sat occur
#number of rows in day "2007-02-01"
nrows1<-max(date1)-min(date1)
#total number of rows in both days
nrows2<-length(dates2days)

png(filename = "plot2.png")
plot(power2days$Global_active_power,type="l",xaxt="n",ylab="Global Active Power (kilowats)",xlab="")
#the labels occur at the begining and end of day 1 as well as end of day 2
axis(1,at=c(1,nrows1,nrows2),labels=c("Thu","Fri","Sat"))
dev.off()
