

# 1.c.

# Import heart data and print summary.
heart_data = read.csv('./heart.csv')
# print(summary(heart_data))

# Checks for outliers in a data.frame.
check_outliers = function(col){
  # Compute all values for IQR method.
  interquartile_range = IQR(col)
  Q1 = quantile(col, .25)
  lower_fence = Q1 - (interquartile_range * 1.5)
  Q3 = quantile(col, .75)
  upper_fence = Q3 + (interquartile_range * 1.5)
  
  # If any values are outside of the fences, return true.
  if(any(col < lower_fence | col > upper_fence)){
    TRUE
  }
  
  # Else, return false.
  FALSE
}

# Using the function to check for outliers on the columns of heart_data.
print(sapply(heart_data, check_outliers))