Sys.setlocale(category="LC_ALL", locale="English_United States.1252")
library(ggplot2)

path <- getwd()
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = paste(path, "data.zip", sep = "/"))
unzip("data.zip", exdir = "./data")


nei <- readRDS("data/summarySCC_PM25.rds")
Baltimore <- nei[nei$fips == "24510", ]
baltimore_agg <- aggregate(Baltimore$Emissions, by = list(Year = Baltimore$year, Type = Baltimore$type), FUN = sum)
colnames(baltimore_agg)[3] <- "Emissions"

png(filename = "Plot3.png", width = 480, height = 480, units = "px")
ggplot(baltimore_agg, aes(Year,Emissions, colour = Type)) + geom_line() + geom_point() + labs(title = "Emissions in Baltimore City", x = "Year", y = "Emission")
dev.off()