# Install necessary libraries if you haven't
# pip install biopython matplotlib seaborn

import os
import matplotlib.pyplot as plt
import seaborn as sns
from Bio.Affy import CelFile
import pandas as pd
import numpy as np

# Set the directory where your CEL files are located
cel_files_directory = "r_codes\cel_files"  # Replace with your actual path

# List CEL files in the directory
cel_files = [f for f in os.listdir(cel_files_directory) if f.endswith(".CEL")]

# Initialize a list to store flattened expression data
data_list = []

# Loop over each CEL file and extract expression data
for cel_file in cel_files:
    file_path = os.path.join(cel_files_directory, cel_file)
    
    # Open the CEL file in binary mode
    with open(file_path, 'rb') as file:  # 'rb' opens the file in binary mode
        c = CelFile.read(file)  # Read the CEL file using biopython's CelFile
        intensities = c.intensities  # Extract intensities (2D array)
        
        # Flatten the 2D intensities into a 1D array
        flattened_intensities = intensities.flatten()
        
        # Apply log transformation to reduce the range of the data
        log_transformed = np.log1p(flattened_intensities)  # log(1 + x) transformation to avoid log(0)
        
        # Append the transformed data to the data list
        data_list.append(log_transformed)

# Create a DataFrame for the expression data
data_df = pd.DataFrame(data_list).T  # Transpose to have samples as columns

# Assign column names as the CEL file names
data_df.columns = cel_files

# Plot boxplot using seaborn
plt.figure(figsize=(10, 6))  # Set figure size
sns.boxplot(data=data_df, color="lightblue")  # Use a single color 'lightblue'

# Customize the plot
plt.title("Boxplot of Log-Transformed Raw .CEL Files")
plt.xticks(rotation=90)  # Rotate x-axis labels
plt.xlabel("Sample Names")
plt.ylabel("Log Expression Values")
plt.tight_layout()

# Show the plot
plt.show()
