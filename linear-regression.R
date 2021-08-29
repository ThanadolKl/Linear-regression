install.packages("corrplot")
install.packages("tidyr")
install.packages("ggfortify")
install.packages("lmtest")
install.packages("car")
library(tidyr)

## Prepare dataset
car_dat = mtcars
car_dat
cor_dat <- cor(car_dat)
cor_dat
## Plot correlation 
library(corrplot)
corrplot(cor_dat, method = "ellipse", type = "lower", order = "original", 
         tl.col = "black", tl.srt = 45)
col <- colorRampPalette(c("#BB4444", "#EE9988", "#FFFFFF", "#77AADD", "#4477AA"))
corrplot(cor_dat, method="color", col=col(200),  
         type="lower", order="original", 
         addCoef.col = "black", # Add coefficient of correlation
         tl.col="black", tl.srt=45) #Text label color and rotation)
# Model 1 Y = mpg | x1 = disp, x2 = hp, x3 =  qsec 
## build model
model1 <- lm(mpg~disp+hp+qsec, data = car_dat)
summary(model1)
pred1 <- predict(model1)
head(pred1)
## check assumption 1 Y = mpg | x1 = disp, x2 = hp, x3 =  drat 
#1. linearity 
plot(car_dat$disp, car_dat$mpg, pch = 16, xlab ="Displacement (cu.in.)", ylab = " Miles/(US) gallon", main = "Displacement vs Miles/(US) gallon ")
plot(car_dat$hp, car_dat$mpg, pch = 17, col = "red", xlab ="Gross horsepower (hp)", ylab = " Miles/(US) gallon", main = "Gross horsepower (hp) vs Miles/(US) gallon ")
plot(car_dat$qsec, car_dat$mpg, pch = 18, col = "blue", xlab ="1/4 mile time (qsec)", ylab = " Miles/(US) gallon", main = "1/4 mile time (qsec) vs Miles/(US) gallon ")
#2. Independence 
### no serial 
#3. Normality
library(ggfortify)
autoplot(model1)
#4. Equl 
## x1 = disp
res_x1 <- rstandard(lm(mpg~disp, data = car_dat))
fit_x1 <- predict(lm(mpg~disp, data = car_dat))
plot(fit_x1, res_x1, col = 'red', xlab = 'Fitted values from X1 (disp)', ylab = 'standardize Residuals', main = 'Fitted values from Disp vs Residuals')
abline(0,0)
res_x2 <- rstandard(lm(mpg~hp, data = car_dat))
fit_x2 <- predict(lm(mpg~hp, data = car_dat))
plot(fit_x2, res_x2, col = 'red', xlab = 'Fitted values from X2 (hp)', ylab = 'standardize Residuals', main = 'Fitted values from hp vs Residuals')
abline(0,0)
res_x3 <- rstandard(lm(mpg~qsec, data = car_dat))
fit_x3 <- predict(lm(mpg~qsec, data = car_dat))
plot(fit_x3, res_x3, col = 'red', xlab = 'Fitted values from X3 (qsec)', ylab = 'standardize Residuals', main = 'Fitted values from qsec vs Residuals')
abline(0,0)


# 5. Multicollinearity (check by VIF)
library(car)
vif(model1)

# Model 2 Y = mpg | x1 = disp, x2 =  drat, x3 = wt, 
model2 <- lm(mpg~disp+drat+wt, data = car_dat)
summary(model2)
pred2 <- predict(model2)
head(pred2)
##3. normal
autoplot(model2)
# 4. Equal of variance
res2_x1 <- rstandard(lm(mpg~disp, data = car_dat))
fit2_x1 <- predict(lm(mpg~disp, data = car_dat))
plot(fit2_x1, res2_x1, col = 'blue', xlab = 'Fitted values from X1 (disp)', ylab = 'standardize Residuals', main = 'Fitted values from Disp vs Residuals')
abline(0,0)
res2_x2 <- rstandard(lm(mpg~drat, data = car_dat))
fit2_x2 <- predict(lm(mpg~drat, data = car_dat))
plot(fit2_x2, res2_x2, col = 'blue', xlab = 'Fitted values from X2 (drat)', ylab = 'standardize Residuals', main = 'Fitted values from drat vs Residuals')
abline(0,0)
res2_x3 <- rstandard(lm(mpg~wt, data = car_dat))
fit2_x3 <- predict(lm(mpg~wt, data = car_dat))
plot(fit2_x3, res2_x3, col = 'blue', xlab = 'Fitted values from X3 (wt)', ylab = 'standardize Residuals', main = 'Fitted values from wt vs Residuals')
abline(0,0)
# 5. Multicollinearity (check by VIF)
vif(model2)

