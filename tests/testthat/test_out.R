context("Checking the output is correct")
library(caseXwhen)
test_that("it gives the right answers for vectors",
          {
            expect_equal(casexwhen(c("a", "c"), c("a", "b", "c", "d"), c(1,2,3,4)),
                         c(1,3))
            
          })

test_that("Missing input",
          {
            expect_equal(casexwhen(input=c(1,5), map_in=c(1,2,3,4), map_out=c("a","b", "c", "d")),
                         c("a", NA))
            
          })

test_that("Missing input last else",
          {
            expect_equal(casexwhen(input=c(1,5), map_in=c(1,2,3,4), map_out=c("a","b", "c", "d"), lastelse="z"),
                         c("a", "z"))
            
          })

test_that("DF input",
          {
            df=data.frame("in"=c(1,2,3,4), "out"=c("a","b", "c", "d"))
            expect_equal(casexwhen(input=c(1,3),map_df=df, lastelse="z"),
                         c("a", "c"))
            
          })

test_that("DF input overide",
          {
            df=data.frame("in"=c(1,2,3,4), "out"=c("a","b", "c", "d"))
            expect_equal(casexwhen(input=c(1,3),map_in=c(1,2,3,4), map_out=c("a", "c","b", "d"), map_df=df, lastelse="z"),
                         c("a", "c"))
            
          })