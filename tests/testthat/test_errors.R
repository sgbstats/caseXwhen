context("Checking the errors")
library(caseXwhen)

test_that("inputs not specified",
          {
            expect_error(casexwhen(c("a", "c")),
                         "Mapping not spcified")
            
          })

test_that("missing input 1",
          {
            expect_error(casexwhen(c("a", "c"), map_in=c("a", "b", "c", "d")),
                         "Mapping not spcified")
            
          })

test_that("missing input 2",
          {
            expect_error(casexwhen(c("a", "c"), map_out=c(1,2,3,4)),
                         "Mapping not spcified")
            
          })

test_that("wrong types",
          {
            expect_error(casexwhen(c("a", "c"), map_in=c(7,8,9,0),map_out=c(1,2,3,4)),
                         "Input is character and map_in is numeric. Types must match")
            
          })

test_that("wrong types",
          {
            expect_error(casexwhen(input=c(1,3), map_in=c(1,2,3,4,5), map_out=c("a","b", "c", "d")),
                         "Map_in and map_out are of differing lengths")
            
          })