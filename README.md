# Linear-regression 
# Authors : Thanadol Klainin 6S No.8 |  Chalisa Pornsukjantra 6C No.6 
# ESC 782 DSS
# library 

# Dataset
> เพื่อความง่ายในการดู correlation ของข้อมูล เราจึงทำการ Visualize cor(mtcars) ก่อน 
~~~ 
corrplot(cor_dat, method="color", col=col(200),  
         type="lower", order="original", 
         addCoef.col = "black", 
         tl.col="black", tl.srt=45) 
~~~
![cor_plot_number](https://user-images.githubusercontent.com/67301601/131223486-f49bb62c-733b-418f-afe4-273dcb55377f.png)

 
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
