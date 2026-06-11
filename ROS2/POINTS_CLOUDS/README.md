
### Resample Point Cloud in .e57 format 


Параметр --filters.sample.radius=0.25 задаёт минимальное расстояние в единицах вашей системы координат (обычно это метры) 
между любыми двумя точками в результирующем облаке.
То есть после фильтрации ни одна пара оставшихся точек не будет ближе друг к другу, чем 0.25 метра. 
Это не размер вокселя, а именно гарантированный «просвет» между соседними точками.


```
echo Start
#time pdal translate 2_floor.e57 2_floor_low.e57 sample --filters.sample.radius=0.025
#time pdal translate 2_floor_pers.e57 2_floor_pers_low.e57 sample --filters.sample.radius=0.025
time pdal translate mans.e57 mans_low.e57 sample --filters.sample.radius=0.025
```
