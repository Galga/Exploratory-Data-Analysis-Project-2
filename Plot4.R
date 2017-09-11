Sys.setlocale(category="LC_ALL", locale="English_United States.1252")
library(ggplot2)

path <- getwd()
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = paste(path, "data.zip", sep = "/"))
unzip("data.zip", exdir = "./data")


nei <- readRDS("data/summarySCC_PM25.rds")
scc <- readRDS("data/Source_Classification_Code.rds")

Coal <- scc[grep("Comb.*Coal", scc$Short.Name), "SCC"]
Coalnei <- subset(nei, SCC%in%Coal)
Coalnei_agg <- aggregate(Coalnei$Emissions, by = list(Year = Coalnei$year), FUN = sum)
colnames(Coalnei_agg)[2] <- "Emissions"

png(filename = "Plot4.png", width = 480, height = 480, units = "px")
ggplot(Coalnei_agg, aes(Year, Emissions)) + geom_line() + geom_point() + labs(title = "Total Emissions from coal", x = "Year", y = "Total Emissions")
dev.off()