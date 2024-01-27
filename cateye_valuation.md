---
title: "Cat Eye Valuation by Mileage"
format: html
editor: visual
execute: 
  keep-md: TRUE
  echo: FALSE
  fig-width: 15
---

date: "2024-01-23"

------------------------------------------------------------------------

```{=html}
<style>
  .center-image {
    display: block;
    margin-left: auto;
    margin-right: auto;
  }
</style>
```
## Cat Eye Chevy Trucks

::: cell
``` {.r .cell-code}
library(tidyverse)
library(pander)
library(DT)
library(dplyr)
library(zoo)
library(car)
```
:::

::: cell
``` {.r .cell-code}
cateye <- data.frame("year" = c(2004,2005,2005,2005,2003,2005,2004,2006,2004,2004,2004,2005,2006,2003,2003,2006,2006,2006,2006,2006,2006,2006,2006,2005,2006,2006,2005,2003,2005,2004,2006,2005),
                     "Trim" = c("NA","NA","LS","LS","NA","NA","NA","LS","LS","NA","NA","NA","NA","LS","NA","LT","LT","NA","LS","NA","LS","LS","NA","LS","LT","NA","LS","NA","Base","NA","NA","NA"),
                     "Cab" = c("Crew","Crew","Extended","Extended","Crew","Extended","Crew","Extended","Extended","Extended","Crew","Extended","Extended","Extended","Extended","Crew","Crew","Crew","Extended","Extended","Single","Extended","Crew","Extended","Extended","Crew","Extended","Extended","Extended","Extended","Extended","Extended"),
                     "Mileage" = c(167886,245852,175262,125697,129228,62523,228000,121000,230000, 234000,167000,243000,363000,286000,165000,183000,224447,247603,44484,62278,78011,82853,83403,399917,354000,348038,332410,313000,299630,297039,294000,290541),
                     "Price" = c(8995,8294,10257,11978,15990,18995,5000,6000,5500,7500,8995,5400,4000,3695,12500,9995,6995,8991,12999,9995,11995,12995,14995,7450,4250,5990,6250,7900,3795,6295,4900,3998))
```
:::

## Background

I am currently curious about the resell value of some of my vehicles, most of the time when I buy a vehicle being, a car, pickup, motorcycle, or dirt bike I try to focus on what I could possibly get back out of it when I decide I've had enough and want to move on. This has led me to pretty much purchase nothing very new just based off of general observations. For this analysis we are going to look at **Cat eye Chevy Pickup**. For those unfamiliar, cat eye is a term used to describe the year of Chevrolet Pickups ranging from the years 2003 - 2006 and there was a special model in 2007 that would fit in this range but for the context of this analysis we are only going to focus on 03-06, the cat eye pickups got their name based on the ascetic of the from grill and headlights and their angry expression. Here's an image below:

![](C:/Users/tybin/OneDrive/Desktop/MATH%20325/Statistics-Notebook-master/MATH425/Projects/07-silverclassic-hero.jpg){.center-image}

## My Case

When I was looking at possibly purchasing this style of truck I saw how they stilled seemed to be worth quite a bit disregarding their year and mileage. I did some research and I'm pretty sure I read something about they were produced right before emissions really started cracking down.

With my specific case and mechanical know how I actually put two different trucks together into one, I found on one facebook market place where a tree had fallen and absolutely destroyed the back of the cab and bed for $400$, but the motor seemed to have less mileage on it, then I found a truck with a pretty good condition body for being in the rust belt and paid $2000$. I ended up swapping the motors, and so far everything has gone smoothly. I ended up putting a grand total of $2400$ dollars to get it up and running in good condition. The purpose of this analysis is to see whether or not I actually make a decent decission and what I could possibly sell my truck at.

##  {.tabset .tabset-pills .tabset-fade}

### Hide Data

### Show Data {.tabset}

Here's the data that I collect from numerous sources provided as well as some on facebook marketplace. I gathered mostly information on pickups within the 2003-2006 years as well as those that are classified as 1500 and put an emphasis on those with 5.3L Vortec motors.

::: cell
``` {.r .cell-code}
datatable(cateye, options=list(lengthMenu = c(3,10,30),scrollY=300,scroller=TRUE,scrollX=TRUE), 
            extensions="Scroller")
```

