context("CSF")

data(rcsf_cloud)
id_ground = CSF(rcsf_cloud)

test_that("csf algorithm works", {
  expect_true(length(id_ground) %in% c(15459L, 15453L))
})
