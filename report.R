library(readxl)
library(ggplot2)
library(dplyr)

clean.data=read.csv("data.csv")
attach(clean.data)

fit=glm(formula = survival ~ factor(gender)+factor(occupation)+batch, data = clean.data, family = binomial(link = logit))
summary(fit)

my_data=my_data[order(my_data$'the date of diagnosis'),]

date_summary=data.frame(table(my_data$'the date of diagnosis'))
colnames(date_summary)=c("date", "cases")

