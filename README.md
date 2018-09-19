R package that wrap the [CSF algorithm](https://github.com/jianboqi/CSF) for Airborne LiDAR ground filtering based on Cloth Simulation.

## Install package

```r
devtools::install_github("Jean-Romain/RCSF")
```

To install the package from github make sure you have a working development environment.

* **Windows**: Install [Rtools.exe](https://cran.r-project.org/bin/windows/Rtools/).  
* **Mac**: Install `Xcode` from the Mac App Store.
* **Linux**: Install the R development package, usually called `r-devel` or `r-base-dev`

## Use the CSF algorithm with `lidR`

The `lidR` package supporst the `CFS` algorithm since version 2.0.0

```r
library(lidR)

LASfile <- system.file("extdata", "Topography.laz", package="lidR")
las = readLAS(LASfile, select = "xyz")

lasground(las, csf())

plot(las, color = "Classification")
```

## Reference

W. Zhang, J. Qi*, P. Wan, H. Wang, D. Xie, X. Wang, and G. Yan, “An Easy-to-Use Airborne LiDAR Data Filtering Method Based on Cloth Simulation,” Remote Sens., vol. 8, no. 6, p. 501, 2016
