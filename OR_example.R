library(epiR)

## note these exapmples are pulled from epiR example files
## @-- Version 2.0.19
## @-- Date 2021-01-12
## @-- Title Tools for the Analysis of Epidemiological Data

##Computes summary measures of risk and a chi-squared test for difference in the observed proportions
#from count data presented in a 2 by 2 table. With multiple strata the function returns crude
#and Mantel-Haenszel adjusted measures of association and chi-squared tests of homogeneity.

##Options fpr method are cohort.count, cohort.time, case.control, or cross.sectional.
#Based on the study design specified by the user, appropriate measures of association,
#measures of effect in the exposed and measures of effect in the population
#are returned by the function.

## EXAMPLE 1:
## A cross sectional study investigating the relationship between dry cat
## food (DCF) and feline urologic syndrome (FUS) was conducted (Willeberg
## 1977). Counts of individuals in each group were as follows:

## DCF-exposed cats (cases, non-cases) 13, 2163
## Non DCF-exposed cats (cases, non-cases) 5, 3349
## Outcome variable (FUS) as columns:
dat <- matrix(c(13,2163,5,3349), nrow = 2, byrow = TRUE)
rownames(dat) <- c("DF+", "DF-"); colnames(dat) <- c("FUS+", "FUS-"); dat
epi.2by2(dat = as.table(dat), method = "cross.sectional",
         conf.level = 0.95, units = 100, outcome = "as.columns")



## Outcome variable (FUS) as rows:
dat <- matrix(c(13,5,2163,3349), nrow = 2, byrow = TRUE)
rownames(dat) <- c("FUS+", "FUS-"); colnames(dat) <- c("DF+", "DF-"); dat
epi.2by2(dat = as.table(dat), method = "cross.sectional",
         conf.level = 0.95, units = 100, outcome = "as.rows")
## Prevalence ratio:
## The prevalence of FUS in DCF exposed cats is 4.01 (95% CI 1.43 to 11.23)
## times greater than the prevalence of FUS in non-DCF exposed cats.


## EXAMPLE 2
library(MASS)
dat1 <- birthwt
head(dat1)
##
## Generate the 2 by 2 table. Exposure (rows) = smoke. Outcome (columns) = low.
tab1 <- table(dat1$smoke, dat1$low, dnn = c("Smoke", "Low BW"))
tab1
print(tab1)


## Compute the incidence risk ratio and other measures of association:
epi.2by2(dat = tab1, method = "cohort.count",
         conf.level = 0.95, units = 100, outcome = "as.columns")


## Odds ratio:
## The odds of having a low birth weight child for smokers is 2.02
## (95% CI 1.08 to 3.78) times greater than the odds of having a low birth
## weight child for non-smokers.
## Now stratify by race:
tab2 <- table(dat1$smoke, dat1$low, dat1$race,
              dnn = c("Smoke", "Low BW", "Race"))
print(tab2)
## Compute the crude odds ratio, the Mantel-Haenszel adjusted odds ratio
## and other measures of association:
rval <- epi.2by2(dat = tab2, method = "cohort.count",
                 conf.level = 0.95, units = 100, outcome = "as.columns")
print(rval)
## The Mantel-Haenszel test of homogeneity of the strata odds ratios is not
## significant (chi square test statistic 2.800; df 2; p-value = 0.25).
## We fail to reect the null hypothesis and conclude that the odds ratios for
## each strata of race are the same.

## no need to stratify