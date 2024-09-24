# Load libraries
#install.packages("pheatmap")  # if not already installed
#install.packages("RColorBrewer")  # if not already installed
# Load libraries
library(pheatmap)
library(RColorBrewer)
library(readr)

# Clear the graphics device
graphics.off()

# Read the distance matrix
distance_matrix <- read_csv("GSE5281_series_matrix_cleaned_euclidean_distance_matrix.csv")

# Convert to matrix
distance_matrix <- as.matrix(distance_matrix)

# Define color palette
colors <- colorRampPalette(brewer.pal(9, "YlOrBr"))(100)

# Create the heatmap
pheatmap(distance_matrix,
         clustering_distance_rows = "euclidean", 
         clustering_distance_cols = "euclidean", 
         clustering_method = "complete", 
         main = "Heatmap with Dendrogram",
         show_colnames = FALSE,  
         color = colors  # Use the defined color palette
)
