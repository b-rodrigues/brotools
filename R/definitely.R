#' Keeps trying a functiont until it succeeds
#' @param func A function you want to succed.
#' @param n_tries The number of tries before failing. 10 by default.
#' @param sleep Number of seconds between each try. 1 second by default.
#' @param ... Further arguments passed to func
#' @return Returns the result of func, or NULL if unsuccessful.
#' @export
#' @examples
#' \dontrun{
#' Read for full example http://www.brodrigues.co/blog/2018-03-12-keep_trying/
#' get_data = function(){
#'   number = rbinom(1, 1, 0.9)
#'   ifelse(number == 0, "OK", stop("Error: too many calls!"))
#'   }
#'   definitely(get_data, 10, 1)
#' }
definitely = function(func, n_tries = 10, sleep = 1, ...){

  possibly_func = purrr::possibly(func, otherwise = NULL)

  result = NULL
  try_number = 1

  while (is.null(result) && try_number <= n_tries) {
    print(paste("Try number: ", try_number))
    try_number = try_number + 1
    result = possibly_func(...)
    Sys.sleep(sleep)
  }

  return(result)
}