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
 > จากข้อมูล mtcars จะเห็นว่ามีตัวแปรค่อนข้างเยอะ และเมื่อทำการกรองคร่าว ๆ จะได้ว่า ข้อมูล  mpg, disp, hp, drat, wt, qsec จะเป็นข้อมูลที่ดูเหมือน continuous ในขณะที่ข้อมูล cyl, gear, carb จะแสดงเป็นจำนวนเต็มที่มีค่าซ้ำ ๆ กัน ทำให้ถ้านำมาทำ regression จะได้ว่า เมื่อแทนค่า x ที่เป็นค่าเดียวกัน จะได้ค่า y_pred ออกมาเหมือนกัน ทัง ๆ ที่ค่าข้อมูลจริงที่มีค่า x เท่ากัน ก็ให้ค่า y_true ที่ต่างกันหลายตัว ในขณะที่ข้อมูล vs และ am ดูเหมือนเป็นการแบ่ง class มากกว่า และยังแสดงค่าเป็น 0, 1 อีกด้วย เราจึงเลือกใช้ข้อมูล disp, hp, drat, wt ใน 2 models โดยใน model I ใช้ disp, hp, drat ในขณะที่ model 2 เปลี่ยนมาใช้  disp, drat, wt ซึ่งอาจจะดูเหมือนมี strong correlation แต่ก็จำเป็นต้องใช้
---
## Model I and assumption check
> Model 1 เราเลือกใช้ Regressors 3 ตัว คือ 1. disp, 2. hp, 3. drat  ซึ่งจากรูป cor ข้างบนจะเห็นว่ามีบางตัวแปรค่อนข้างมี strong correlation แต่เราจะนำไปตรวจสอบ Multicollinearity ทีหลัง 
~~~
model1 <- lm(mpg~disp+hp+drat, data = car_dat)
summary(model1)
~~~
## check Assumptions 
### 1. linearity 
![model1_disp](https://user-images.githubusercontent.com/67301601/131223659-cf25acc4-b4eb-4da8-84da-1eda6dd52e03.png)
![model1_hp](https://user-images.githubusercontent.com/67301601/131223677-64a4423b-2fd6-4c25-a571-b2b548413636.png)
![model1_drat](https://user-images.githubusercontent.com/67301601/131223688-067ad237-b6f7-4e61-b948-e1e79946f27b.png)
> จะเห็นว่าความสัมพันธ์ระหว่าง x1, x2, x3 กับ Y (mpg) ค่อนข้างเป็น linear ดังนั้น assumption ข้อนี้เลยผ่าน
### 2. Independence 
> mtcars dataset ไม่ใช่ serial data ดังนั้นข้อมูลแต่ละตัวจะเป็นอิสระต่อกันอยู่แล้ว
### 3. Normality
~~~
library(ggfortify)
autoplot(model1)
~~~
![model1_normality](https://user-images.githubusercontent.com/67301601/131223820-462dc4f2-cc23-4a56-a1fc-d8768868b5b7.png)
> จะเห็นว่า กราฟที่ 1(บนซ้าย) Residuals vs fitted จะกระจายตัวกันแบบไม่มี Pattern คิดว่าน่าจะเป็น well-behaved plot และ กราฟที่ 2 (บนขวา) Normal Q-Q ข้อมูลกระจายตัวค่อน Normal มี Outliers อยู่ด้านบน ๆ
### 4. Equal variance

### 5. Multicollinearity (check by VIF)
> จากการดูความสัมพันธ์ของข้อมูลพบว่ามี x บางตัวที่มี Strong correlation แต่จากการกรองตัวแปรที่พอจะใช้ได้ ก็จำเป็นต้องใช้ตัวแปรที่มี strong correlation อันนี้ แล้วค่อยนำไปตรวจสอบค่า VIF ทีหลัง

> ซึ่งค่า VIF คือ ค่าที่จะสะท้อนให้เห็นถึงอิทธิพลร่วมของตัวแปรทำนาย (predictor) ในตัวแบบเส้นตรง ซึ่งค่าไม่ควรเกิน 10 หากเกินแสดงว่า model อาจเกิด Multicollinearity
~~~
library(car)
vif(model1)
~~~
> Output 
~~~
    disp       hp     drat 
4.621988 2.868264 2.166843 
~~~
> จะเห็นว่าค่า VIF <10 ดังนั้น model นี้ ยังไม่เกิด Multicollinearity
### Summary model I 
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
### Prediction from model I
~~~
> head(pred1)
        Mazda RX4     Mazda RX4 Wag        Datsun 710    Hornet 4 Drive Hornet Sportabout           Valiant 
         23.42031          23.42031          24.81554          19.30928          15.50773          19.23130 
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
> จากค่า Multiple R-squared ของ Model 1 อยู่ที่ 0.775 ในขณะที่ของ Model 2 อยู่ที่  0.7835 แสดงว่า model 2 ดีกว่า model 1 (แต่ก็ไม่ได้ดีกว่ากันมาก เพราะค่าต่างกันค่อนข้างน้อย หรืออาจจะสรุปไม่ได้ว่า model 2 ดีกว่า model 1 เพราะไม่ได้ต่างกันอย่างมีนัยสำคัญ) และหากเทียบค่า Adjusted R-squared และ F-statistic ก็จะพบว่า model 2 สูงกว่า model 1 เล็กน้อย จึงสรุปได้ว่าหากต้องเลือกใช้ model ตัวไหน ก็คงเลือก model II เพราะให้ค่า R^2 ที่สูงกว่า  
