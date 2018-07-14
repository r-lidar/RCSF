#' Airborne LiDAR filtering method based on Cloth Simulation
#'
#' Airborne LiDAR filtering method based on Cloth Simulation (Zhang et al. 2016, see references). This
#' function is an R wrapper around the library written by the orignal authors of the algorithm.
#'
#' @param cloud data.frame with 3 columns named X Y, Z containing the coordinates of the point cloud.
#' @param sloop_smooth logical.
#' @param class_threshold scalar.
#' @param cloth_resolution scalar.
#' @param rigidness integer.
#' @param interations integer.
#' @param time_step scalar.
#'
#' @return A vector containing the ids of the points that belong on the ground.
#'
#' @references W. Zhang, J. Qi*, P. Wan, H. Wang, D. Xie, X. Wang, and G. Yan, “An Easy-to-Use Airborne
#' LiDAR Data Filtering Method Based on Cloth Simulation,” Remote Sens., vol. 8, no. 6, p. 501, 2016
#' @examples
#' data(rcsf_cloud)
#' head(rcsf_cloud)
#'
#' id_ground = CSF(rcsf_cloud)
#' @export
#' @useDynLib RCSF
#' @importFrom Rcpp sourceCpp
CSF <- function(cloud, sloop_smooth = FALSE, class_threshold = 0.5, cloth_resolution = 0.5, rigidness = 1L, interations = 500L, time_step = 0.65)
{
  stopifnot(is.data.frame(cloud))
  stopifnot(all(c("X", "Y", "Z") %in% names(cloud)))
  R_CSF(cloud, sloop_smooth, class_threshold, cloth_resolution, rigidness, interations, time_step)
}
