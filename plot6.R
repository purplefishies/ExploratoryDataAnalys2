
## 5. How have emissions from motor vehicle sources changed from
## 1999–2008 in Baltimore City?

library(dplyr)
library(ggplot2)
library(magrittr)

# I use these lines to speed up loading
if ( !exists("NEI") | !exists("NEItbl") ) {
    NEItbl <- tbl_df( readRDS("summarySCC_PM25.rds") )
}
if ( !exists("SCC") ) {
    SCC <- readRDS("Source_Classification_Code.rds")
}

# find all motor vehicle related...ie "Vechicle" is a search word
motorrelated <- which(grepl( as.character( SCC$SCC.Level.Two), pattern=".*vehicle",perl=TRUE,ignore.case=TRUE ))
# A check
# SCC$SCC.Level.Two[which(grepl( as.character( SCC$SCC.Level.Two), pattern=".*vehicle",perl=TRUE,ignore.case=TRUE ))]
SCC_motorrelated <- SCC$SCC[motorrelated]


png("plot6.png")

bmore_and_la<- NEItbl %>%
    filter( SCC %in% SCC_motorrelated ) %>% # SCC must be in the list of motor vehicle related SCC numbers
    filter( fips == 24510 | fips == "06037"  ) %>%  # Filter based on Baltimore  and LA
    group_by( year,fips ) %>%
    summarise( Emissions = sum(Emissions))


# Rename the fips into city names
bmore_and_la$fips <- factor(bmore_and_la$fips,labels=c("LA","Baltimore"))


bmore_and_la %>%
    qplot( year, Emissions, color = fips , data = . , geom = "line" ) %>%
    add(ggtitle("PM2.5 Emissions due to Motor-combustion")) %>%
    print 

dev.off()






