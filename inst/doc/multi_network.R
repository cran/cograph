## ----setup, include = FALSE------------------------------------------------------
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

old_par <- par(no.readonly = TRUE)
par(mar = c(0,0,0,0))

## --------------------------------------------------------------------------------
library(cograph)

## --------------------------------------------------------------------------------
set.seed(42)
nodes <- paste0("N", 1:15)
m <- matrix(runif(225, 0, 0.3), 15, 15)
diag(m) <- 0
colnames(m) <- rownames(m) <- nodes

groups <- list(
  Teacher = paste0("N", 1:5),
  Student = paste0("N", 6:10),
  System  = paste0("N", 11:15)
)

## --------------------------------------------------------------------------------
par(mar = c(0, 0, 0, 0))
plot_htna(m, groups, layout = "polygon", minimum = 0.15, esize = 3)

## --------------------------------------------------------------------------------
par(mar = c(0, 0, 0, 0))
plot_htna(m, groups, layout = "circular", minimum = 0.15, esize = 3)

## --------------------------------------------------------------------------------
plot_htna(m, groups, layout = "polygon", minimum = 0.15, esize = 3,
          group_colors = c("#E63946", "#457B9D", "#2A9D8F"),
          group_shapes = c("circle", "square", "diamond"))


## --------------------------------------------------------------------------------
two_groups <- list(
  Teacher = paste0("N", 1:7),
  Student = paste0("N", 8:15)
)

plot_htna(m, two_groups, minimum = 0.15, esize = 3)

## ----fig.height = 4--------------------------------------------------------------
plot_htna(m, two_groups, minimum = 0.15, esize = 3,
          orientation = "horizontal")

## --------------------------------------------------------------------------------
four_groups <- list(
  Input   = paste0("N", 1:4),
  Process = paste0("N", 5:8),
  Output  = paste0("N", 9:12),
  Storage = paste0("N", 13:15)
)

plot_htna(m, four_groups, layout = "polygon", minimum = 0.15, esize = 3)

## ----fig.width = 8, fig.height = 8-----------------------------------------------
set.seed(42)
nodes30 <- paste0("N", 1:30)
m30 <- matrix(runif(900, 0, 0.3), 30, 30)
diag(m30) <- 0
colnames(m30) <- rownames(m30) <- nodes30

clusters <- list(
  Alpha   = paste0("N", 1:5),
  Beta    = paste0("N", 6:10),
  Gamma   = paste0("N", 11:15),
  Delta   = paste0("N", 16:20),
  Epsilon = paste0("N", 21:25),
  Zeta    = paste0("N", 26:30)
)

plot_mtna(m30, clusters, minimum = 0.1)

## ----fig.width = 8, fig.height = 8-----------------------------------------------
plot_mtna(m30, clusters, minimum = 0.1,
          shapes = c("circle", "square", "diamond",
                     "triangle", "circle", "square"),
          spacing = 4,
          shape_size = 1.5)

## ----fig.width = 8, fig.height = 8-----------------------------------------------
plot_mtna(m30, clusters, layout = "grid", spacing = 4, minimum = 0.1)

## --------------------------------------------------------------------------------
three_clusters <- list(
  Alpha = paste0("N", 1:5),
  Beta  = paste0("N", 6:10),
  Gamma = paste0("N", 11:15)
)

plot_mtna(m, three_clusters, minimum = 0.1)

## ----fig.width = 8, fig.height = 10----------------------------------------------
set.seed(42)
nodes21 <- paste0("N", 1:21)
m21 <- matrix(runif(441, 0, 0.3), 21, 21)
diag(m21) <- 0
colnames(m21) <- rownames(m21) <- nodes21

layers <- list(
  Macro = paste0("N", 1:7),
  Meso  = paste0("N", 8:14),
  Micro = paste0("N", 15:21)
)

plot_mlna(m21, layers, minimum = 0.2, legend = FALSE)

## ----fig.width = 8, fig.height = 10----------------------------------------------
plot_mlna(m21, layers, layout = "spring", minimum = 0.2, legend = FALSE)

## ----fig.width = 8, fig.height = 10----------------------------------------------
plot_mlna(m21, layers, layout = "circle", minimum = 0.2, legend = FALSE)

## ----fig.width = 8, fig.height = 10----------------------------------------------
plot_mlna(m21, layers, minimum = 0.2,
          colors = c("#E63946", "#457B9D", "#2A9D8F"),
          skew_angle = 35,
          layer_spacing = 2.5,
          legend = FALSE)

## ----fig.width = 8, fig.height = 10----------------------------------------------
plot_mlna(m21, layers, minimum = 0.2,
          between_edges = FALSE,
          legend = FALSE)

## ----include = FALSE----------------------------------------------------------
options(old_opts)
par(old_par)

