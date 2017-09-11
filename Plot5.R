Sys.setlocale(category="LC_ALL", locale="English_United States.1252")
library(ggplot2)

path <- getwd()
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = paste(path, "data.zip", sep = "/"))
unzip("data.zip", exdir = "./data")

nei <- readRDS("data/summarySCC_PM25.rds")

vehicle <- subset(nei, fips == "24510" & type == "ON-ROAD")
vehicle_agg <- aggregate(vehicle$Emissions, by = list(Year = vehicle$year), FUN = sum)
colnames(vehicle_agg)[2] <- "Emissions"

png(filename = "Plot5.png", width = 480, height = 480, units = "px")
ggplot(vehicle_agg, aes(Year, Emissions)) + geom_line() + geom_point() + labs(title = "Total Emissions from vehicles", x = "Year", y = "Total Emissions")
dev.off()