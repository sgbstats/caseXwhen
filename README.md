# caseXwhen

So in SQL, when creating a new variable that has logic in it you can do case when
```SQL
select *,
case when var1="a" then "a1"
    when var1="b "then "b1"
    when var1="c" then "c1"
    else missing end as var2
from dummy;
```

each of the when statements can have more complex logic like in the r case when statement but in this case where there is something that is incredibly repetetive and is only based on equality you can do

```SQL
select *,
case var1 when "a" then "a1"
          when "b" then "b1"
          when "c" then "c1"
          else missing end as var2
from dummy;
```

now in r we can do the same with case when
```r
dummy %>% mutate(var2=case_when(var1=="a"~"a1"
                                var1=="b"~"b1",
                                var1=="c"~"c1"))
```
but you I haven’t see the solution where you can specify the input and then the mapping to do it quicker.

This leads to the function casexwhen where you specify of a vector input and mapping for speedier coding.

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