library(readxl)
library(ggplot2)
my_data <- read_excel("70batches.xlsx", 
                      sheet = "raw 70 batches", 
                      range = cell_cols("A:H"))

my_data$`the date of diagnosis`=sub("年","/",my_data$`the date of diagnosis`)
my_data$`the date of diagnosis`=sub("月","/",my_data$`the date of diagnosis`)
my_data$`the date of diagnosis`=sub("日","/",my_data$`the date of diagnosis`)

which(is.na(my_data$sex))

#Set female indicator as zero
my_data$sex=as.numeric(my_data$sex)
my_data$sex[my_data$sex==2]=0

n=length(my_data$sex)
n_male=sum(my_data$sex, na.rm=TRUE)
n_femal=n-n_male

sex_data <- data.frame(
  sex=c('Male', 'Female'),
  count=c(n_male, n_femal)
)

# Compute percentages
sex_data$fraction = sex_data$count / sum(sex_data$count)

# Compute the cumulative percentages (top of each rectangle)
sex_data$ymax = cumsum(sex_data$fraction)

# Compute the bottom of each rectangle
sex_data$ymin = c(0, head(sex_data$ymax, n=-1))

# Compute label position
sex_data$labelPosition <- (sex_data$ymax + sex_data$ymin) / 2

# Compute a good label
sex_data$label <- paste0(sex_data$sex, "\n Cases: ", sex_data$count)

# Make the plot
ggplot(sex_data, aes(ymax=ymax, ymin=ymin, xmax=4, xmin=3, fill=sex)) +
  geom_rect() +
  geom_label( x=3.5, aes(y=labelPosition, label=label), size=6) +
  scale_fill_brewer(palette=4) +
  coord_polar(theta="y") +
  xlim(c(2, 4)) +
  theme_void() +
  theme(legend.position = "none")

#######################################

