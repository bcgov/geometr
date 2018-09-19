context("geomet_daily_mean returns the correctly specified data format")

test_that("spatial is properly respected",{
  expect_is(geomet_daily_mean("02JE022", as_spatial = FALSE), "tbl_df")
  expect_is(geomet_daily_mean("02JE022"), "sf")
})


context("geomet_daily_mean respect date arguments")

test_that("two dates supplies bound the query",{
  start_date <- "1983-07-11"
  end_date <- "1983-07-21"
  d <- geomet_daily_mean("10PC003", start_date = start_date, end_date = end_date)
  expect_identical(max(d$date), as.Date(end_date))
  expect_identical(min(d$date), as.Date(start_date))
})

test_that("one end date supplies bound the query",{
    end_date <- "1983-07-21"
  d <- geomet_daily_mean("10PC003", end_date = end_date)
  expect_identical(max(d$date), as.Date(end_date))
})


test_that("one start date supplies bound the query",{
  start_date <- "1983-07-21"
  d <- geomet_daily_mean("10PC003", start_date = start_date)
  expect_identical(min(d$date), as.Date(start_date))
})

test_that("function errors when start_date is after end_date",{
  expect_error(geomet_daily_mean("08MF005", start_date = "2017-01-02", end_date = "2017-01-01"))
})


test_that("no dates supplied returns all data",{
  d <- geomet_daily_mean("10PC003")
  expect_identical(max(d$date), as.Date("1986-12-31"))
  expect_identical(min(d$date), as.Date("1983-07-01"))
  min(d$date)
})

test_that("multiple stations can be queried",{
  d <- geomet_daily_mean(c("10PC003","02JE022"))
  expect_identical(sort(unique(d$station_number)), sort(c("10PC003","02JE022")))
})

test_that("multiple stations can be queried with dates",{
  d <- geomet_daily_mean(c("10PC003","02JE022"), start_date = "1950-01-01")
  expect_identical(sort(unique(d$station_number)), sort(c("10PC003","02JE022")))
  expect_true(min(d$date) >= as.Date("1950-01-01"))
})

