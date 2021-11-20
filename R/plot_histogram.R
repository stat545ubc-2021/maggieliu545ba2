#' @title Plot histogram and smooth density curve
#'
#' @description
#' \code{plot_hist_with_density} uses dplyr to plot a histogram of a
#' specific numeric column for a given dataset. It also plots a smooth
#' density curve overlayed on the histogram. The function also allows
#' custom parameters to adjust the colours of the plot, bin size, and
#' alpha transparency.
#'
#' @import ggplot2
#' @import datateachr
#' @importFrom magrittr %>%
#' @importFrom dplyr across everything filter select summarise
#'
#' @param data Tibble. The dataset to use for plotting. It is called
#'   data because it is a dataset.
#' @param column Variable. The variable name for the column to plot.
#'   It must exist as a column in \code{data}. It is called column
#'   because it is the column to plot.
#' @param title String. The title of the plot. It is called title
#'   because it is the title of the plot.
#' @param xlab String. The x-axis label for the plot. It is called xlab
#'   because it is the x-axis label for the plot.
#' @param ylab String. The y-axis label for the plot. It is called ylab
#'   because it is the x-axis label for the plot.
#' @param bins Integer. The number of bins to use for the histogram to
#'   plot. It is called bins because it represents the number of bins.
#' @param alpha Float. A value in the range \code{[0,1]} that represents the
#'   alpha transparency of the smooth density curve to plot. It is
#'   called alpha because it represents the alpha transparency.
#' @param hist_colour String. A string containing either a hex code
#'   or a named colour that indicates the colour to use for the
#'   histogram outline. It is called hist_colour because it indicates
#'   the colour of the histogram outline.
#' @param hist_fill String. A string containing either a hex code or
#'   a named colour that indicates the colour to use for the histogram
#'   fill. It is called hist_fill because it indicates the colour of
#'   the histogram fill
#' @param density_fill String. A string containing either a hex code
#'   or a named colour that indicates the colour to use for the density
#'   curve fill. It is called density_fill because it indicates the
#'   colour of the density curve fill
#' @param narm Boolean. A Boolean value indicting whether or not NA
#'   values should be removed from the column to plot. It is called narm
#'   because it indicates whether to remove (rm) NA values.
#'
#' @return An image of the plot containing the histogram and density curve
#'
#' @examples
#'
#' # Using default parameters
#' (plot_hist_with_density(
#'   data=iris,
#'   column=Sepal.Length,
#'   xlab="Sepal Length",
#'   title="Histogram and density plot of sepal length"))
#'
#' # Overwriting default parameters
#' (plot_hist_with_density(
#'   data=iris,
#'   column=Sepal.Length,
#'   xlab="Sepal Length",
#'   title="Histogram and density plot of sepal length",
#'   bins = 40,
#'   alpha = 0.3,
#'   hist_colour = "grey",
#'   hist_fill = "grey",
#'   density_fill = "blue"))
#'
#' @export
plot_hist_with_density <- function(
  data,
  column,
  title,
  xlab,
  ylab="density",
  bins = 20,
  alpha = 0.5,
  hist_colour = "black",
  hist_fill = "white",
  density_fill = "grey",
  narm = TRUE
) {

  if (narm) {
    data <- data %>% filter(!is.na({{column}}))
  }

  non_numeric_count <- data %>%
    select({{column}}) %>%
    summarise(across(everything(), ~sum(!is.numeric(.x)))) %>%
    sum

  if (non_numeric_count > 0) {
    stop("Cannot plot a histogram of non-numeric values!\nThe column you provided contains non-numeric values.")
  }

  data %>% ggplot(aes(x = {{column}})) +
    geom_histogram(
      aes_string(y = "..density.."),
      bins = bins,
      colour = hist_colour,
      fill = hist_fill) +
    geom_density(fill = density_fill, alpha = alpha) +
    labs(
      xlab=xlab,
      ylab=ylab,
      title=title)
}
