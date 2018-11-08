#' ggplot2 theme that works well with my blog
#' @export
theme_blog <- function(){
  theme_minimal() +
    theme(legend.position = "bottom",
        legend.text = element_text(colour = "white"),
        legend.title = element_text(colour = "white"),
        plot.background = element_rect("#272b30"),
        plot.title = element_text(colour = "white"),
        panel.grid = element_line(colour = "#425d65"),
        axis.text = element_text(colour = "white"),
        axis.title = element_text(colour = "white"),
        strip.text = element_text(colour = "white"))
}

#' fill scale that works well with blog
#' @export
scale_fill_blog <- function(){
  scale_fill_manual(values = c("#82518c", "#0f4150", "#5160a0",
                 "#88720e", "#bec3b8", "#8c6451",
                 "#5b8c51", "#880e61", "#0e2488",
                 "#880e20", "#d33682", "#0e8876", "#859900"))
}

#' color scale that works well with blog
#' @export
scale_color_blog <- function(){
  scale_color_manual(values = c("#82518c", "#0f4150", "#5160a0", #old nice, color too #002b36, but a bit dark
                 "#88720e", "#bec3b8", "#8c6451",
                 "#5b8c51", "#880e61", "#0e2488",
                 "#880e20", "#d33682", "#0e8876", "#859900"))
}

#' continuous scale that works well with blog
#' @export
scale_color_cont_blog <- function(){
	scale_color_gradient(low = "#bec3b8", high = "#ad2c6c")
}