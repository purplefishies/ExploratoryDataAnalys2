## 4. Across the United States, how have emissions from coal
## combustion-related sources changed from 1999–2008?

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

# find the coal combustion related SCC numbers

coalrelated <- which(grepl( x=as.character(SCC$Short.Name), pattern=".*coal.*combustion.*",perl=TRUE,ignore.case=TRUE))
SCC_coalrelated <- SCC$SCC[coalrelated]

## 10100217
## 10100218
## 10100237
## 10100238
## 10200217
## 10200218
## 10300217
## 10300218
png("plot4.png")

allcoalrelated <- NEItbl %>%
    filter( SCC %in% SCC_coalrelated ) %>%
    group_by(year) %>%
    summarise( Emissions = sum(Emissions))

g = qplot( year, Emissions, data = allcoalrelated , geom = "line" )
g = g + ggtitle("PM2.5 Emissions due to Coal-combustion related sources")
g

dev.off()