::: cell-output-display
```{=html}
<div class="datatables html-widget html-fill-item" id="htmlwidget-751e50a4e681470df920" style="width:100%;height:auto;"></div>
<script type="application/json" data-for="htmlwidget-751e50a4e681470df920">{"x":{"filter":"none","vertical":false,"extensions":["Scroller"],"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32"],[2004,2005,2005,2005,2003,2005,2004,2006,2004,2004,2004,2005,2006,2003,2003,2006,2006,2006,2006,2006,2006,2006,2006,2005,2006,2006,2005,2003,2005,2004,2006,2005],["NA","NA","LS","LS","NA","NA","NA","LS","LS","NA","NA","NA","NA","LS","NA","LT","LT","NA","LS","NA","LS","LS","NA","LS","LT","NA","LS","NA","Base","NA","NA","NA"],["Crew","Crew","Extended","Extended","Crew","Extended","Crew","Extended","Extended","Extended","Crew","Extended","Extended","Extended","Extended","Crew","Crew","Crew","Extended","Extended","Single","Extended","Crew","Extended","Extended","Crew","Extended","Extended","Extended","Extended","Extended","Extended"],[167886,245852,175262,125697,129228,62523,228000,121000,230000,234000,167000,243000,363000,286000,165000,183000,224447,247603,44484,62278,78011,82853,83403,399917,354000,348038,332410,313000,299630,297039,294000,290541],[8995,8294,10257,11978,15990,18995,5000,6000,5500,7500,8995,5400,4000,3695,12500,9995,6995,8991,12999,9995,11995,12995,14995,7450,4250,5990,6250,7900,3795,6295,4900,3998]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>year<\/th>\n      <th>Trim<\/th>\n      <th>Cab<\/th>\n      <th>Mileage<\/th>\n      <th>Price<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"lengthMenu":[3,10,30],"scrollY":300,"scroller":true,"scrollX":true,"columnDefs":[{"className":"dt-right","targets":[1,4,5]},{"orderable":false,"targets":0},{"name":" ","targets":0},{"name":"year","targets":1},{"name":"Trim","targets":2},{"name":"Cab","targets":3},{"name":"Mileage","targets":4},{"name":"Price","targets":5}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>
```
:::
:::

#  {.tabset .tabset-pills .tabset-fade}

## Linear Regression

For our hypothesis we will be focused on the relationship between the mileage and the price of these Cateye Trucks. Starting out we can describe our linear regression model in the format:

$$
  \underbrace{Y_i}_\text{Price} = \beta_0 + \beta_1 \underbrace{X_i}_\text{Mileage} + \epsilon_i \quad \text{where} \ \epsilon_i \sim N(0, \sigma^2) 
$$

Our hypothesis will take a look at the $\beta_0$ (y-int) and the $\beta_1$ (slope).

### Intercept Hypothesis

For our intercept hypothesis or $\beta_0$ hypothesis we will be able to learn whether the intercept has an affect on the relationship between $price$ and $mileage$ of cat eye pickups. We set a standard $\alpha = 0.05$.

$$
  H_0: \beta_0 = 0
$$ $$
  H_a: \beta_0 \neq 0
$$ $$
  \alpha = 0.05
$$

### Slope Hypethsis

For our slope hypothesis or our $\beta_1$ hypothesis our null hypothesis follows along with our alternate hypothesis, in this situation if we reject the null hypothesis then we can conclude that there is a significant linear relationship between the independent and dependent variable.We set a standard $\alpha = 0.05$.

$$
  H_0: \beta_1 = 0
$$ $$
  H_a: \beta_1 \neq 0
$$ $$
  \alpha = 0.05
$$

### Execution

::: cell
``` {.r .cell-code}
clm <- lm(Price ~ Mileage, data=cateye)
c <- coef(clm)
value_f <- function(x){
  y = c[1] + c[2]*x
  print(y)
}

p <- ggplot(data=cateye) + 
  geom_point(mapping= aes(x=Mileage/1000,
                           y=Price)) + 
  geom_point(aes(x=190,
                 y= 2400, color="red")) + 
  geom_line(aes(x=Mileage/1000,
                y=value_f(Mileage)),color="purple") + 
  xlab("Mileage (1K)")

print(p)
```

::: cell-output-display
![](cateye_valuation_files/figure-html/unnamed-chunk-4-1.png){width="1440"}
:::

