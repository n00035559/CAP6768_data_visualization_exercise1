#Data Visualization Exercise
#James Holmes - N00035559

library(tidyverse) 

#PART 1: Initial Exploratory Analysis

#Question 1: What is the sales distribution by product category?
#Variable type: 1 categorical → Use: Bar Chart
#Expected insight: Identify products with highest sales volume

#a
techstore_sales %>%
  ggplot(aes(x = product)) + 
  geom_bar() +
  theme_bw() + #background
  labs(title = "Sales Distribution By Product") +
  theme(plot.title = element_text(hjust = 0.5))

#b 
techstore_sales %>%
  ggplot(aes(x = reorder(product, product, length))) + #sorted in ascending order
  geom_bar() +
  theme_bw() + #background
  labs(title = "Sales Distribution By Product", x = "Product") + #labels
  theme(plot.title = element_text(hjust = 0.5)) +
  coord_flip() #rotate graph

#Question 2: How are product prices distributed?
#Variable type: 1 numerical → Use: Histogram
#Expected insight: Understand price ranges and identify possible outliers

# a) general
techstore_sales %>%
  ggplot(aes(price)) + 
  geom_histogram() +
  theme_bw() +  
  labs(title = "Product Price Distribution") +
  theme(plot.title = element_text(hjust = 0.5))

# b) by product (facetting)
techstore_sales %>%
  ggplot(aes(price)) + 
  facet_grid(~ product) + #facetting function
  geom_histogram(bins = 35, color = "blue", alpha = 0.3, fill = "blue") + #aplpha is transparency level
  theme_bw() +  
  labs(title = "Price Distribution By Product Category") +
  theme(plot.title = element_text(hjust = 0.5))

# PART 2: Relationship Analysis

#Question 3: Is there a relationship between price and customer satisfaction?
#Variable type: 2 numerical → Use: Scatter Plot
#Expected insight: Check if higher prices result in greater satisfaction

# a) general
techstore_sales %>%
  ggplot(aes(x = price, y = satisfaction)) + 
  geom_point() + #point is scatterplot
  theme_bw() +  
  labs(title = "Price vs. Satisfaction") +
  theme(plot.title = element_text(hjust = 0.5))

#b) by product (color)
techstore_sales %>%
  ggplot(aes(x = price, y = satisfaction, color = product)) + 
  geom_point() +  
  theme_bw() +  
  labs(title = "Price vs. Satisfaction") +
  theme(plot.title = element_text(hjust = 0.5))

#Question 4: How do sales vary over time?
#Variable type: Time + numerical → Use: Line Chart
#Expected insight: Identify seasonality and temporal trends

#this does not represent a true time series graph because there 
# are multiple sales on the same date in the data set
techstore_sales %>%
  ggplot(aes(x = sale_date, y = quantity)) + 
  geom_line() + #time series plot
  theme_bw() +
  labs(title = "Sales Over Time") +
  theme(plot.title = element_text(hjust = 0.5))

#need to do the split-apply-combine
techstore_sales %>%
  group_by(sale_date) %>% #split
  summarize(total_quantity = sum(quantity, na.rm = TRUE)) %>% #na.rm to remove missing values
  ungroup() %>%
  ggplot(aes(x = sale_date, y = total_quantity)) + 
  geom_line() + #time series plot
  theme_bw() +
  labs(title = "Sales Over Time") +
  theme(plot.title = element_text(hjust = 0.5))

# Part 3 : Comparative Analysis

#Question 5: How do prices vary across different regions?
#Variable type: 1 categorical + 1 numerical → Use: Box Plot
#Expected insight: Compare price distributions by region

techstore_sales %>%
  ggplot(aes(x = region, y = price, fill = region)) + 
  geom_boxplot() +
  theme_bw() +  
  labs(title = "Price distribution by region") +
  theme(plot.title = element_text(hjust = 0.5))

#Question 6: What is the sales composition by product in each channel?
#Variable type: 2 categorical → Use: Stacked Bar Chart
#Expected insight: Understand product mix by sales channel

techstore_sales %>%
  ggplot(aes(y = product , fill = channel)) + 
  geom_bar(position = "fill") +
  theme_bw() +  
  labs(title = "Sales composition by product channel") +
  theme(plot.title = element_text(hjust = 0.5))

#Propose at least two new visualizations that bring other interesting
#insights about the dataset.

#Regional sales data is often used by district or upper level managers
#for decision making. I used the summarise function above to calculate
#total sales (in $1000) to pipe into a column graph (different bar graph).
#I found this cheatsheet helpful
#https://github.com/rstudio/cheatsheets/blob/main/data-visualization.pdf

# Sales composition by region  
techstore_sales %>%
  group_by(region) %>%
  summarise(total_sales = sum((price * quantity)/1000, na.rm = TRUE)) %>%
  ungroup() %>%
  ggplot(aes(x = region, y = total_sales, fill = total_sales)) +
  geom_col() +
  theme_bw() +
  labs(title = "Sales Composition by Region", y = "Totals Sales (in $1000)") +
  theme(plot.title = element_text(hjust = 0.5))

#Another way to visually represent this would be to use the maps library
#as demonstrated in lecture 3. You could lay the same graph as above
#(Sales composition by region ) on a map of the US with the sales figures.
#That would be both visually appealing and useful.

#pseduocode
#library(maps)
#region_map <- techstore_stales("region) 
#map_sales <- region_map %>% 
  #left_join(total_sales = sum((price * quantity)/1000)
    #by ...
#ggplot(aes(x = region, y = total_sales, fill = total_sales)) +
#geom_polygon() +
#theme_bw() +
#labs(title = "Sales Composition by Region", y = "Totals Sales (in $1000)") +
#theme(plot.title = element_text(hjust = 0.5))






