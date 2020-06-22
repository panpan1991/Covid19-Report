library(readxl)
library(ggplot2)
library(dplyr)

clean.data=read.csv("data.csv")
attach(clean.data)

fit_full=glm(formula = survival ~ factor(gender)+factor(occupation), data = clean.data, family = binomial(link = logit))
summary(fit_full)


count.data=clean.data %>% count(gender, occupation, province)
#clean.data %>% count(gender)

fit_infected=glm(formula = n ~ factor(gender) + factor(occupation)+factor(province), data = count.data, family = poisson(link = 'log'))
summary(fit_infected)


