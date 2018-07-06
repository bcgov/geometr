context("geomet functions will fails when no API parameters are supplied")

test_that("Test that geomet functions fails without any API parameters",{
  expect_error(geomet_daily_mean(as_spatial = TRUE), "At least one argument needs to be non NULL")
  expect_error(geomet_annual_instant_peaks(as_spatial = TRUE), "At least one argument needs to be non NULL")
  expect_error(geomet_annual_stats(as_spatial = TRUE), "At least one argument needs to be non NULL")
  expect_error(geomet_stations(as_spatial = TRUE), "At least one argument needs to be non NULL")
  expect_error(geomet_monthly_mean(as_spatial = TRUE), "At least one argument needs to be non NULL")
})
