#' Custom ggplot2 theme: Pencil Case
#'
#' A clean, minimalist theme with white background, subtle grid lines,
#' no axis ticks, and a bordered legend at the bottom.
#'
#' @return A ggplot2 theme object
#' @export
#'
#' @importFrom ggplot2 theme element_rect element_blank element_line
#'
#' @examples
#' library(ggplot2)
#' ggplot(mtcars, aes(x = wt, y = mpg)) +
#'   geom_point() +
#'   theme_pencilcase()
theme_pencilcase <- function() {
  theme(
    # Places the legend at the bottom of the plot instead of the default right side
    legend.position = "bottom",
    # Adds a black outline/border around the entire legend box
    legend.box.background = element_rect(colour = "black"),
    # Removes the background fill of the legend (makes it transparent)
    legend.background = element_blank(),
    # Removes the background behind each legend key/symbol
    legend.key = element_blank(),
    # Sets the main plot panel background to white with white border
    panel.background = element_rect(fill='white', colour='white'),
    # Sets major grid lines to a very light grey color (barely visible)
    panel.grid.major = element_line(colour = "grey95"),
    # Sets minor grid lines to the same very light grey color
    panel.grid.minor = element_line(colour = "grey95"),
    # Removes the tick marks on the y-axis
    axis.ticks.y = element_blank(),
    # Removes the tick marks on the x-axis
    axis.ticks.x = element_blank(),
    # For faceted plots, sets the background of the facet labels to white
    strip.background = element_rect(fill="white")
  )
}
