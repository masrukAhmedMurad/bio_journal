# Install necessary packages if not already installed
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("clusterProfiler")
BiocManager::install("org.Hs.eg.db")
BiocManager::install("enrichplot")
BiocManager::install("ggplot2")

# Load the libraries
library(clusterProfiler)
library(org.Hs.eg.db) # For human gene annotation
library(enrichplot)
library(ggplot2)


update.packages(ask = FALSE, checkBuilt = TRUE)


genes <- c("LIMD1", "TCF7L2", "ABCC1", "RPN2", "HNRNPD", 
           "TF", "HIST1H3B", "IL10RA", "DIEXF", "UPP1", 
           "P4HB", "EGFR", "RIF1", "RANBP10", "LPAR1", 
           "SFPQ", "MAN1A2", "ANKHD1-EIF4EBP3///ANKHD1", "MBNL1", "FUBP1", 
           "CORT", "NR2E3", "EGR1", "GALNT14", "KLF5", 
           "COQ9", "PPP2CB", "BRE", "PLA2G5", "PCGF1")

# Perform GO enrichment analysis
go_enrichment <- enrichGO(gene         = genes,
                          OrgDb        = org.Hs.eg.db,
                          keyType      = "SYMBOL",  # Indicating the key type is SYMBOL
                          ont          = "ALL",    # You can choose BP (Biological Process), MF (Molecular Function), CC (Cellular Component), or ALL
                          #pAdjustMethod = "BH",    # Benjamini-Hochberg correction for multiple testing
                          pvalueCutoff = 0.15,
                          #qvalueCutoff = 0.05
                          )

#bp=0.7,mf=1.5  pdcof
# View summary of enrichment
summary(go_enrichment)


go_enrichment_df <- as.data.frame(go_enrichment)

# Write the data frame to a CSV file
write.csv(go_enrichment_df, file = "GO_Enrichment_Results.csv", row.names = FALSE)

#goplot(go_enrichment, showCategory = 20)
# Dot plot for the GO enrichment results
dotplot(go_enrichment, showCategory = 20) + ggtitle("GO Enrichment Analysis (ALL)")

# Bar plot for the GO enrichment results
barplot(go_enrichment, showCategory = 20) + ggtitle("GO Enrichment Analysis (ALL)")

# GO term network plot
#cnetplot(go_enrichment, showCategory = 10, foldChange = NULL) + ggtitle("GO Term Network (CC)")
library(ggplot2)

# Modify the cnetplot
# Just the gene symbols (no fold change values)
cnetplot(go_enrichment, showCategory = 10) +
  ggtitle("GO Term Network (ALL)") +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold", size = 16),  # Center the title, bold, and increase size
    plot.margin = margin(20, 20, 20, 20),  # Add padding around the plot
    plot.subtitle = element_text(margin = margin(b = 20))  # Space below the title
  )

# Assuming you already have your GO enrichment result (go_enrichment)

# Calculate the term similarity matrix
go_enrichment_sim <- pairwise_termsim(go_enrichment)

# Now create the enrichment map plot (emapplot)
emapplot(go_enrichment_sim, showCategory = 10) +
  ggtitle("GO Term Enrichment Map (ALL)") +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold", size = 16),  # Center the title, bold, and increase size
    plot.margin = margin(20, 20, 20, 20),  # Add padding around the plot
    plot.subtitle = element_text(margin = margin(b = 20))  # Space below the title
  )





