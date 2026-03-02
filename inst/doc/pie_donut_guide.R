## ----include = FALSE-------------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  fig.width = 7,
  fig.height = 5,
  out.width = "100%",
  background = "white",
  fig.bg = "white",
  dev = "jpeg",
  dpi = 100,
  comment = "#>"
)
suppressPackageStartupMessages({
  library("cograph")
})
old_opts <- options()
options(scipen = 99, digits = 2, max.print = 30, width = 83)

## --------------------------------------------------------------------------------
library(cograph)

## --------------------------------------------------------------------------------
states <- c("Read", "Watch", "Try", "Ask", "Discuss",
            "Review", "Search", "Reflect", "Submit")

mat <- matrix(c(
  0.00, 0.25, 0.15, 0.00, 0.10, 0.00, 0.08, 0.00, 0.00,
  0.10, 0.00, 0.30, 0.00, 0.00, 0.12, 0.00, 0.00, 0.00,
  0.00, 0.10, 0.00, 0.20, 0.00, 0.00, 0.00, 0.15, 0.25,
  0.05, 0.00, 0.10, 0.00, 0.30, 0.00, 0.00, 0.00, 0.00,
  0.00, 0.00, 0.00, 0.15, 0.00, 0.20, 0.00, 0.18, 0.00,
  0.12, 0.08, 0.00, 0.00, 0.00, 0.00, 0.10, 0.00, 0.20,
  0.00, 0.00, 0.15, 0.00, 0.00, 0.10, 0.00, 0.00, 0.12,
  0.00, 0.00, 0.10, 0.00, 0.12, 0.00, 0.00, 0.00, 0.28,
  0.00, 0.00, 0.00, 0.00, 0.00, 0.10, 0.00, 0.05, 0.00
), nrow = 9, byrow = TRUE, dimnames = list(states, states))

## --------------------------------------------------------------------------------
splot(mat, node_size = 9,
      donut_fill = c(0.9, 0.7, 0.5, 0.8, 0.6, 0.95, 0.3, 0.75, 0.4))

## --------------------------------------------------------------------------------
splot(mat, node_size = 9,
      donut_fill = c(0.9, 0.7, 0.5, 0.8, 0.6, 0.95, 0.3, 0.75, 0.4),
      donut_color = palette_rainbow(9))

## --------------------------------------------------------------------------------
splot(mat, node_size = 9,
      donut_fill = c(0.9, 0.7, 0.5, 0.8, 0.6, 0.95, 0.3, 0.75, 0.4),
      donut_color = palette_colorblind(9),
      donut_show_value = TRUE,
      donut_value_digits = 2,
      label_position = "below")

## --------------------------------------------------------------------------------
splot(mat, node_size = 9,
      donut_fill = c(0.9, 0.7, 0.5, 0.8, 0.6, 0.95, 0.3, 0.75, 0.4),
      donut_color = palette_pastel(9),
      donut_shape = "hexagon")

## --------------------------------------------------------------------------------
splot(mat, node_size = 9,
      donut_fill = c(0.9, 0.7, 0.5, 0.8, 0.6, 0.95, 0.3, 0.75, 0.4),
      donut_color = palette_rainbow(9),
      donut_bg_color = "#2C3E50",
      donut_inner_ratio = 0.7)

## --------------------------------------------------------------------------------
splot(mat, node_size = 9,
      donut_fill = c(0.9, 0.7, 0.5, 0.8, 0.6, 0.95, 0.3, 0.75, 0.4),
      donut_color = palette_colorblind(9),
      donut_border_color = "white",
      donut_outer_border_color = "black")

## --------------------------------------------------------------------------------
set.seed(42)
pie_vals <- lapply(1:9, function(i) {
  v <- runif(3)
  v / sum(v)
})

splot(mat, node_size = 9,
      pie_values = pie_vals,
      pie_colors = rep(list(c("#E41A1C", "#377EB8", "#4DAF4A")), 9))

## --------------------------------------------------------------------------------
splot(mat, node_size = 9,
      pie_values = pie_vals,
      pie_colors = rep(list(c("#F39C12", "#8E44AD", "#1ABC9C")), 9),
      theme = "minimal")

## --------------------------------------------------------------------------------
splot(mat, node_size = 9,
      donut_fill = c(0.9, 0.7, 0.5, 0.8, 0.6, 0.95, 0.3, 0.75, 0.4),
      donut_color = palette_rainbow(9),
      donut_inner_ratio = 0.6,
      pie_values = pie_vals,
      pie_colors = rep(list(c("#E41A1C", "#377EB8", "#4DAF4A")), 9))

## --------------------------------------------------------------------------------
splot(mat, node_size = 9,
      donut_fill = c(0.9, 0.7, 0.5, 0.8, 0.6, 0.95, 0.3, 0.75, 0.4),
      donut_color = palette_rainbow(9),
      donut_show_value = TRUE,
      donut_value_digits = 2,
      edge_labels = TRUE,
      label_position = "below",
      theme = "dark")

## --------------------------------------------------------------------------------
splot(mat, node_size = 9,
      donut_fill = c(0.9, 0.7, 0.5, 0.8, 0.6, 0.95, 0.3, 0.75, 0.4),
      donut_color = palette_rainbow(9),
      donut_inner_ratio = 0.6,
      donut_show_value = TRUE,
      donut_value_digits = 2,
      donut_border_color = "white",
      donut_outer_border_color = "black",
      pie_values = pie_vals,
      pie_colors = rep(list(c("#E41A1C", "#377EB8", "#4DAF4A")), 9),
      label_position = "below",
      edge_labels = TRUE)

## ----include = FALSE----------------------------------------------------------
options(old_opts)

