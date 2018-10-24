context("CSF")

data(rcsf_cloud)
id_ground = CSF(rcsf_cloud)

test_that("csf algorithm works", {
  expect_equal(length(id_ground), 15459)
})
