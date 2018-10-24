context("CSF")

data(rcsf_cloud)
id_ground = CSF(rcsf_cloud)

test_that("csf algorithm works", {
  expected = if (R.Version()$arch == "x86_64") 15459L else 15453L
  expect_equal(length(id_ground), expected)
})
