---
title: "Car Prices"
output: 
  html_document:
    theme: cerulean
    code_folding: hide
---

<br>

## Background
All of the brands within this data set is owned by General Motors. I want to see how much each brand hold their value as they tack on mileage. Cadillac is supposed to be the luxury version of Chevrolet, almost every car company has a luxury version of their basic cars for example Ford has Lincoln.  We will be focusing on the effects of mileage on Cadillac and Chevy four door sedans to see if Cadillac holds its value better. 

```{r, include=FALSE}
# Be sure to download the CarPrices.csv file and save it
# into your Data folder prior to knitting this file.
library(mosaic)
library(car)
library(DT)
library(pander)
CarPrices <- read.csv("../../Data/CarPrices.csv", header=TRUE)

# Remember, to get the CarPrices data into your Console you have
# to use the "Import Dataset" option in the "Environment" window.
```

## {.tabset .tabset-pills .tabset-fade}

### Hide Data

### Show Data {.tabset}

#### Filtered Data

```{r}
ccCars <- CarPrices %>%
  filter(Trim == "Sedan 4D") %>%
  filter(Make == "Cadillac" | Make == "Chevrolet")

datatable(ccCars)
```

#### Original Data
```{r}
datatable(CarPrices)
```

## The Model

A multiple linear regression model was applied to the data to obtain two regression lines, one for each brand. To be precise, the (slightly involved) model is given by:

$$
  \underbrace{Y_i}_{\text{Price}} = \overbrace{\beta_0 + \beta_1 \underbrace{X_{i1}}_{\text{Mileage}}}^{\text{Cadillac}} + \overbrace{\beta_2 \underbrace{X_{i2}}_{\text{1 if Chevrolet}} + \beta_3 \underbrace{X_{i1} X_{i2}}_{\text{Interaction}}}^{\text{Chevy Adjustments to line}} + \epsilon_i
$$

where $\epsilon_i\sim N(0,\sigma^2)$ and $X_{i2} = 0$ when the vehicle is a Cadillac and $X_{i2} = 1$ when the vehicle is a Chevrolet. This forced 0, 1 encoding for $X_{i2}$ produces the following models.

<center>

| Vehicle | Value of $X_{i2}$ | Resulting Model   |
|---------|-------------------|-------------------|
| Cadillac   | $X_{i2} = 0$      | $Y_i = \beta_0 + \beta_1 X_{i1} + \epsilon_i$ |
| Chevrolet | $X_{i2} = 1$      | $Y_i = (\beta_0 + \beta_2) + (\beta_1 + \beta_3) X_{i1} + \epsilon_i$ |

</center>

Showing these separated models for each brand is to demonstrate that $\beta_2$ is the difference between the y-intercepts for the Cadillac and Chevrolet. Similarly, $\beta_3$ is the difference in the slopes for the two models.

Since it is logical to assume that the average cost (y-intercept) of these vehicles is greater than zero, and that all vehicles lose value over time, there is no need to test the coefficients of $\beta_0$ or $\beta_1$ for differences from zero. These are the baseline intercept and slope for the Cadillac vehicles, and we will simply assume they are different from zero. What is of interest however, is whether the regression lines for the Cadillac and Chevrolet have different y-intercepts and different slopes. Thus, there is interest in testing $\beta_2$ and $\beta_3$ for differences from zero.

### Test for Equal y-Intercepts

If $\beta_2$ is zero in the combined regression model, then the y-intercepts, which represent the average cost of a brand new vehicle, are the same for the Cadillac and Chevrolet. If $\beta_2$ is greater than zero, then the Chevrolet costs more on average than the Cadillac when brand new, and if $\beta_2$ is less than zero, then the Chevrolet costs less. These hypotheses will be judged at the $\alpha=0.05$ significance level.

$$
  H_0: \beta_2 = 0 \quad \text{(Equal average cost when brand new)} \\
  H_a: \beta_2 \neq 0 \quad \text{(Non-equal average cost when brand new)}
