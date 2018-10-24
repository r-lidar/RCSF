R package that wraps the [CSF algorithm](https://github.com/jianboqi/CSF) for Airborne LiDAR ground filtering based on Cloth Simulation.
It is made to work along with the [lidR](https://github.com/Jean-Romain/lidR) package.

## Example using `lidR <= 1.6.1`

The lidR package in versions <= 1.6.1 does not implements the CSF algorithm yet. Users must write their
own code:


```r
library(lidR)
library(RCSF)

LASfile <- system.file("extdata", "Topography.laz", package="lidR")
las <- readLAS(LASfile, select = "xyz")
plot(las)

gnd <- CSF(las@data)

las@data[, Classification := 0L]
las@data[gnd, Classification := 2L]

plot(las, color = "Classification")
```

## Example using `lidR >= 2.0.0`

The lidR package in versions >= 2.0.0 implements the CSF algorithm as one of the available ground segmentation algorithms.

```r
library(lidR)

LASfile <- system.file("extdata", "Topography.laz", package="lidR")
las = readLAS(LASfile, select = "xyz")

las <- lasground(las, csf())

plot(las, color = "Classification")
```

## Reference

W. Zhang, J. Qi*, P. Wan, H. Wang, D. Xie, X. Wang, and G. Yan, “An Easy-to-Use Airborne LiDAR Data Filtering Method Based on Cloth Simulation,” Remote Sens., vol. 8, no. 6, p. 501, 2016
