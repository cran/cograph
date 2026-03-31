## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.width = 6,
  fig.height = 5,
  fig.dpi = 50,
  dpi = 50
)
library(cograph)

## ----matrix-example-----------------------------------------------------------
# Create a weighted adjacency matrix
adj_matrix <- matrix(
  c(0, 0.8, 0.5, 0.2,
    0.8, 0, 0.6, 0,
    0.5, 0.6, 0, 0.7,
    0.2, 0, 0.7, 0),
  nrow = 4, byrow = TRUE,
  dimnames = list(c("A", "B", "C", "D"), c("A", "B", "C", "D"))
)

# Plot directly from matrix
splot(adj_matrix, title = "From Adjacency Matrix")

# Create a directed (asymmetric) matrix
directed_matrix <- matrix(
  c(0, 0.9, 0, 0,
    0.2, 0, 0.7, 0,
    0.5, 0, 0, 0.8,
    0, 0.3, 0.4, 0),
  nrow = 4, byrow = TRUE,
  dimnames = list(c("A", "B", "C", "D"), c("A", "B", "C", "D"))
)

# Directed networks detected automatically
splot(directed_matrix, title = "Directed Network (auto-detected)")

## ----edgelist-example---------------------------------------------------------
# Create an edge list data frame
edges <- data.frame(
  from = c("Alice", "Alice", "Bob", "Bob", "Carol", "Dave"),
  to = c("Bob", "Carol", "Carol", "Dave", "Dave", "Alice"),
  weight = c(0.9, 0.5, 0.7, 0.3, 0.8, 0.4)
)

print(edges)

# Plot from edge list
splot(edges, title = "From Edge List")

# Alternative column names work too
edges_alt <- data.frame(
  source = c("X", "X", "Y", "Z"),
  target = c("Y", "Z", "Z", "X"),
  value = c(1, 0.5, 0.8, 0.3)
)
splot(edges_alt, title = "Alternative Column Names")

## ----igraph-example, eval=requireNamespace("igraph", quietly = TRUE)----------
# Create igraph objects
g_ring <- igraph::make_ring(6)
igraph::V(g_ring)$name <- LETTERS[1:6]

splot(g_ring, title = "igraph Ring Graph")

# Famous graph with vertex names
g_zachary <- igraph::make_graph("Zachary")
splot(g_zachary, title = "Zachary Karate Club")

# Weighted graph
g_weighted <- igraph::graph_from_adjacency_matrix(
  adj_matrix,
  mode = "undirected",
  weighted = TRUE
)
splot(g_weighted, title = "Weighted igraph")

## ----network-example, eval=requireNamespace("network", quietly = TRUE)--------
# Create a network object
net_obj <- network::network(adj_matrix, directed = FALSE)

splot(net_obj, title = "From statnet network")

## ----qgraph-example, eval=requireNamespace("qgraph", quietly = TRUE)----------
# Create a qgraph object (without plotting)
q <- qgraph::qgraph(adj_matrix, DoNotPlot = TRUE)

# Plot with cograph (preserves layout)
splot(q, title = "From qgraph Object")

## ----tna-example, eval=requireNamespace("tna", quietly = TRUE), message=FALSE----
library(tna)

# Build TNA model from included dataset
tna_model <- tna(group_regulation)

# Plot TNA model directly
splot(tna_model, title = "From TNA Model")

# With donut nodes showing initial probabilities
splot(tna_model,
      node_shape = "donut",
      donut_fill = tna_model$inits,
      title = "TNA with Initial Probabilities")

## ----weight-preprocessing-----------------------------------------------------
# Create a network with varying weights
weights_matrix <- matrix(
  c(0, 0.1, 0.5, 0.9,
    0.1, 0, 0.2, 0.7,
    0.5, 0.2, 0, 0.3,
    0.9, 0.7, 0.3, 0),
  nrow = 4, byrow = TRUE,
  dimnames = list(LETTERS[1:4], LETTERS[1:4])
)

# Apply threshold to remove weak edges
splot(weights_matrix, threshold = 0.4, title = "Threshold = 0.4 (weak edges removed)")

## ----special-cases------------------------------------------------------------
# Network with negative weights (e.g., correlation matrix)
cor_matrix <- matrix(
  c(1, 0.8, -0.5, 0.3,
    0.8, 1, 0.2, -0.7,
    -0.5, 0.2, 1, 0.4,
    0.3, -0.7, 0.4, 1),
  nrow = 4, byrow = TRUE,
  dimnames = list(LETTERS[1:4], LETTERS[1:4])
)
diag(cor_matrix) <- 0

splot(cor_matrix, title = "Negative Weights (red = negative)")

## ----as-cograph-example-------------------------------------------------------
# From matrix
net <- as_cograph(adj_matrix)
print(net)

# From edge list
net_edges <- as_cograph(edges)
print(net_edges)

# Override auto-detected directedness
net_directed <- as_cograph(adj_matrix, directed = TRUE)
cat("Directed:", attr(net_directed, "directed"), "\n")

## ----as-cograph-igraph, eval=requireNamespace("igraph", quietly = TRUE)-------
# From igraph
g <- igraph::make_ring(5)
igraph::V(g)$name <- LETTERS[1:5]
net_from_igraph <- as_cograph(g)
print(net_from_igraph)

## ----to-igraph-example, eval=requireNamespace("igraph", quietly = TRUE)-------
# From matrix
g <- to_igraph(adj_matrix)
cat("Vertices:", igraph::vcount(g), "\n")
cat("Edges:", igraph::ecount(g), "\n")

# From cograph_network
net <- as_cograph(adj_matrix)
g2 <- to_igraph(net)

# Check attributes preserved
cat("Vertex names:", paste(igraph::V(g2)$name, collapse = ", "), "\n")

## ----to-df-example------------------------------------------------------------
# From matrix
df <- to_df(adj_matrix)
print(df)

# From cograph_network
net <- as_cograph(adj_matrix)
df2 <- to_df(net)
print(df2)

## ----to-matrix-example--------------------------------------------------------
# From cograph_network
net <- as_cograph(edges)
mat <- to_matrix(net)
print(mat)

## ----to-matrix-igraph, eval=requireNamespace("igraph", quietly = TRUE)--------
# From igraph (with weights)
g <- igraph::graph_from_adjacency_matrix(
  matrix(c(0, 1, 0, 1, 1, 0, 1, 0, 0, 1, 0, 1, 1, 0, 1, 0), 4, 4,
         dimnames = list(c("W", "X", "Y", "Z"), c("W", "X", "Y", "Z"))),
  mode = "undirected",
  weighted = TRUE
)
mat <- to_matrix(g)
print(mat)

## ----to-network-example, eval=requireNamespace("network", quietly = TRUE)-----
# Convert matrix to statnet network
statnet_net <- to_network(adj_matrix)
print(statnet_net)

