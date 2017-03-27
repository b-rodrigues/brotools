### Introduction

`brotools` is a package that includes some useful functions that makes my life easier. Maybe it'll make
yours too. Install it with:

### Installation

```
devtools::install_bitbucket("b-rodrigues/brotools")
```

### Functions included

Here is the list of the included functions:

* `all_data_to_upper()`
* `around()`
* `map_filter()`
* `modal_value()`
* `multi_join()`
* `ni()`
* `one_row()`
* `read_excel_clean()`
* `read_list()`
* `read_workbook()`
* `to_map()`

### Change the letter case of the column names of a list of datasets to uppercase with `all_data_to_upper()`

This function changes the letter case of the column names of the datasets stored in a list to 
upper case. This is useful for merging datasets with the same column names, but with different 
letter cases.

### Is a value *close* to another? Find out with `around()`

This function is useful if you want to test the equality of two values when these values are different
by a very little `epsilon`.

If x > y - eps and x < y + eps, `around()` returns `TRUE`, if not, `FALSE`.


### Filter a dataframe with various conditions with `map_filter()`

`map_filter()` returns a list of data frame objects where each data frame was filtered by one condition.

### Get the mode a list of number or characters thanks to `modal_value()`

This is basically a wrapper around `quantile(x, 0.5)`. Might get removed in future versions.

### Join a list of datasets into one single dataset using `multi_join()`

`multi_join()` solves the problem of merging a lot of datasets together. It takes a list of datasets
as an input, and outputs a `tibble` (an enhanced version of base R's `data.frames`).

### Check if a value is not in a list with `ni()`

Returns `TRUE` if x is not in a list.

### Only keep one row per individual with `one_row()`

This function is useful to remove duplicate lines in a dataframe. The user can specify the variables that will be 
used to check for duplicates in the data frames.

### One helper function `read_excel_clean()` sude by `read_workbook()`

`read_excel_clean()` is a wrapper around `janitor::clean_names(readxl::read_excel())` and is used 
by `read_workbook()`.

### Read a lot of datasets at once easily with `read_list()`

`read_list()` works by giving it a list of datasets in your current working directory and a read
function, such as `readr::read_csv()` in case you want to read `.csv` files and puts them in a 
list. You can then use the above functions on this list of datasets.

### Read an Excel workbook with `read_workbook()`

`read_workbook()` reads an `.xlsx` file into R. It is a wrapper around various pre-existing
functions. The only argument of `read_workbook()` is a path to an `.xlsx` file. The output is a
list where each element is a `data.frame` object representing each one of the sheets in the `.xlsx`
file. So for instance, a `.xlsx` file with four sheets, named `sheet1`, `sheet2`, `sheet3` and
`sheet4`, gets imported into R in a named list where the first element is a `data.frame` named also
`sheet1` and containing the data from `sheet1`, the second element, ... etc. If one loads the data
into a variable called `workbook`, here is what it looks like:

![](/vignettes/loaded_workbook.jpg)

### Make a function work on a list using `to_map()`

After having read a lot of datasets into a list, `to_map()` allows you to make any function work on 
this list of datasets. So for example, there is no need to use an anonymous function in `map()` to get the
summary statistics of each dataframe of the list.
