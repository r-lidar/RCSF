#' Airborne LiDAR filtering method based on Cloth Simulation
#'
#' Airborne LiDAR filtering method based on Cloth Simulation
#'
#' @param cloud data.frame with 3 columns names X Y, Z containing the coordinates of the point cloud.
#' @param SloopSmooth logical
#' @param ClothResolution numeric.
#'
#' @return A vector containing the ids of the points that belong on the ground.
#'
#' @references W. Zhang, J. Qi*, P. Wan, H. Wang, D. Xie, X. Wang, and G. Yan, “An Easy-to-Use Airborne
#' LiDAR Data Filtering Method Based on Cloth Simulation,” Remote Sens., vol. 8, no. 6, p. 501, 2016
#'
#' @export
#' @useDynLib RCSF
#' @importFrom Rcpp sourceCpp
CSF <- function(cloud, SloopSmooth = FALSE, ClothResolution = 0.5)
{
  stopifnot(is.data.frame(cloud))
  stopifnot(all(c("X", "Y", "Z") %in% names(cloud)))
  R_CSF(cloud, SloopSmooth, ClothResolution)
}
