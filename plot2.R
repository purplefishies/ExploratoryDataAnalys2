
## 2. Have total emissions from PM2.5 decreased in the Baltimore City,
## Maryland (fips == "24510") from 1999 to 2008? Use the base plotting
## system to make a plot answering this question.

library(dplyr)

#
# I use these lines to speed up loading
if ( !exists("NEI") | !exists("NEItbl") ) {
    NEItbl <- tbl_df( readRDS("summarySCC_PM25.rds") )
}
if ( !exists("SCC") ) {
    SCC <- readRDS("Source_Classification_Code.rds")
}

baltyears <- NEItbl %>%
    filter( fips == 24510 ) %>%
    group_by(year) %>%
    summarise( Emissions = mean(Emissions) )

minyear <-min(baltyears$year)
maxyear <- max(baltyears$year)
xaxes   <- c(minyear,maxyear,maxyear-minyear)

png("plot2.png")

plot(peryear$year,peryear$Emissions,
     xlab="Year",
     xaxp=xaxes,
     ylab="PM2.5 Emissions (tons)" ,
     main="PM2.5 Emissions for Baltimore"
     )

dev.off()






