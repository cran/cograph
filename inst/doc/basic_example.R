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

set.seed(42)
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
), nrow = 9, byrow = TRUE)
rownames(mat) <- colnames(mat) <- states

## --------------------------------------------------------------------------------
splot(mat, node_size = 9)

## --------------------------------------------------------------------------------
splot(mat, layout = "circle", node_size = 9)

## --------------------------------------------------------------------------------
splot(mat, layout = "circle", node_size = 9, edge_labels = TRUE)

## --------------------------------------------------------------------------------
splot(mat, node_size = 9, theme = "dark", title = "Dark")
splot(mat, node_size = 9, theme = "minimal", title = "Minimal")
splot(mat, node_size = 9, theme = "colorblind", title = "Colorblind")

## --------------------------------------------------------------------------------
splot(mat, layout = "circle", node_size = 9,
      node_fill = palette_pastel(9))

## --------------------------------------------------------------------------------
splot(mat, layout = "circle", node_size = 9,
      node_shape = c("circle", "square", "triangle", "diamond",
                     "star", "pentagon", "hexagon", "heart", "circle"),
      node_fill = palette_colorblind(9))

## --------------------------------------------------------------------------------
splot(mat, node_size = 9, edge_style = 3)

## --------------------------------------------------------------------------------
splot(mat, node_size = 9, edge_start_style = "dashed")

## --------------------------------------------------------------------------------
splot(mat, node_size = 9, edge_labels = TRUE,
      edge_label_size = 0.6,
      edge_positive_color = "#1976D2",
      edge_negative_color = "#D32F2F",
      donut_fill = runif(9),
      donut_color = palette_rainbow(9),
      theme = "minimal")

## --------------------------------------------------------------------------------
soplot(mat, node_size = 9, layout = "oval")

## ----eval = FALSE----------------------------------------------------------------
# splot(mat, node_size = 9, filetype = "png",
#       filename = file.path(tempdir(), "network"), width = 8, height = 8)

## ----include = FALSE----------------------------------------------------------
options(old_opts)

