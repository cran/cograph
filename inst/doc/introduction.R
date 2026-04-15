## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.width = 7,
  fig.height = 6,
  fig.dpi = 72,
  dpi = 72,
  message = FALSE,
  warning = FALSE
)

## ----setup--------------------------------------------------------------------
library(cograph)

## -----------------------------------------------------------------------------
set.seed(42)
n <- 10
states <- c("Explore", "Plan", "Monitor", "Adapt", "Reflect",
            "Discuss", "Synthesize", "Evaluate", "Create", "Share")
mat <- matrix(0, n, n, dimnames = list(states, states))
# Sparse: ~30% of edges populated
edges <- sample(which(row(mat) != col(mat)), 30)
mat[edges] <- round(runif(30, 0.05, 0.5), 2)

## ----fig.height=6-------------------------------------------------------------
splot(mat, tna_styling = TRUE, minimum = 0.1,
  title = "Learning Regulation Network")

## ----eval=FALSE---------------------------------------------------------------
# splot(mat, layout = "spring")
# splot(mat, minimum = 0.1, edge_labels = TRUE)
# splot(mat, scale_nodes_by = "betweenness")
# splot(mat, theme = "dark")
# splot(mat, tna_styling = TRUE)

## ----fig.height=6, fig.width=10-----------------------------------------------
plot_simplicial(mat,
  c("Explore Plan -> Monitor",
    "Monitor Adapt -> Reflect",
    "Discuss Synthesize -> Evaluate",
    "Create Share -> Explore"),
  dismantled = TRUE, ncol = 2,
  title = "Higher-Order Pathways")

## -----------------------------------------------------------------------------
strong <- filter_edges(mat, weight > 0.3)
get_edges(strong)

## -----------------------------------------------------------------------------
top3 <- select_nodes(mat, top = 3, by = "betweenness")
get_labels(top3)

## -----------------------------------------------------------------------------
centrality(mat, measures = c("degree", "betweenness", "pagerank"))

## -----------------------------------------------------------------------------
centrality_degree(mat)
centrality_pagerank(mat)

## -----------------------------------------------------------------------------
network_summary(mat)

## -----------------------------------------------------------------------------
comms <- communities(mat, method = "walktrap")
comms
community_sizes(comms)

## -----------------------------------------------------------------------------
mot <- motifs(mat, significance = FALSE)
mot

## ----eval=FALSE---------------------------------------------------------------
# robustness(mat, type = "vertex", measure = "betweenness", n_iter = 100)
# plot_robustness(x = mat, measures = c("betweenness", "degree", "random"))

## ----eval=FALSE---------------------------------------------------------------
# disparity_filter(mat)
# splot.tna_disparity(disparity_filter(mat))

## ----eval=FALSE---------------------------------------------------------------
# clusters <- list(
#   Cognitive  = c("Explore", "Plan", "Monitor", "Adapt", "Reflect"),
#   Social     = c("Discuss", "Synthesize", "Share"),
#   Evaluative = c("Evaluate", "Create")
# )
# plot_mcml(mat, clusters, mode = "tna")
# plot_mtna(mat, clusters)

## ----eval=FALSE---------------------------------------------------------------
# mat |>
#   cograph() |>
#   sn_layout("spring") |>
#   sn_theme("minimal") |>
#   sn_nodes(size = 8, fill = "steelblue") |>
#   sn_edges(curvature = 0.2) |>
#   sn_render(title = "My Network")
# 
# mat |> cograph() |> sn_save("network.pdf")
# p <- mat |> cograph() |> sn_ggplot()

