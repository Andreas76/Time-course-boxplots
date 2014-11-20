# Load libraries ----------------------------------------------------------
library(dplyr)
library(reshape)
library(reshape2)
library(ggplot2)

# Read data ---------------------------------------------------------------
setwd("./Data")
data <- read.csv("FRRF_time_series_Thesis_combined.csv", header = TRUE)
setwd("../")

# # Convert to date type ----------------------------------------------------
# data$Date <- as.Date(data$Date, format="%d/%m/%Y")

# Melt dataset ------------------------------------------------------------
data <- melt(data, id.vars = c("Date", "Strain", "Location", "Replicate"))

# Select variables for plotting -------------------------------------------
data <- filter(data, variable == "Sigma" | variable == "Fv.Fm.or.Fq..Fm.")

# Change variable names and order -----------------------------------------
data$variable <- factor(data$variable, levels = c("Fo.or.F.", "Fm.or.Fm.", "Fv.Fm.or.Fq..Fm.", "Sigma"))
levels(data$variable) <- c("Fo", "Fm", "Fv/Fm", "Sigma")

# Prepare for plotting ----------------------------------------------------
plot1 <- ggplot(data = data, aes(x = Strain, y = value, color = Strain)) +
    facet_grid(variable~Location, scales = "free") +
    geom_boxplot(outlier.size = 0.5, size = 0.3) + 
    ggtitle("Long term monitoring of stock cultures\n") +
    ylab("Parameter\n") +
    xlab("\nStrain")

Science_theme = theme(
    axis.line = element_line(size = 0.1, color = "black"),
    legend.position="none",
    panel.background = element_blank(),
    strip.background = element_blank(),
    axis.text.x  = element_text(color="gray16"),
    axis.text.y  = element_text(color="gray16")
)

# Plot --------------------------------------------------------------------
setwd("./Plots")
png(filename = "Stock_culture_time_series_boxplot.png", width = 600, height = 400, units = "px")
print(plot1 + Science_theme)
dev.off()
setwd("../")
