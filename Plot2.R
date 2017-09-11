Sys.setlocale(category="LC_ALL", locale="English_United States.1252")

path <- getwd()
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = paste(path, "data.zip", sep = "/"))
unzip("data.zip", exdir = "./data")


nei <- readRDS("data/summarySCC_PM25.rds")
Baltimore <- nei[nei$fips == "24510", ]
BaltimoreEmissions_by_year <- aggregate(Baltimore$Emissions, list(Baltimore$year), FUN = "sum")

png(filename = "Plot2.png", width = 480, height = 480, units = "px")
plot(BaltimoreEmissions_by_year, type = "o",  main = "Total Emissions in Baltimore", xlab = "Year",  ylab = "Total Emissions")
dev.off()