::: {.cell-output .cell-output-stdout}
```         
 [1]  9945.155  7596.572  9722.966 11216.021 11109.656 13119.022  8134.331
 [8] 11357.510  8074.085  7953.592  9971.844  7682.483  4067.703  6387.187
[15] 10032.090  9489.873  8241.359  7543.826 13662.414 13126.402 12652.475
[22] 12506.618 12490.050  2955.646  4338.812  4518.406  4989.171  5573.862
[29]  5976.608  6054.658  6146.202  6250.398
```
:::
:::

We can look at the scatter plot above and the linear regression model line being displayed in purple, seeing that there is a seemingly inverse relationship mileage and price, saying as mileage goes up price goes down.

#### Our LM values

::: cell
``` {.r .cell-code}
pander(summary(clm))
```

::: cell-output-display
|                 | Estimate | Std. Error | t value | Pr(\>\|t\|) |
|:---------------:|:--------:|:----------:|:-------:|:-----------:|
| **(Intercept)** |  15002   |    1056    |  14.21  |  7.272e-15  |
|   **Mileage**   | -0.03012 |  0.00446   | -6.754  |  1.73e-07   |

| Observations | Residual Std. Error | $R^2$  | Adjusted $R^2$ |
|:------------:|:-------------------:|:------:|:--------------:|
|      32      |        2499         | 0.6033 |     0.5901     |

: Fitting linear model: Price \~ Mileage
:::
:::

When we look at the table above we find out that that that the we have an **intercept** of $15002$ and a **slope** of $-0.03012$. When looking further we can see that our $p-value$ of our intercept is $7.272e-15$ which is smaller than our $\alpha$ of $0.05$ which leads us to conclude that the intercept within this situation rejects the null hypothesis implying that there is enough evidence to say there's a significant effect of the intercept. When looking at the slope we can see that we have a $p-value$ of $1.73e-07$ which is $<$ than the significance level of $\alpha = 0.05$. From this we can conclude that we can reject the null hypothesis, there is enough evidence to conclude that there is a significant linear relationship between the average price and mileage.

#### Residuals

::: cell
``` {.r .cell-code}
par(mfrow=c(1,3))
plot(clm, which=1)
plot(clm, which=2)
plot(clm, which=3)
```

::: cell-output-display
![](cateye_valuation_files/figure-html/unnamed-chunk-6-1.png){width="1440"}
:::
:::

When looking a the residual plots they honestly look rather decent, the Residuals v. Fitted graph apears to have a strong pull up on the left side, there doesn't appear to be a real strong pull or pattern going one way or the other. The Q-Q plot seems to have some problems towards the far right with normality.

## Non-Linear Adjustment

### Cox Box

::: cell
``` {.r .cell-code}
boxCox(clm)
```

::: cell-output-display
![](cateye_valuation_files/figure-html/unnamed-chunk-7-1.png){width="1440"}
:::
:::

When looking at the Box - Cox graph it looks like we have an interval that covers the areas of $0$ and $0.5$. When we look at our transformations we can see that for these values we can do either $ln_x$ or $\sqrt{(x)}$ transformations, so we'll test both of these to determine which we feel best fits the scenario.

<!-- ### Transitional Graphs -->

::: cell
``` {.r .cell-code}
cat.lm.l <- lm(log(Price) ~ Mileage, data=cateye)
cat.lm.s <- lm(sqrt(Price) ~ Mileage, data=cateye)
```
:::

<!-- # ```{r, message=FALSE} -->

<!-- #  -->

<!-- # par(mfrow=c(1,2)) -->

<!-- # plot(log(Price) ~ Mileage, data=cateye, main="log(x)") -->

<!-- # abline(cat.lm.l,col="red") -->

<!-- # plot(sqrt(Price) ~ Mileage, data=cateye , main="sqrt(x)") -->

<!-- # abline(cat.lm.s, col="blue") -->

<!-- #  -->

<!-- # ``` -->

<!-- #### Compared Residuals -->

<!-- ```{r, message=FALSE} -->

<!-- par(mfrow=c(2,3)) -->

<!-- plot(cat.lm.l, which=1) -->

<!-- plot(cat.lm.l, which=2) -->

<!-- plot(cat.lm.l, which=3) -->

<!-- plot(cat.lm.s, which=1) -->

<!-- plot(cat.lm.s, which=2) -->

<!-- plot(cat.lm.s, which=3) -->

<!-- ``` -->

