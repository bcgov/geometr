context("geomet_daily_mean returns the correctly specified data format")

test_that("spatial is properly respected",{
  expect_is(geomet_daily_mean("02JE022", as_spatial = FALSE), "tbl_df")
  expect_is(geomet_daily_mean("02JE022"), "sf")
})


