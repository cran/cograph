## ----include = FALSE-------------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  fig.width = 7,
  fig.height = 5,
  out.width = "100%",
  background = "white",
  dev = "jpeg",
  fig.bg = "white",
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

# Count actual edges after parsing (non-zero entries)
net <- cograph(mat)
ne <- nrow(get_edges(net))

# Simulate statistical data for each edge
set.seed(42)
ci_widths <- runif(ne, 0.1, 0.4)
ci_lower  <- runif(ne, 0.01, 0.10)
ci_upper  <- runif(ne, 0.20, 0.50)
p_values  <- round(runif(ne, 0.0001, 0.08), 4)

## --------------------------------------------------------------------------------
splot(mat, node_size = 9, edge_labels = TRUE)

## --------------------------------------------------------------------------------
splot(mat, node_size = 9,
      edge_label_template = "{est}{stars}",
      edge_label_p = p_values,
      edge_label_stars = TRUE)

## --------------------------------------------------------------------------------
splot(mat, node_size = 9,
      edge_color = "blue",
      edge_ci = ci_widths,
      edge_ci_scale = 5,
      edge_ci_alpha = 0.6,
      edge_ci_color = "maroon")

splot(mat, node_size = 9,
      edge_color = "black",
      edge_ci = ci_widths,
      edge_ci_scale = 5,
      edge_ci_alpha = 0.6,
      edge_ci_color = "maroon")

## --------------------------------------------------------------------------------
splot(mat, node_size = 9,
      edge_label_template = "{est} [{low}, {up}]",
      edge_ci_lower = ci_lower,
      edge_ci_upper = ci_upper,
      edge_label_size = 0.4)

## --------------------------------------------------------------------------------
splot(mat, node_size = 9,
      edge_label_template = "{est}{stars}\n({range})",
      edge_ci_lower = ci_lower,
      edge_ci_upper = ci_upper,
      edge_label_p = p_values,
      edge_label_stars = TRUE,
      edge_label_size = 0.35,
      edge_ci = ci_widths,
      edge_ci_scale = 5,
      edge_ci_alpha = 0.2)

## --------------------------------------------------------------------------------
splot(mat, node_size = 9,
      edge_label_template = "{est}{stars}",
      edge_label_p = p_values,
      edge_label_stars = TRUE,
      edge_ci = ci_widths,
      edge_ci_scale = 5,
      edge_ci_alpha = 0.25,
      theme = "dark")

## --------------------------------------------------------------------------------
splot(mat, node_size = 9,
      edge_color = "grey",
      edge_label_template = "{est}{stars}",
      edge_label_p = p_values,
      edge_label_stars = TRUE,
      edge_label_size = 0.5,
      edge_ci = ci_widths,
      edge_ci_scale = 4,
      edge_ci_alpha = 0.15,
      theme = "minimal")

## ----include = FALSE----------------------------------------------------------
options(old_opts)

