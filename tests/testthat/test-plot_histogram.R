test1_plot <- plot_hist_with_density(
  data=cancer_sample,
  column=area_mean,
  xlab="area_mean",
  title="Test 1 Histogram")

test_that("plot_hist_with_density generates a plot with the correct features", {
  # Test that aesthetic mappings are correct
  expect_equal(
    as.character(rlang::get_expr(test1_plot$mapping$x)),
    "area_mean")

  # Test that labels are correct
  expect_equal(
    as.character(rlang::get_expr(test1_plot$labels$xlab)),
    "area_mean")
  expect_equal(
    as.character(rlang::get_expr(test1_plot$labels$ylab)),
    "density")
  expect_equal(
    as.character(rlang::get_expr(test1_plot$labels$title)),
    "Test 1 Histogram")

  # Test that geom layer types are correct
  geoms <- test1_plot$layers %>%
    map("geom") %>%
    map(class) %>%
    map_chr(1)
  expect_true("GeomBar" %in% geoms)
  expect_true("GeomDensity" %in% geoms)
})

cancer_sample_filtered_with_na <- cancer_sample %>%
  select(diagnosis, area_mean) %>%
  rbind(c(NA, NA), c(NA, NA))

test2_plot <- plot_hist_with_density(
  data=cancer_sample_filtered_with_na,
  column=area_mean,
  xlab="area_mean",
  title="Test 2 Histogram",
  narm=F)
test_that("plot_hist_with_density generates a plot with the correct features when the column contains NA values that are not removed", {
  # Test that aesthetic mappings are correct
  expect_equal(
    as.character(rlang::get_expr(test2_plot$mapping$x)),
    "area_mean")

  # Test that labels are correct
  expect_equal(
    as.character(rlang::get_expr(test2_plot$labels$xlab)),
    "area_mean")
  expect_equal(
    as.character(rlang::get_expr(test2_plot$labels$ylab)),
    "density")
  expect_equal(
    as.character(rlang::get_expr(test2_plot$labels$title)),
    "Test 2 Histogram")

  # Test that geom layer types are correct
  geoms <- test2_plot$layers %>%
    map("geom") %>%
    map(class) %>%
    map_chr(1)
  expect_true("GeomBar" %in% geoms)
  expect_true("GeomDensity" %in% geoms)
})

test_that("plot_hist_with_density throws an error for non-numeric column", {
  expect_error(
    plot_hist_with_density(
      data=cancer_sample,
      column=diagnosis,
      xlab="diagnosis",
      title="Test 3 Histogram"),
    "Cannot plot a histogram of non-numeric values!\nThe column you provided contains non-numeric values.")
})
