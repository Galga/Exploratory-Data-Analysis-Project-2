Sys.setlocale(category="LC_ALL", locale="English_United States.1252")
library(ggplot2)

path <- getwd()
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = paste(path, "data.zip", sep = "/"))
unzip("data.zip", exdir = "./data")


nei <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

baltimore <- nei[(nei$fips=="24510"), ]
baltimore_agg <- aggregate(baltimore$Emissions, by = list(Year = baltimore$year, Locale = baltimore$fips), FUN = sum)
colnames(baltimore_agg) <- c("Year","Location","Emissions")

la <- nei[(nei$fips=="06037"),]
la_agg <- aggregate(la$Emissions, by = list(Year = la$year, Locale = la$fips), FUN = sum)
colnames(la_agg) <- c("Year","Location","Emissions")

baltimore_agg$Location <- gsub("24510","Baltimore",baltimore_agg$Location)
la_agg$Location <- gsub("06037","Los Angeles",la_agg$Location)

Merge <- rbind(baltimore_agg,la_agg)

png(filename = "Plot6.png", width = 500, height = 480, units = "px")
ggplot(Merge, aes(x=factor(Year), y=Emissions, fill=Location)) + geom_bar(aes(fill = Location), position = "dodge", stat="identity") + labs(x = "Year") + labs(title = "Vehicle emissions in Baltimore and Los Angeles", y = expression("Total Emissions (in log scale) of PM"[2.5])) + xlab("year")
dev.off()