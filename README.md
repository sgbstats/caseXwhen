# caseXwhen
```r

install.packages("devtools")
devtools::install.github("sgbstats/caseXwhen")

```

## Rationale

In SQL, when creating a new variable that has logic in it you can do case when
```SQL
select *,
case when var1="a" then "a1"
    when var1="b "then "b1"
    when var1="c" then "c1"
    else missing end as var2
from dummy;
```

Each of the when statements can have more complex logic like in the R `case_when` function but when there is something that is incredibly repetitive and is only based on equality you can do

```SQL
select *,
case var1 when "a" then "a1"
          when "b" then "b1"
          when "c" then "c1"
          else missing end as var2
from dummy;
```

now in R we can do the same with `case_when`
```r
dummy %>% mutate(var2=case_when(var1=="a"~"a1"
                                var1=="b"~"b1",
                                var1=="c"~"c1"))
```
but you I haven’t see the solution where you can specify the input and then the mapping to do it quicker.

This leads to the function casexwhen where you specify of a vector input and mapping for speedier coding.

## Syntax

- input: A vector or scalar for the input values
- map_in: A vector or scalar for the input for the mapping (Not used if map_df is specified)
- map_out: A vector or scalar for the output for the mapping (Not used if map_df is specified)
- lastelse: Optional. A value to output if there are no matches, if `NULL` then no matches will output `NA`.
- map_df: Optional. A dataframe with the map_in as column 1 and map_out as column 2. When specified, takes priority over the specified input and output.

## Examples

Base case, where all of the inputs have a corresponding output
```r
casexwhen(input=c(1,3), map_in=c(1,2,3,4), map_out=c("a","b", "c", "d"))

# returns c("a", "c")

```

If an input if missing from the map_in then it returns NA
```r
casexwhen(input=c(1,5), map_in=c(1,2,3,4), map_out=c("a","b", "c", "d"))

# returns c("a", NA)

```

Unless lastelse is specified then it returns that

```r
casexwhen(input=c(1,5), map_in=c(1,2,3,4), map_out=c("a","b", "c", "d"), lastelse="z")

# returns c("a", "z")

```

Rather than 2 vectors, you can specify a dataframe in map_df and it will take the first 2 columns from it. It will prioritise map_df over map_in and map_out

```r
df=data.frame("in"=c(1,2,3,4), "out"=c("a","b", "c", "d"))
casexwhen(input=c(1,3),map_df=df, lastelse="z")

# returns c("a", "c")

```

```r
df=data.frame("in"=c(1,2,3,4), "out"=c("a", "c","b", "d"))
casexwhen(input=c(1,3),map_in=c(1,2,3,4), map_out=c("a","b", "c", "d"), map_df=df, lastelse="z")

# returns c("a", "b")
```