### Transitional Lines Compared

::: {.cell warnings="false"}
``` {.r .cell-code}
bl <- coef(cat.lm.l)
bs <- coef(cat.lm.s)

cp <- ggplot(data=cateye) + 
  geom_point(mapping= aes(x=Mileage,
                           y=Price)) + 
  stat_function(fun=function(x) {exp(bl[1] + bl[2]*x)}, aes(color="log(y)")) + 
  geom_point(aes(x=190000,
                 y= 2400, color="My personal")) + 
  geom_line(aes(x=Mileage,
                y=value_f(Mileage)),color="purple") + 
  xlab("Mileage (1K)")

print(cp +
  stat_function(fun=function(x) {(bs[1] + bs[2]*x)^2}, aes(color="sqrt(y)")))
```

::: cell-output-display
![](cateye_valuation_files/figure-html/unnamed-chunk-9-1.png){width="1440"}
:::

::: {.cell-output .cell-output-stdout}
```         
 [1]  9945.155  7596.572  9722.966 11216.021 11109.656 13119.022  8134.331
 [8] 11357.510  8074.085  7953.592  9971.844  7682.483  4067.703  6387.187
[15] 10032.090  9489.873  8241.359  7543.826 13662.414 13126.402 12652.475
[22] 12506.618 12490.050  2955.646  4338.812  4518.406  4989.171  5573.862
[29]  5976.608  6054.658  6146.202  6250.398
```
:::
:::

After looking at the residual plots and the grpahed line we've decided that the $ln_x$ method would be the best way to go about this, seeing that the normality in the $ln_x$ seems to be much better an the $\sqrt{x}$ normality is worth throwing out.

Our New Plot would look as such:

::: cell
``` {.r .cell-code}
print(cp)
```

::: cell-output-display
![](cateye_valuation_files/figure-html/unnamed-chunk-10-1.png){width="1440"}
:::

::: {.cell-output .cell-output-stdout}
```         
 [1]  9945.155  7596.572  9722.966 11216.021 11109.656 13119.022  8134.331
 [8] 11357.510  8074.085  7953.592  9971.844  7682.483  4067.703  6387.187
[15] 10032.090  9489.873  8241.359  7543.826 13662.414 13126.402 12652.475
[22] 12506.618 12490.050  2955.646  4338.812  4518.406  4989.171  5573.862
[29]  5976.608  6054.658  6146.202  6250.398
```
:::
:::

The red $ln{x}$ line seems to have a better portrayed curve and estimation of the value.

# Conclusion

::: cell
``` {.r .cell-code}
pred <- function(x) {
  exp(bl[1] + bl[2]*x)
}
# pred(1650000)
# pred(1000000)
# 
# pred(193000)
# pred(300000)
pred_temp_df <- data.frame("Valuation" = c("Scrap Price", "Scrap-Price", "Current Value", "Would Sell Point"),
                           "Mileage" = c("1.65M","1M","193k","300k"),
                           "Estimated Price" = c(pred(1650000),pred(1000000),pred(193000),pred(300000)))
pander(pred_temp_df)
```

::: cell-output-display
|    Valuation     | Mileage | Estimated.Price |
|:----------------:|:-------:|:---------------:|
|   Scrap Price    |  1.65M  |      52.73      |
|   Scrap-Price    |   1M    |      504.7      |
|  Current Value   |  193k   |      8337       |
| Would Sell Point |  300k   |      5748       |
:::
:::

So apparently when using the function to find a value of where the pickup would be, junking prices at ($\$50$) according to Brother Saunders, we would have to have a mileage at $1.65M$ which is definable forced to the extreme. The function also says the value at 1M miles would be approximately ($\$500$) which I would argue would be a more reasonable scrapping price. My truck currently has about $193k$ on the odometer so plugging that into the function pops out the value of $\$8,337$. If I wanted to break even with the amount of money I put in the truck I would have to drive it till about 540k. Odds are I would probably sell it around the $300k$ mile for about $\$5.7k$ and make a decent profit, because let's be honest who is really looking for a vehicle with anything over 200k miles let alone 300k. I'm thinking that I will probably redo or restore the truck to increase the value and make the "decrease" the perceived mileage. So this template will help me keep in mind my selling prices. Which I can then also determine the possible budget that I may want to create.
