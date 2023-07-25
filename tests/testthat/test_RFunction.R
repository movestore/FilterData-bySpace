library('move2')

test_data <- test_data("input3_move2.rds") #file must be move2!

test_that("happy path", {
  actual <- rFunction(data = test_data, lon1=0,lon2=20,lat1=40,lat2=55)
  expect_equal(dim(actual)[1], 218)
})

test_that("no data in bbox", {
  actual <- rFunction(data = test_data, lon1=0,lon2=10,lat1=40,lat2=55)
  expect_null(actual)
})
