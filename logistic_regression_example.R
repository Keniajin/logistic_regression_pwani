
## read in the data
onch <-read.csv("onchall.csv") # Read in CSV data 

m1 <- glm(mf~area, data=onch,family=binomial) # Run model

summary(m1) # Show model

exp(coef(m1))     # transform the coeffs into ORs #
exp(confint(m1))   # and show their CIs


## model 2 adjusting for the age as a confounder
m2 <- glm(mf ~ area  + as.factor(agegrp), data=onch, family=binomial) # Fit the model

m2

exp(coef(m2))     # transform the coeffs into ORs #
exp(confint(m2))   # and show their CIs


summary(m2)