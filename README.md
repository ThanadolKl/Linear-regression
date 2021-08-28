# Linear-regression 
## Authors : Thanadol Klainin 6S No.8 |  Chalisa Pornsukjantra 6C No.6 
### ESC 782 DSS
---
## Contents
* Install package and data visualize
* Filter independence variables
* Model I and assumption check
* Model II and assumption check
* Conclusion
---
## Install packages and data visualization
### Install packages 
~~~
install.packages("corrplot")
install.packages("tidyr")
install.packages("ggfortify")
install.packages("lmtest")
install.packages("car")
~~~
### Dataset visualization
> เพื่อความง่ายในการดู correlation ของข้อมูล เราจึงทำการ Visualize cor(mtcars) ก่อน
~~~ 
car_dat = mtcars
cor_dat <- cor(car_dat)
corrplot(cor_dat, method="color", col=col(200),  
         type="lower", order="original", 
         addCoef.col = "black", 
         tl.col="black", tl.srt=45) 
~~~
![cor_plot_number](https://user-images.githubusercontent.com/67301601/131223486-f49bb62c-733b-418f-afe4-273dcb55377f.png)
> จะเห็นว่า จากตารางแสดง cor(mtcars) ซึ่งค่อนข้างดูยาก เมื่อนำมา Visualize จะทำให้สังเกตเห็นความสัมพันธ์ที่ง่ายมากขึ้น
---
## Filter independence variables

 
# Model 1 
> Model 1 เราเลือกใช้ Regressors 3 ตัว คือ 1. disp, 2. = hp, 3. =  drat  ซึ่งจากรูป cor ข้างบนจะเห็นว่ามีบางตัวแปรค่อนข้างมี strong correlation แต่เราจะนำไปตรวจสอบ Multicollinearity ทีหลัง 
~~~
model1 <- lm(mpg~disp+hp+drat, data = car_dat)
summary(model1)
~~~
## check Assumptions 
### 1. linearity 
![model1_disp](https://user-images.githubusercontent.com/67301601/131223659-cf25acc4-b4eb-4da8-84da-1eda6dd52e03.png)
![model1_hp](https://user-images.githubusercontent.com/67301601/131223677-64a4423b-2fd6-4c25-a571-b2b548413636.png)
![model1_drat](https://user-images.githubusercontent.com/67301601/131223688-067ad237-b6f7-4e61-b948-e1e79946f27b.png)
> จะเห็นว่าความสัมพันธ์ระหว่าง x1, x2, x3 กับ Y (mpg) ค่อนข้างเป็น linear
### 2. Independence 
> mtcars dataset ไม่ใช่ serial data ดังนั้นข้อมูลแต่ละตัวจะเป็นอิสระต่อกันอยู่แล้ว
### 3. Normality
~~~
library(ggfortify)
autoplot(model1)
~~~
![model1_normality](https://user-images.githubusercontent.com/67301601/131223820-462dc4f2-cc23-4a56-a1fc-d8768868b5b7.png)
> จะเห็นว่า กราฟที่ 1(บนซ้าย) Residuals vs fitted จะกระจายตัวกันแบบไม่มี Pattern และ กราฟที่ 2 (บนขวา) Normal Q-Q ข้อมูลกระจายตัวค่อน Normal มี Outliers อยู่ด้านบน ๆ
### 4. Equal variance

# 5. Multicollinearity (check by VIF)
> จากการดูความสัมพันธ์ของข้อมูลพบว่ามี x บางตัวที่มี Strong correlation แต่จากการกรองตัวแปรที่พอจะใช้ได้ ก็จำเป็นต้องใช้ตัวแปรที่มี strong correlation อันนี้ แล้วค่อยนำไปตรวจสอบค่า VIF ทีหลัง
~~~
vif(model1)
~~~
> Output 
~~~
    disp       hp     drat 
4.621988 2.868264 2.166843 
~~~
> จะเห็นว่าค่า VIF <10 ดังนั้น model นี้ ยังไม่เกิด Multicollinearity
### Summary model  1 
~~~
lm(formula = mpg ~ disp + hp + drat, data = car_dat)

Residuals:
    Min      1Q  Median      3Q     Max 
-5.1225 -1.8454 -0.4456  1.1342  6.4958 

Coefficients:
             Estimate Std. Error t value Pr(>|t|)   
(Intercept) 19.344293   6.370882   3.036  0.00513 **
disp        -0.019232   0.009371  -2.052  0.04960 * 
hp          -0.031229   0.013345  -2.340  0.02663 * 
drat         2.714975   1.487366   1.825  0.07863 . 
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 3.008 on 28 degrees of freedom
Multiple R-squared:  0.775,	Adjusted R-squared:  0.7509 
F-statistic: 32.15 on 3 and 28 DF,  p-value: 3.28e-09
~~~

# Model 2
> Model 2 เราเลือกใช้ Regressors 3 ตัว คือ 1. disp, 2. = drat, 3. =  wt  ซึ่งจากรูป cor ข้างบนจะเห็นว่ามีบางตัวแปรค่อนข้างมี strong correlation แต่เราจะนำไปตรวจสอบ Multicollinearity ทีหลัง
~~~
model2 <- lm(mpg~disp+drat+wt, data = car_dat)
summary(model2)
~~~
## check Assumptions 
### 1. linearity 
![model2_disp2](https://user-images.githubusercontent.com/67301601/131224255-7f696ed8-9d98-4739-9301-846687b14018.png)
![model2_drat2](https://user-images.githubusercontent.com/67301601/131224295-4b6284ad-e915-41f2-9d7e-e755fd3d93e7.png)
![wt2](https://user-images.githubusercontent.com/67301601/131224306-6c6b8ccb-54ed-4cfa-b440-ef43fa95e8ad.png)
> จะเห็นว่าความสัมพันธ์ระหว่าง x1, x2, x3 กับ Y (mpg) ค่อนข้างเป็น linear
### 2. Independence 
> mtcars dataset ไม่ใช่ serial data ดังนั้นข้อมูลแต่ละตัวจะเป็นอิสระต่อกันอยู่แล้ว
### 3. Normality
~~~
library(ggfortify)
autoplot(model2)
~~~
![model2_normal](https://user-images.githubusercontent.com/67301601/131224333-24faa0a6-edf6-4b00-abdd-baf0521a4642.png)
> จะเห็นว่า กราฟที่ 1(บนซ้าย) Residuals vs fitted จะกระจายตัวกันแบบไม่มี Pattern และ กราฟที่ 2 (บนขวา) Normal Q-Q ข้อมูลกระจายตัวค่อน Normal มี Outliers อยู่ด้านบน ๆ
### 4. Equal variance

# 5. Multicollinearity (check by VIF)
> จากการดูความสัมพันธ์ของข้อมูลพบว่ามี x บางตัวที่มี Strong correlation แต่จากการกรองตัวแปรที่พอจะใช้ได้ ก็จำเป็นต้องใช้ตัวแปรที่มี strong correlation อันนี้ แล้วค่อยนำไปตรวจสอบค่า VIF ทีหลัง
~~~
vif(model1)
~~~
> Output 
~~~
    disp     drat       wt 
5.018343 2.155314 5.050627 
~~~
> จะเห็นว่าค่า VIF <10 ดังนั้น model นี้ ยังไม่เกิด Multicollinearity
### Summary model  2
~~~
Call:
lm(formula = mpg ~ disp + drat + wt, data = car_dat)

Residuals:
    Min      1Q  Median      3Q     Max 
-3.2342 -2.3719 -0.3148  1.6315  6.2820 

Coefficients:
             Estimate Std. Error t value Pr(>|t|)    
(Intercept) 31.043257   7.099792   4.372 0.000154 ***
disp        -0.016389   0.009578  -1.711 0.098127 .  
drat         0.843965   1.455051   0.580 0.566537    
wt          -3.172482   1.217157  -2.606 0.014495 *  
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 2.951 on 28 degrees of freedom
Multiple R-squared:  0.7835,	Adjusted R-squared:  0.7603 
F-statistic: 33.78 on 3 and 28 DF,  p-value: 1.92e-09
~~~


# Conclusion
## Model 2 ให้ค่า R-squared ที่สูงกว่า model 1 
> จากค่า Multiple R-squared ของ Model 1 อยู่ที่ 0.775 ในขณะที่ของ Model 2 อยู่ที่  0.7835 แสดงว่า model 2 ดีกว่า model 1 (แต่ก็ไม่ได้ดีกว่ามาก เพราะค่าต่างกันค่อนข้างน้อย หรืออาจจะสรุปไม่ได้ว่า model 2 ดีกว่า model 1 เพราะไม่ได้ต่างอย่างมีนัยสำคัญ) และหากเทียบค่า Adjusted R-squared และ F-statistic ก็จะพบว่า model 2 สูงกว่า model 1 เล็กน้อย 
