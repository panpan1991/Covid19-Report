library(readxl)
library(ggplot2)
library(dplyr)

my_data <- read_excel("data.xlsx", 
                      sheet = "全74批原始数据", 
                      range = cell_cols("A:J"))

attach(my_data)
n=dim(my_data)[1]
#data cleaning

my_data$survival[is.na(my_data$survival)]=1
my_data$gender[my_data$gender=='1']='M'
my_data$gender[my_data$gender=='2']='F'

my_data$occupation[my_data$occupation=='1']='PHYSICIAN'
my_data$occupation[my_data$occupation=='2']='NURSE'
my_data$occupation[my_data$occupation=='3']='OTHER'


#number of survived cases
sum(my_data$survival)
#number of death
n-sum(my_data$survival)

my_data$`diagnosis date`=sub("年","/",my_data$`diagnosis date`)
my_data$`diagnosis date`=sub("月","/",my_data$`diagnosis date`)
my_data$`diagnosis date`=sub("日","",my_data$`diagnosis date`)
my_data$`diagnosis date`=sub(" ","",my_data$`diagnosis date`)

my_data$`diagnosis date`=as.Date(my_data$`diagnosis date`, "%Y/%m/%d")

my_data$id=as.numeric(my_data$id)
my_data$batch=as.numeric(my_data$batch)

my_data$survival=as.numeric(my_data$survival)

write.csv(my_data, file='data.csv', row.names = FALSE)