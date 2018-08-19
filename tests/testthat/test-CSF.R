context("CSF")

data(rcsf_cloud)
id_ground = CSF(rcsf_cloud)

test_that("multiplication works", {
  expect_equal(length(id_ground), 15457, tolerance = 1)
})
