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

## ----fig.height=6-------------------------------------------------------------
splot(regulation_net, tna_styling = TRUE, minimum = 0.1,
  title = "Learning Regulation Network")

## ----eval=FALSE---------------------------------------------------------------
# splot(regulation_net, layout = "spring")
# splot(regulation_net, minimum = 0.1, edge_labels = TRUE)
# splot(regulation_net, scale_nodes_by = "betweenness")
# splot(regulation_net, theme = "dark")
# splot(regulation_net, tna_styling = TRUE)

## ----fig.height=6, fig.width=10-----------------------------------------------
plot_simplicial(regulation_net,
  c("Explore Plan -> Monitor",
    "Monitor Adapt -> Reflect",
    "Discuss Synthesize -> Evaluate",
    "Create Share -> Explore"),
  dismantled = TRUE, ncol = 2,
  title = "Higher-Order Pathways")

## -----------------------------------------------------------------------------
strong <- filter_edges(regulation_net, weight > 0.3)
as.data.frame(strong)

## -----------------------------------------------------------------------------
top3 <- select_nodes(regulation_net, top = 3, by = "betweenness")
get_labels(top3)

## -----------------------------------------------------------------------------
regulation_net |>
  threshold_edges(minimum = 0.3) |>
  remove_isolates() |>
  mutate_nodes(deg = degree, hub = degree >= 3) |>
  as.data.frame(what = "nodes")

## -----------------------------------------------------------------------------
data(student_interactions)
centrality(student_interactions)

## -----------------------------------------------------------------------------
centrality_degree(student_interactions)
centrality_pagerank(student_interactions)

## -----------------------------------------------------------------------------
centrality(student_interactions,
           measures = c("collective_influence", "harmonic", "rsp_betweenness",
                        "trust_pagerank", "lhc", "beta_measure"),
           sort_by = "trust_pagerank", digits = 3)

## -----------------------------------------------------------------------------
network_summary(regulation_net)

## -----------------------------------------------------------------------------
comms <- communities(regulation_net, method = "walktrap")
comms
community_sizes(comms)

## -----------------------------------------------------------------------------
mot <- motifs(regulation_net, significance = FALSE)
mot

## ----eval=FALSE---------------------------------------------------------------
# robustness(regulation_net, type = "vertex", measure = "betweenness", n_iter = 100)
# plot_robustness(x = regulation_net, measures = c("betweenness", "degree", "random"))

## ----eval=FALSE---------------------------------------------------------------
# backbone <- disparity_filter(as_cograph(regulation_net), level = 0.05)
# splot(backbone)

## ----eval=FALSE---------------------------------------------------------------
# clusters <- list(
#   Cognitive  = c("Explore", "Plan", "Monitor", "Adapt", "Reflect"),
#   Social     = c("Discuss", "Synthesize", "Share"),
#   Evaluative = c("Evaluate", "Create")
# )
# plot_mcml(regulation_net, clusters, mode = "tna")
# plot_mtna(regulation_net, clusters)

