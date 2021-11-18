
<!-- README.md is generated from README.Rmd. Please edit that file -->

# maggieliu545ba2

<!-- badges: start -->

<!-- badges: end -->

This package provides a function `plot_hist_with_density` that plots a
histogram of a column from a specified dataset, and a smooth density
curve overlayed on the histogram. The function allows for customizable
parameters for visualization.

## Installation

You can install the released version of maggieliu545ba2 from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("maggieliu545ba2")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("stat545ubc-2021/maggieliu545ba2")
```

## Example

Below is an example of using the function `plot_hist_with_density`:

``` r
(maggieliu545ba2::plot_hist_with_density(
  data=iris,
  column=Sepal.Length,
  xlab="Sepal Length",
  title="Histogram and density plot of sepal length"))
```

<img src="man/figures/README-unnamed-chunk-2-1.png" width="100%" />
