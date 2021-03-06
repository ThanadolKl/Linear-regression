# Linear-regression 
## Authors : Thanadol Klainin 6S No.8 |  Chalisa Pornsukjantra 6C No.6 
### ESC 782 DSS
---
## Contents
* Install package and data visualize
* Filter independence variables
* Model I and assumption evaluated 
* Model II and assumption evaluated
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

<img src="https://user-images.githubusercontent.com/67301601/131223486-f49bb62c-733b-418f-afe4-273dcb55377f.png" width="743">

> จะเห็นว่า จากตารางแสดง cor(mtcars) ซึ่งค่อนข้างดูยาก เมื่อนำมา Visualize จะทำให้สังเกตเห็นความสัมพันธ์ที่ง่ายมากขึ้น
---
## Filter independence variables
~~~
> car_dat
                     mpg cyl  disp  hp drat    wt  qsec vs am gear carb
Mazda RX4           21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4
Mazda RX4 Wag       21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4
Datsun 710          22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1
Hornet 4 Drive      21.4   6 258.0 110 3.08 3.215 19.44  1  0    3    1
Hornet Sportabout   18.7   8 360.0 175 3.15 3.440 17.02  0  0    3    2
Valiant             18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1
Duster 360          14.3   8 360.0 245 3.21 3.570 15.84  0  0    3    4
Merc 240D           24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2
Merc 230            22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2
Merc 280            19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4
Merc 280C           17.8   6 167.6 123 3.92 3.440 18.90  1  0    4    4
Merc 450SE          16.4   8 275.8 180 3.07 4.070 17.40  0  0    3    3
Merc 450SL          17.3   8 275.8 180 3.07 3.730 17.60  0  0    3    3
Merc 450SLC         15.2   8 275.8 180 3.07 3.780 18.00  0  0    3    3
Cadillac Fleetwood  10.4   8 472.0 205 2.93 5.250 17.98  0  0    3    4
Lincoln Continental 10.4   8 460.0 215 3.00 5.424 17.82  0  0    3    4
Chrysler Imperial   14.7   8 440.0 230 3.23 5.345 17.42  0  0    3    4
Fiat 128            32.4   4  78.7  66 4.08 2.200 19.47  1  1    4    1
Honda Civic         30.4   4  75.7  52 4.93 1.615 18.52  1  1    4    2
Toyota Corolla      33.9   4  71.1  65 4.22 1.835 19.90  1  1    4    1
Toyota Corona       21.5   4 120.1  97 3.70 2.465 20.01  1  0    3    1
Dodge Challenger    15.5   8 318.0 150 2.76 3.520 16.87  0  0    3    2
AMC Javelin         15.2   8 304.0 150 3.15 3.435 17.30  0  0    3    2
Camaro Z28          13.3   8 350.0 245 3.73 3.840 15.41  0  0    3    4
Pontiac Firebird    19.2   8 400.0 175 3.08 3.845 17.05  0  0    3    2
Fiat X1-9           27.3   4  79.0  66 4.08 1.935 18.90  1  1    4    1
Porsche 914-2       26.0   4 120.3  91 4.43 2.140 16.70  0  1    5    2
Lotus Europa        30.4   4  95.1 113 3.77 1.513 16.90  1  1    5    2
Ford Pantera L      15.8   8 351.0 264 4.22 3.170 14.50  0  1    5    4
Ferrari Dino        19.7   6 145.0 175 3.62 2.770 15.50  0  1    5    6
Maserati Bora       15.0   8 301.0 335 3.54 3.570 14.60  0  1    5    8
Volvo 142E          21.4   4 121.0 109 4.11 2.780 18.60  1  1    4    2
 ~~~
 > จากข้อมูล mtcars จะเห็นว่ามีตัวแปรค่อนข้างเยอะ และเมื่อทำการกรองคร่าว ๆ จะได้ว่า ข้อมูล  mpg, disp, hp, drat, wt, qsec จะเป็นข้อมูลที่ดูเหมือน continuous ในขณะที่ข้อมูล cyl, gear, carb จะแสดงเป็นจำนวนเต็มที่มีค่าซ้ำ ๆ กัน ทำให้ถ้านำมาทำ regression จะได้ว่า เมื่อแทนค่า x ที่เป็นค่าเดียวกัน จะได้ค่า y_pred ออกมาเหมือนกัน ทัง ๆ ที่ค่าข้อมูลจริงที่มีค่า x เท่ากัน ก็ให้ค่า y_true ที่ต่างกันหลายตัว ในขณะที่ข้อมูล vs และ am ดูเหมือนเป็นการแบ่ง class มากกว่า และยังแสดงค่าเป็น 0, 1 อีกด้วย เราจึงเลือกใช้ข้อมูล disp, hp, drat, wt, qsec ใน 2 models โดยใน model I ใช้ disp, hp, qsec ในขณะที่ model 2 เปลี่ยนมาใช้  disp, drat, wt ซึ่งอาจจะดูเหมือนมี strong correlation แต่ก็จำเป็นต้องใช้
