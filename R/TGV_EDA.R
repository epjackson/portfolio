# install required package
install.packages('tidyverse')
install.packages('data.table')

# import tidyverse
library(tidyverse)
library(data.table)

# check current working directory (appears in Console)
getwd()

# importing TGV (France) punctuality data
df_tgv <- read.csv("data/tgv.csv", sep=';')

# rename columns in shortened English
colnames(df_tgv) <- c('Year','Month','Arr_punc_pct','Year-Month','Dep_punc_pct')

# drop 'Year-Month' column as duplicate of dates
df_tgv_clean <- select(df_tgv, -'Year-Month')

# sort dataframe by year then month
setorder(df_tgv_clean, Year, Month)

# round percentages to 2dp
round(df_tgv_clean, digits = 2) -> df_tgv_clean

# call plot and data
ggplot(df_tgv_clean, aes(x=Arr_punc_pct, y=Dep_punc_pct))

# visualise data (default labels)
ggplot(df_tgv_clean, aes(x=Arr_punc_pct, y=Dep_punc_pct)) +
  geom_point()

# add bespoke labels
ggplot(df_tgv_clean, aes(x=Arr_punc_pct, y=Dep_punc_pct)) +
  geom_point() +
  labs(title='Relationship between departure and arrival punctuality as monthly aggregations',
       y='Arrival punctuality(monthly %)', x='Departure punctuality (monthly %)')

# add regression line and amend visual details
ggplot(df_tgv_clean, aes(x=Arr_punc_pct, y=Dep_punc_pct)) +
  geom_point(color='blue', size=2) +
  geom_smooth(method=lm, se=FALSE, linetype="dashed",
              color="red") +
  labs(title='Relationship between departure and arrival punctuality as monthly aggregations',
       y='Arrival punctuality(monthly %)', x='Departure punctuality (monthly %)') +
  theme(plot.title = element_text(size = 12))
