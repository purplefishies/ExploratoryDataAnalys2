NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## 1. Have total emissions from PM2.5 decreased in the United States from
## 1999 to 2008? Using the base plotting system, make a plot showing the
## total PM2.5 emission from all sources for each of the years 1999,
## 2002, 2005, and 2008.

peryear <- ddply( NEI, .(year) , summarise, Emissions = sum(Emissions) )

plot(peryear$year,peryear$Emissions,xlab="Year")

dev.copy(png,file"plot1.png")