---
## Model I and assumption evaluated
> Model 1 เราเลือกใช้ Regressors 3 ตัว คือ 1. disp, 2. hp, 3. qsec  ซึ่งจากรูป cor ข้างบนจะเห็นว่ามีบางตัวแปรค่อนข้างมี strong correlation แต่เราจะนำไปตรวจสอบ Multicollinearity ทีหลัง 
~~~
model1 <- lm(mpg~disp+hp+qsec, data = car_dat)
summary(model1)
~~~
## Check assumptions 
### 1. linearity 
![model1_disp](https://user-images.githubusercontent.com/67301601/131223659-cf25acc4-b4eb-4da8-84da-1eda6dd52e03.png)
![model1_hp](https://user-images.githubusercontent.com/67301601/131223677-64a4423b-2fd6-4c25-a571-b2b548413636.png)
![model1qsec](https://user-images.githubusercontent.com/67301601/131242543-32d04307-f32d-448e-bcaa-85de39713fa2.png)

> จะเห็นว่าความสัมพันธ์ระหว่าง x1, x2 กับ Y (mpg) ค่อนข้างเป็น linear ในขณะที่ x3 (qsec) มีความสัมพันธ์ที่เห็นได้ไม่ใช่ แต่ก็ไม่ใช้ curve ดังนั้น assumption ข้อนี้เลยผ่าน
### 2. Independence 
> mtcars dataset ไม่ใช่ serial data ดังนั้นข้อมูลแต่ละตัวจะเป็นอิสระต่อกันอยู่แล้ว
### 3. Normality
~~~
library(ggfortify)
autoplot(model1)
~~~
![nor1](https://user-images.githubusercontent.com/67301601/131238863-d8a2b057-bafa-4ae7-9b5a-bd9c0b3e5951.png)
> จะเห็นว่า กราฟที่ 1(บนซ้าย) Residuals vs fitted จะกระจายตัวกันแบบไม่มี Pattern คิดว่าน่าจะเป็น well-behaved plot และ กราฟที่ 2 (บนขวา) Normal Q-Q ข้อมูลกระจายตัวค่อน Normal ยังไม่ถือว่าเป็น Skewed residuals, Heavy-tailed residuals
### 4. Equal variance
> Check การกระจายตัวของ Standradize Residual เทียบ Independece variable ทีละตัว จะได้กราฟ 3 กราฟ 

![eq1_1](https://user-images.githubusercontent.com/67301601/131242333-d7964285-00e4-47c7-9357-2beedbfe322c.png)

> จากกราฟนี้จะเห็นว่าการกระจายตัวของ Standardize residuals มีการกระจายตัวทั้งด้านบวกและลบ ไม่มี Pattern ที่จะกลายเป็น heteroscedasticity

![eq1_2](https://user-images.githubusercontent.com/67301601/131242334-de17fea1-4b6e-4b95-83b4-affb667d8d2a.png)

> คล้ายกับรูปด้านบน แต่มี residual ตัวแรกที่เหมือนจะเป็น outlier

![eq1_3](https://user-images.githubusercontent.com/67301601/131242337-f9e898fc-680a-43bf-b1c2-03dcbb667683.png)

> Standardize residuals มีการกระจายตัวทั้งด้านบวกและลบ จุดไม่มีลักษณะอยู่ด้านบวก หรือลบตลอด หรือเป็น 0 ตลอด หรือกว้างออกตลอด เมื่อค่า X สูงขึ้นหรือต่ำลง

### 5. Multicollinearity (check by VIF)
> จากการดูความสัมพันธ์ของข้อมูลพบว่ามี x บางตัวที่มี Strong correlation แต่จากการกรองตัวแปรที่พอจะใช้ได้ ก็จำเป็นต้องใช้ตัวแปรที่มี strong correlation อันนี้ แล้วค่อยนำไปตรวจสอบค่า VIF ทีหลัง

> ซึ่งค่า VIF คือ ค่าที่จะสะท้อนให้เห็นถึงอิทธิพลร่วมของตัวแปรทำนาย (predictor) ในตัวแบบเส้นตรง ซึ่งค่าไม่ควรเกิน 10 หากเกินแสดงว่า model อาจเกิด Multicollinearity
~~~
library(car)
vif(model1)
~~~
> Output 
~~~
> vif(model1)
    disp       hp     qsec 
2.921334 4.758739 2.194433 
~~~
> จะเห็นว่าค่า VIF <10 ดังนั้น model นี้ ยังไม่เกิด Multicollinearity
### Summary model I 
~~~
> summary(model1)

Call:
lm(formula = mpg ~ disp + hp + qsec, data = car_dat)

Residuals:
    Min      1Q  Median      3Q     Max 
-4.5029 -2.6417 -0.6002  1.9749  7.2263 

Coefficients:
             Estimate Std. Error t value Pr(>|t|)    
(Intercept) 38.622206   9.668300   3.995 0.000426 ***
disp        -0.028468   0.007787  -3.656 0.001049 ** 
hp          -0.034642   0.017967  -1.928 0.064041 .  
qsec        -0.385561   0.468127  -0.824 0.417114    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 3.144 on 28 degrees of freedom
Multiple R-squared:  0.7542,	Adjusted R-squared:  0.7279 
F-statistic: 28.64 on 3 and 28 DF,  p-value: 1.118e-08
~~~
### Prediction from model I
~~~
> head(pred1)
        Mazda RX4     Mazda RX4 Wag        Datsun 710    Hornet 4 Drive Hornet Sportabout           Valiant 
         23.91033          23.69442          25.15065          19.97145          15.74901          20.78338 
~~~
---
## Model II
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
> จะเห็นว่าความสัมพันธ์ระหว่าง x1, x2, x3 กับ Y (mpg) ค่อนข้างเป็น linear ดังนั้น assumption ข้อนี้เลยผ่าน
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
> Check การกระจายตัวของ Standradize Residual เทียบ Independece variable ทีละตัว จะได้กราฟ 3 กราฟ 

![eq2_1](https://user-images.githubusercontent.com/67301601/131242602-a1032aa7-ee21-4f54-a217-7ef1b109f9e3.png)

> residual มีการกระจายตัวทั้งด้านบวกและลบ ถือว่าไม่เป็น heteroscedasticity

![eq2_2](https://user-images.githubusercontent.com/67301601/131242604-6e2d8371-ced9-456e-b8c5-2996afc70953.png)

> residual มีการกระจายตัวทั้งด้านบวกและลบ ไม่มี pattern ลู่เข้าหากันหรือลู่ออก

![eq2_3](https://user-images.githubusercontent.com/67301601/131242605-7703cea6-8652-4546-8631-d7235ec81fbd.png)

> residual มีการกระจายตัวทั้งด้านบวกและลบ ไม่มี pattern ลู่เข้าหากันหรือลู่ออก

### 5. Multicollinearity (check by VIF)
> จากการดูความสัมพันธ์ของข้อมูลพบว่ามี x บางตัวที่มี Strong correlation แต่จากการกรองตัวแปรที่พอจะใช้ได้ ก็จำเป็นต้องใช้ตัวแปรที่มี strong correlation อันนี้ แล้วค่อยนำไปตรวจสอบค่า VIF ทีหลัง
~~~
library(car)
vif(model1)
~~~
> Output 
~~~
    disp     drat       wt 
5.018343 2.155314 5.050627 
~~~
> จะเห็นว่าค่า VIF <10 ดังนั้น model นี้ ยังไม่เกิด Multicollinearity แต่ก็มีแนวโน้มที่จะเกิด
### Summary model II
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
### Prediction from model II 
~~~
> head(pred2)
        Mazda RX4     Mazda RX4 Wag        Datsun 710    Hornet 4 Drive Hornet Sportabout           Valiant 
         23.40055          22.59157          25.16234          19.21474          16.88831          18.70825 
~~~
# Conclusion
## model 2 ให้ค่า R-squared ที่สูงกว่า model 1 
> จากค่า Multiple R-squared ของ Model 1 อยู่ที่ 0.7542 ในขณะที่ของ Model 2 อยู่ที่  0.7835 แสดงว่า model 2 ดีกว่า model 1 (แต่ก็ไม่ได้ดีกว่ากันมาก เพราะค่าต่างกันค่อนข้างน้อย) และหากเทียบค่า Adjusted R-squared และ F-statistic ก็จะพบว่า model 2 สูงกว่า model 1  จึงสรุปได้ว่าหากต้องเลือกใช้ model ตัวไหน ก็คงเลือก model II เพราะให้ค่า R^2 ที่สูงกว่า และดีกว่า model I ซึ่งคาดการณ์ได้ว่าเป็นเพราะข้อมูล qsec ใน model I มี correlation ที่ค่อนข้าง weak กับ mpg ทำให้ค่า R^2 ที่ได้ ต่ำกว่า model II
