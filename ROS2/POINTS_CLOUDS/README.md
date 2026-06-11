
### Resample Point Cloud in .e57 format 

```
echo Start
#time pdal translate 2_floor.e57 2_floor_low.e57 sample --filters.sample.radius=0.025
#time pdal translate 2_floor_pers.e57 2_floor_pers_low.e57 sample --filters.sample.radius=0.025
time pdal translate mans.e57 mans_low.e57 sample --filters.sample.radius=0.025
```
