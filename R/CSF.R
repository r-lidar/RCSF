#' Airborne LiDAR filtering method based on Cloth Simulation
#'
#' Airborne LiDAR filtering method of ground points based on Cloth Simulation (Zhang et al. 2016,
#' see references). This function is an R wrapper around the library written by the orignal authors
#' of the algorithm. The ALS point cloud is inverted, and then a rigid cloth is used to cover the
#' inverted surface. By analyzing the interactions between the cloth nodes and the corresponding
#' LiDAR points, the locations of the cloth nodes can be determined to generate an approximation of
#' the ground surface.
#'
#' @param cloud data.frame with 3 columns named X Y, Z containing the coordinates of the point cloud.
#' @param sloop_smooth logical. When sharp slopes exist, set this parameter to TRUE to perform a
#' post-processing which will reduced errors.
#' @param class_threshold scalar. The distance to the simulated cloth to classify point cloud into ground
#' and non-ground. The default is 0.5.
#' @param cloth_resolution scalar. The distance between paticles in cloth. This is usually set to the
#' average distance of the points in the point cloud. The default value is 0.5.
#' @param rigidness integer. The rididness of the cloth. 1 stands for very soft cloth (to fit rugged
#' terrain), 2 stands for medium cloth and 3 stands for hard cloth (for flat terrain). The default is 1.
#' @param iterations integer. Maximum iteration for simulating cloth. The default value is 500. Usually,
#' users do not need to change this.
#' @param time_step scalar. Time step when simulating the cloth under the gravity. The default value
#' is 0.65. Usually, Do not change this value. It is suitable for most cases.
#'
#' @return An integer vector containing the ids of the points that belong on the ground.
#'
#' @references W. Zhang, J. Qi*, P. Wan, H. Wang, D. Xie, X. Wang, and G. Yan, “An Easy-to-Use Airborne
#' LiDAR Data Filtering Method Based on Cloth Simulation”, Remote Sens., vol. 8, no. 6, p. 501, 2016
#' @examples
#' data(rcsf_cloud)
#' head(rcsf_cloud)
#'
#' id_ground = CSF(rcsf_cloud)
#' @export
#' @useDynLib RCSF
#' @importFrom Rcpp sourceCpp
CSF <- function(cloud, sloop_smooth = FALSE, class_threshold = 0.5, cloth_resolution = 0.5, rigidness = 1L, iterations = 500L, time_step = 0.65)
{
    if(!is.logical(sloop_smooth))
      stop("'sloop_smooth' must be a boolean.")

    if(!is.numeric(class_threshold) | class_threshold <= 0)
      stop("'class_threshold' must be a number larger than 0")

    if(!is.numeric(cloth_resolution) | cloth_resolution <= 0)
      stop("'cloth_resolution' must be a number larger than 0")

    if(!is.numeric(rigidness) | rigidness <= 0)
      stop("'rigidness' must be a integer larger than 0")

    if(!is.numeric(iterations) | iterations <= 0)
      stop("'iterations' must be a integer larger than 0")

    if(!is.numeric(time_step) | time_step <= 0)
      stop("'time_step' must be a number larger than 0")

    stopifnot(is.data.frame(cloud))
    stopifnot(all(c("X", "Y", "Z") %in% names(cloud)))
    R_CSF(cloud, sloop_smooth, class_threshold, cloth_resolution, rigidness, iterations, time_step)
}
