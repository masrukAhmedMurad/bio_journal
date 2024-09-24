# Load necessary libraries
library(ggplot2)
library(dplyr)
update.packages(ask = FALSE, checkBuilt = TRUE)

# Read the CSV file
data <- read.csv("ENCODE_ChIP-seq.csv")

# Sort and select the top 20 values
top_20_data <- data %>%
  arrange(desc(log_p_value)) %>%
  head(20)

# Create the horizontal bar plot
ggplot(top_20_data, aes(x = reorder(TF, log_p_value), y = log_p_value)) +  # Reorder for max on top
  geom_bar(stat = "identity", fill = "steelblue", width = 0.8) +  # Set bar width
  theme_minimal() +
  labs(
    title = "Top TF Scores from the ENCODE.seq library",
    x = "Transcription Factors (TFs)",  # X-axis title
    y = "-log10(FET p-value)"  # Y-axis title
  ) +
  theme(
    plot.title = element_text(hjust = 0.5, size = 10, face = "plain"),  # Center title
    axis.title.y = element_blank(),  # Remove y-axis title
    axis.text.x = element_text(size = 10),
    axis.text.y = element_text(size = 10, color = "darkred"),  # Change color of TFs text
    axis.title.x = element_text(size = 10, face = "plain")
  ) +
  coord_flip()  # Keep horizontal bars

# Save the plot if desired
ggsave("top_20_tf_log_p_value_plot.png", width = 10, height = 6)
