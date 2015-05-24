
## 3. Of the four types of sources indicated by the type (point,
## nonpoint, onroad, nonroad) variable, which of these four sources have
## seen decreases in emissions from 1999–2008 for Baltimore City? Which
## have seen increases in emissions from 1999–2008? Use the ggplot2
## plotting system to make a plot answer this question.

library(dplyr)
library(ggplot2)

# I use these lines to speed up loading
if ( !exists("NEI") | !exists("NEItbl") ) {
    NEItbl <- tbl_df( readRDS("summarySCC_PM25.rds") )
}
if ( !exists("SCC") ) {
    SCC <- readRDS("Source_Classification_Code.rds")
}

baltyearstype <- NEItbl %>%
    filter( fips == 24510 ) %>%
    group_by(year,type) %>%
    summarise( Emissions = mean(Emissions) )

png("plot3.png")

baltyearstype %>%
    qplot( year, Emissions, color = type , data = . , geom = "line" ) %>%
    add(ggtitle("PM2.5 Emissions in Baltimore for various types")) %>%
    print 


dev.off()






