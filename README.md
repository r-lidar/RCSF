R package that wraps the [CSF algorithm](https://github.com/jianboqi/CSF) for Airborne LiDAR ground filtering based on Cloth Simulation.
It is made to work along with the [lidR](https://github.com/Jean-Romain/lidR) package.

## Example using lidR

```r
library(lidR)

file <- system.file("extdata", "Topography.laz", package="lidR")
las  <- readLAS(file, select = "xyz")
las  <- lasground(las, csf())

plot(las, color = "Classification")
```

## Reference

W. Zhang, J. Qi*, P. Wan, H. Wang, D. Xie, X. Wang, and G. Yan, “An Easy-to-Use Airborne LiDAR Data Filtering Method Based on Cloth Simulation,” Remote Sens., vol. 8, no. 6, p. 501, 2016
