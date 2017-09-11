Sys.setlocale(category="LC_ALL", locale="English_United States.1252")

path <- getwd()
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = paste(path, "data.zip", sep = "/"))
unzip("data.zip", exdir = "./data")


nei <- readRDS("data/summarySCC_PM25.rds")
Emissions_by_year <- aggregate(nei$Emissions, list(nei$year), FUN = "sum")

png(filename = "./Plot1.png", width = 480, height = 480, units = "px")
plot(Emissions_by_year, type = "o", main = "Total Emissions in the US", xlab = "Year", ylab = "Total Emissions")
dev.off()
