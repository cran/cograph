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
  library("qgraph")
})
old_opts <- options()
options(scipen = 99, digits = 2, max.print = 30, width = 83)

## --------------------------------------------------------------------------------
library(cograph)
library(qgraph)

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
qgraph(mat, layout = "circle", vsize = 9, title = "qgraph")
splot(mat, node_size = 9, title = "splot")

## --------------------------------------------------------------------------------
qgraph(mat, layout = "circle", vsize = 9, edge.labels = TRUE, title = "qgraph")
splot(mat, node_size = 9, edge_labels = TRUE, title = "splot")

## --------------------------------------------------------------------------------
qgraph(mat, layout = "circle", vsize = 9, posCol = "maroon", negCol = "red", title = "qgraph")
splot(mat, node_size = 9, edge_positive_color = "maroon",
      edge_negative_color = "red", title = "splot")

## --------------------------------------------------------------------------------
cols <- palette_pastel(9)

qgraph(mat, layout = "circle", vsize = 9, shape = "square", color = cols, title = "qgraph")
splot(mat, node_size = 9, node_shape = "square", node_fill = cols, title = "splot")

## --------------------------------------------------------------------------------
qgraph(mat, layout = "circle", vsize = 9, curve = 0.3, curveAll = TRUE, title = "qgraph")
splot(mat, node_size = 9, curvature = 0.3, curves = "force", title = "splot")

## --------------------------------------------------------------------------------
fills <- c(0.9, 0.7, 0.5, 0.8, 0.6, 0.95, 0.3, 0.75, 0.4)

qgraph(mat, layout = "circle", vsize = 9, pie = fills, pieColor = "steelblue", title = "qgraph")
splot(mat, node_size = 9, donut_fill = fills, donut_color = "steelblue", title = "splot")

## --------------------------------------------------------------------------------
q <- qgraph(mat, layout = "spring", vsize = 9, title = "qgraph spring layout")
splot(mat, layout = q$layout, node_size = 9, title = "splot using qgraph layout")

## --------------------------------------------------------------------------------
q <- qgraph(mat, layout = "circle", vsize = 9, theme = "colorblind", title = "Original qgraph")
from_qgraph(q)

## --------------------------------------------------------------------------------
params <- from_qgraph(q, plot = FALSE)
params$node_fill <- palette_rainbow(9)
params$title <- "Tweaked from qgraph"
do.call(splot, params)

## --------------------------------------------------------------------------------
tplot(mat, vsize = 9, edge.labels = TRUE)

## --------------------------------------------------------------------------------
net <- cograph(mat)
ne <- nrow(get_edges(net))

set.seed(42)
ci_widths <- runif(ne, 0.1, 0.4)

splot(mat, node_size = 9,
      edge_ci = ci_widths,
      edge_ci_scale = 5,
      edge_ci_alpha = 0.3)

## --------------------------------------------------------------------------------
ci_lower <- runif(ne, 0.01, 0.10)
ci_upper <- runif(ne, 0.20, 0.50)

splot(mat, node_size = 9,
      edge_label_template = "{est} [{low}, {up}]",
      edge_ci_lower = ci_lower,
      edge_ci_upper = ci_upper,
      edge_label_size = 0.4)

## --------------------------------------------------------------------------------
p_values <- round(runif(ne, 0.0001, 0.08), 4)

splot(mat, node_size = 9,
      edge_label_template = "{est}{stars}",
      edge_label_p = p_values,
      edge_label_stars = TRUE)

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
      donut_fill = fills,
      donut_color = palette_rainbow(9),
      donut_shape = "hexagon")

## --------------------------------------------------------------------------------
splot(mat, node_size = 9,
      donut_fill = fills,
      donut_color = palette_rainbow(9),
      donut2_values = lapply(1:9, function(i) runif(1)),
      donut2_colors = lapply(palette_colorblind(9), function(x) x))

## ----include = FALSE----------------------------------------------------------
options(old_opts)

