# Load libraries ----------------------------------------------------------
library(ggplot2)

# Read data ---------------------------------------------------------------
setwd("./Data")
data <- read.csv("FRRF_time_series_Thesis.csv", header = TRUE)
setwd("../")

# Convert to date type ----------------------------------------------------
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

# Prepare for plotting ----------------------------------------------------
plot1 <- ggplot(data = data, aes(x = Date, y = Data, group=Strain, color = Strain, shape = Strain)) +
    facet_wrap(Experiment~Location, scale="free_y", drop=TRUE, ncol=1) +
    geom_line() + 
    geom_point() +
    geom_errorbar(aes(ymin = Data - STDEV, ymax = Data + STDEV, width=0.2)) + 
    ggtitle("Monitoring of stock cultures\n") +
    ylab("Result\n") +
    xlab("\nDate") +

Science_theme = theme(
    axis.line = element_line(size = 0.1, color = "black"),
    legend.justification=c(0.01,1), 
    legend.position=c(0,1),
    legend.background = element_blank(),
    legend.key = element_blank(),
    panel.background = element_blank(),
    strip.background = element_blank(),
    axis.text.x  = element_text(color="gray16"),
    axis.text.y  = element_text(color="gray16")
)

# Plot --------------------------------------------------------------------
setwd("./Plots")
png(filename = "Stock_culture_time_series.png", width = 600, height = 600, units = "px")
print(plot1 + Science_theme)
dev.off()
setwd("../")
