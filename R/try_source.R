#' Tries sourcing a file. Returns TRUE if sourcing did not error, FALSE if not.
#' @param file An R script to source.
#' @return TRUE or FALSE
#' @export
#' @importFrom assertthat validate_that
#' @examples
#' \dontrun{
#' try_source("my_script.R")
#' }
try_source <- function(file, show_warnings = TRUE){
  if (show_warnings){
    fn <- try(source(file))
  } else {
    suppressWarnings(
      fn <- try(source(file))
    )
  }
  validate_that(!(inherits(fn, "try-error")),
                msg = paste0("Error in script:", file))
}