


###### Senior Project ####

# load installed packages

library(ggplot2)
library(ggdark)
library(extrafontdb)
library(extrafont)



SOSPdataBL <- read.csv("D:/Bird song recordings/SOSPdataBL.csv") #Blue Lake data path
SOSPdataTB <- read.csv("D:/Bird song recordings/SOSPdataTB.csv") #Trinidad data path

head(SOSPdataBL) #check data appearance
head(SOSPdataTB)

# Combine the datasets
combinedData <- rbind(SOSPdataBL, SOSPdataTB)

# Add a 'Location' column to each dataset
SOSPdataBL$Location <- "Blue Lake"
SOSPdataTB$Location <- "Trinidad"

#quick pass at the mean and the standard deviation
mean(combinedData$dB)
sd(combinedData$freq)

##Spearman rank test##
cor.test(combinedData$freq, combinedData$dB, method ="spearman", exact = FALSE)
         

##stylized theme and formatting of graph with gg plot

# Start by creating a basic plot with ggplot. Plotting data from 'combinedData'.
# 'dB' is on the x-axis, 'freq' on the y-axis, and different colors for each 'Location'.
SOSPplot <- ggplot(combinedData, aes(x=dB, y=freq, col=Location)) + 
  
  # Applying a simple theme to the plot for a professional publication look.
  theme_bw() + 
  
  # Customizing the legend and axis labels to meet JWM requirements:
  theme(legend.title = element_text(size=14),  # Make the legend title a bit larger.
        legend.justification=c(1,0),           # Adjust the legend's position.
        legend.position=c(0.95, 0.05),         # Move the legend to the bottom right.
        legend.background = element_blank(),   # Remove the legend's background.
        legend.key = element_blank(),          # Remove the keys' background in the legend.
        axis.text.y = element_text(color = "black", margin = margin(0, 5, 0, 10)), # Style the y-axis text.
        axis.text.x = element_text(color = "black", margin = margin(5, 0, 10, 0)), # Style the x-axis text.
        text=element_text(size=14,  family ="Century"), # Set a global text style. Modify to your choice(make sure the fonts are imported to r)
        panel.grid.major = element_blank(),    # Remove major grid lines for a cleaner look.
        panel.grid.minor = element_blank(),    # Remove minor grid lines too.
        panel.border = element_blank(),        # Get rid of the panel border.
        axis.line = element_line()) +          # Add lines to the axes.
  
  # Label the y and x axes with user-friendly descriptions.
  labs(y="Song low frequency (Hz)", x="Background noise level (dB)")  + 
  
  # Add points to the plot, making them a bit larger for visibility.
  geom_point(size=5) + 
  
  # Manually set colors for the 'Location' groups, and name the legend entries.
  scale_colour_manual(name = "Location", labels = c("Blue Lake", "Trinidad"), values=c("Blue Lake"="yellow3", "Trinidad"="turquoise4")) + 
  
  # Add a linear model fit to the data, without a shaded confidence interval, and in black.
  geom_smooth(method="lm", formula = y~x, se=FALSE, col="black", size=1)  + 
  
  # Set limits for the x-axis (28 to 60).
  xlim(c(28, 60)) + 
  
  # Set limits for the y-axis (1000 to 5000).
  ylim(c(1000, 5000))



# Create the plot. Export image as PNG from the plots window if you would like to save it.

plot(SOSPplot)


