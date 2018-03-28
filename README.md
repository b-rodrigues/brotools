### Introduction

`brotools` is a package that includes some useful functions that makes my life easier. Maybe it'll make
yours too. Install it with:

### Installation

```
devtools::install_github("b-rodrigues/brotools")
```

### Functions included

Here is the list of the included functions:

* `around()`
* `map_filter()`
* `ni()`
* `one_row()`
* `read_list()`
* `to_map()`

### Is a value *close* to another? Find out with `around()`

This function is useful if you want to test the equality of two values when these values are different
by a very little `epsilon`.

If x > y - eps and x < y + eps, `around()` returns `TRUE`, if not, `FALSE`.

### Filter a dataframe with various conditions with `map_filter()`

`map_filter()` returns a list of data frame objects where each data frame was filtered by one condition.

### Check if a value is not in a list with `ni()`

Returns `TRUE` if x is not in a list.

### Only keep one row per individual with `one_row()`

This function is useful to remove duplicate lines in a dataframe. The user can specify the variables that will be 
used to check for duplicates in the data frames.

### Read a lot of datasets at once easily with `read_list()`

`read_list()` works by giving it a list of datasets in your current working directory and a read
function, such as `readr::read_csv()` in case you want to read `.csv` files,and puts them in a 
list. You can then use the above functions on this list of datasets.

### Make a function work on a list using `to_map()`

After having read a lot of datasets into a list, `to_map()` allows you to make any function work on 
this list of datasets. So for example, there is no need to use an anonymous function in `map()` to get the
summary statistics of each dataframe of the list.
