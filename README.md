## US Wage Data Analysis with R

Source: Bierens, H.J., and D. Ginther (2001): "Integrated Conditional Moment Testing of Quantile Regression Models", Empirical Economics 26, 307-324

Objective: Understand and compare how error is measured within the context of OLS and Tree regression when the dependent (target) variable is a continuous number.

Using the US Wages data, we have compared tree based model and OLS regression model and created the following-

Used Summary statistics and exploratory plots of wage, education, and experience that show a good profile of the distribution of the values as well as the relationships among the variables.

A linear regression model using lm() with wage as dependent (target) variable and education and experience as independent (predictor) variables.

A tree model using rpart() with wage as dependent variable and education and experience as independent variables.

A set of ‘scored’ data. We created predicted values for each of the two models for all data in the model dataset and appended these two new columns to the dataset and export this to a file either csv or Excel.

Calculated the SSE (sum of squared error) for both the OLS and the tree model. At the end, we decided which model is a better ‘fit’.
