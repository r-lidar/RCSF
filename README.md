This is an R package that wrap the [CSF algorithm](https://github.com/jianboqi/CSF) for Airborne LiDAR ground filtering based on Cloth Simulation (see references)

**The package is currently in developpment and does not work yet**

## Test example

```r
library(lidR)
library(RCSF)

LASfile <- system.file("extdata", "Topography.laz", package="lidR")
las = readLAS(LASfile, select = "xyz")

gnd = CSF(las@data)
```

## Reference

W. Zhang, J. Qi*, P. Wan, H. Wang, D. Xie, X. Wang, and G. Yan, “An Easy-to-Use Airborne LiDAR Data Filtering Method Based on Cloth Simulation,” Remote Sens., vol. 8, no. 6, p. 501, 2016