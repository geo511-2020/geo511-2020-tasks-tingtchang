library(tidyverse)

# Download the data

dataurl="https://data.giss.nasa.gov/tmp/gistemp/STATIONS/tmp_USW00014733_14_0_1/station.csv"

temp=read_csv(dataurl,
              skip=1, #skip the first line which has column names
              na="999.90", # tell R that 999.90 means missing in this dataset
              col_names = c("YEAR","JAN","FEB","MAR", # define column names 
                            "APR","MAY","JUN","JUL",  
                            "AUG","SEP","OCT","NOV",  
                            "DEC","DJF","MAM","JJA",  
                            "SON","metANN"))
# renaming is necessary becuase they used dashes ("-")
# in the column names and R doesn't like that.

# Explore the data

# view(temp)
# summary(temp)
# glimpse(temp)
# str(temp)

# Plot the average temperature in June, July, August

library(ggplot2)

lineplot <- ggplot(temp, aes(YEAR, JJA)) + 
  geom_line() + 
  geom_smooth(col="red") + 
  xlab("Year") + 
  ylab("Mean Summer Temperature (C)") + 
  ggtitle("Mean Summer Temperature in Buffalo, NY", 
          subtitle = "Summer includes June, July, and August\nData from the Global Historical Climate Network\nRed line is a LOESS smooth")

print(lineplot)

# Save the plot
ggsave("Mean_Temperature.png", dpi=300)