context("Checking the output is correct")
library(caseXwhen)

test_that("it gives the right answers for vectors",
          {
            expect_equal(casexwhen(c("a", "c"), c("a", "b", "c", "d"), c(1,2,3,4)),
                         c(1,3))
            
          })