$$

### Test for Equal slopes

If $\beta_3$ is zero, then the slopes of the two lines are the same. This would imply that the rate of depreciation is the same for both the Cadillac and the Chevrolet. However, if the slopes differ, i.e., $\beta_3 \neq 0$, then one vehicle loses its value faster than the other. These hypotheses will be judged at the $\alpha=0.05$ significance level.

$$
  H_0: \beta_3 = 0 \quad \text{(Equal rates of depreciation)} \\
  H_a: \beta_3 \neq 0 \quad \text{(Non-equal rates of depreciation)}
$$


## The Results
```{r}
## Print regression summary output  
cars_lm <- lm(Price ~ Mileage + as.factor(Make), data=ccCars)
pander(cars_lm, caption="Regression Summary output for Price on Mileage according to Model Type")
  
```

The scatterplot below of Price vs. Mileage of Cadillac and Chevrolet Sedans, and the corresponding regression summary output below the plot, show that Chevrolet Sedans cost \$22,942 less that the Cadillac on average, and holds about the same value overtime as the interaction wasn't significant (p-value = 0.1133483).
More specifically, both brands of sedans depreciate about \$0.18 (18 cents) per each mile driven than does the Corolla (p-value = 0.001012). 

To demonstrate how much this could impact the owner of the vehicle monetarily, assume that both vehicles were purchased at their average new prices of \$41139 (Cadillac) and \$18193 (Chevrolet). Then, assume each vehicle was driven for 50,000 miles then sold for their average 50,000 miles prices of \$32,034 (Cadillac) and \$9,088 (Chevrolet). This would result in a loss of \$9105 for the Cadillac as compared to \$9105 for the Corolla. Besides looking at the loss of value this way you can also look at it as a percenage of change in value assuming the same situation they value would drop by 22.13% (Cadillac) and 50.04% (Chevrolet) showing that even though they deprecate at about the same rate percentage wise the Cadillac Sedans hold their value better.

```{r message=FALSE, warning=FALSE}

## Code for the plot:

  # Declare the color palette for the plot:
  palette(c("firebrick","blue"))

  # Draw plot with default axis labels turned off (xaxt, yaxt):
  plot(Price ~ Mileage, data=ccCars, col=as.factor(Make), pch=16, main="Cost and Depreciation Comparison \n Cadillac vs. Chevrolet 4D Sedans", ylab="Listing Price of the Vehicle", xlab="Mileage of the Vehicle")
  
  # Add legend:
  legend("topright", col=palette(), pch=21, legend=c("Cadillac", "Chevrolet"), bty="n", text.col = palette())

coefvec <- coef(cars_lm)
abline(coefvec[1], coefvec[2], col="firebrick")
abline(coefvec[1]+ coefvec[3], coefvec[2], col="blue")
  
```

The following table provides the actual numbers used in the conclusions given above.


Note that in the table above, "Mileage" is the coefficient estimate for $\beta_1$, "Chevrolet" is the coefficient estimate for $\beta_2$, and "(Intercept)" is the coefficient estimate for $\beta_0$. Thus, "as.factor(Make)Chevrolet" is the difference between the two y-intercepts and "Mileage" is the slope for both brands.

## The Limitations

The constance variance of the data is questionable due to what seems to look like a megaphone in the residuals vs fitted plot. Also, the vertical variability of the dots in the residuals vs. fitted plot seems to be roughly constant across all fitted values, so constant variance can be assumed.The QQ plot appears to show normality. The Residuals vs. Ordered appears to show no pattern.

```{r, fig.height=3}
# This chunk uses ```{r, fig.height=3} to shrink the heigh of the graphs.
par(mfrow=c(1,3))
plot(cars_lm, which=1)
qqPlot(cars_lm$residuals, id=FALSE)
mtext(side=3,text="Q-Q Plot of Residuals")
plot(cars_lm$residuals, type="b")
mtext(side=3, text="Residuals vs. Order")
```


