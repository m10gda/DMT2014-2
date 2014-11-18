################################################################################
########## File: visualize_data.R
################################################################################
########## Purpose: Visualizes data and linear model 
################################################################################

#library("ggplot2"); # library for representation with ggplot
g1 = ggplot(df.train[complete.cases(df.train), ], aes(x = Age)); # set x as Age
g1 = g1 + geom_density(aes(fill = factor(Sex), y = ..count..)) +
  facet_grid(Survived ~ Pclass + Sex); # Plots the number of survived
                                       # as density for Sex
                                       # considering Survived ~ Pclass
                                       # + Sex
g1
plot(g1)
dev.copy(png,'pictures/Class-Age-Sex.png',width = 1920, height = 1080)
dev.off()
