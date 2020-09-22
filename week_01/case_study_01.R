# Load data
data(iris)

# Calculate the mean Petal Length
petal_length_mean <- mean(iris$Petal.Length)

# Plot the distribution of the Petal Length
hist(iris$Petal.Length,
     main="Histogram for Petal Length",
     xlab="Petal Length",
     las=1)

# Probability Density of the Petal Length
hist(iris$Petal.Length,
     main="Histogram for Petal Length",
     xlab="Petal Length",
     las=1,
     prob=TRUE)

lines(density(iris$Petal.Length), col="blue")

# Load library ggplot2
library(ggplot2)

# Histogram using ggplot2 - qplot
qplot <- qplot(iris$Petal.Length,
               geom="histogram",
               binwidth=0.5,
               main="Histogram for Petal Length",
               xlab="Petal Length",
               fill=I("blue"),
               col=I("blue"),
               alpha=I(0.3))

print(qplot)

# Histogram using ggplot2 - ggplot
ggplot <- ggplot(data=iris, aes(Petal.Length)) + 
  geom_histogram(aes(y=..density..),
                 binwidth = 0.5,
                 col="green",
                 fill="green",
                 alpha=0.2) +
  geom_density(col=2) +
  labs(title="Histogram for Petal Length", x="Petal Length", y="density")

print(ggplot)