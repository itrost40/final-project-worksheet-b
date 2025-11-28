### Understanding the Dataset

First opening the worksheet, we realized we did not have very much information on the `heart.csv` dataset, so we went searching online for information — we threw some keywords into google, and were able to find an article on `scribbr.com` with an explanation of the dataset.

> [!quote] scribbr.com says
> "The [...] dataset contains observations on the percentage of people biking to work each day, the percentage of people smoking, and the percentage of people with heart disease in an imaginary sample of 500 towns."

With this, we know exactly what each column represents, and we can start working on the first task.
- - -
### Task 1. Identify Variables and Summarize the Data

> [!faq] [i.a.] ***What is the dependent (response) variable in the study? ***
> Luckily, with the information we already gathered about the dataset, we can easily answer this question – the **dependent** variable in this study is **the percentage of people with heart disease**. 
> 
> We can infer this because biking and smoking both have effects on cardiovascular health. So, it is likely this study is trying to find the relationship between these two data points and heart disease.

> [!faq] [i.b] ***Which variables appear to be independent (predictors)?***
> Using the same logic we used to identify the dependent variable, we can also determine the **independent** variables. Logically, the likelihood of having heart disease depends on the habits a given person might have, and **biking and smoking** are exactly that — so it is very likely that these are the independent variables.
>
> We could also determine the independent variables based on whatever the dependent variable is not. Since we already determined heart disease was the dependent variable, biking and smoking must be the independent variables.

> [!faq] [i.c.] ***Are there any variables that show extreme values (outliers) based on the numerical summary?***
> To answer this question, we first need the numerical summary of the dataset, which we get like so:
> > [!bug] Code
> >```r
> ># Import heart data.
> >heart_data = read.csv('./heart.csv')
> >
> ># Print summary.
> >print(summary(heart_data))
> >```
> 
> > [!bug] Output
> > ![[i.a.c.png]]
> 
> But we weren't exactly sure how to find outliers with just this summary, so we went searching for a method — we ended up finding a something called the **IQR Method**:
> > [!info] IQR Method
> > 1. Find Q1 and Q3.
> > 2. Compute the interquartile range (IQR) 
> >  > $IQR = Q3 - Q1$
> > 3. Compute the fences:
> > > Lower fence: $Q1-1.5\cdot IQR$
> > > Upper fence: $Q3 + 1.5 \cdot IQR$
> > 4. Any data point below the lower fence or above the upper fence is considered an outlier.
> 
>  Using this method, we can check if any of the minimum or maximum values of each column are outliers. We decided it would be best to create a function in R that does this for us:
> > [!bug] Code
> > ```R
> > # Checks for outliers in a data.frame.
> > check_outliers = function(col){
> >   # Compute all values for IQR method.
> >   interquartile_range = IQR(col)
> >   Q1 = quantile(col, .25)
> >   lower_fence = Q1 - (interquartile_range * 1.5)
> >   Q3 = quantile(col, .75)
> >   upper_fence = Q3 + (interquartile_range * 1.5)
> >   
> >   # If any values are outside of the fences, return true.
> >   if(any(col < lower_fence | col > upper_fence)){
> >     TRUE
> >   }
> >   
> >   # Else, return false.
> >   FALSE
> > }
> > 
> > # Using the function to check for outliers on the columns of heart_data.
> > print(sapply(heart_data, check_outliers))
> > ```
> 
> > [!bug] Output
> > ![[i.c.2.png]]
>
> Looking at the output we can see that, at least with the IQR method, **there are in fact no formal outliers**. There are other methods like Z-score, but that is likely to produce the same results.

