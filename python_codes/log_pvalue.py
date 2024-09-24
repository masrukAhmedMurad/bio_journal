import pandas as pd
import numpy as np

# Load the CSV file
df = pd.read_csv('plots\\transcription_factor_enrichment_analysis\CheA3\ENCODE_ChIP-seq.csv')

# Add a new column with -log10 of the 'FET p-value'
df['log_p_value'] = -np.log10(df['FET p-value'])

# Save the updated DataFrame to a new CSV file
df.to_csv('plots\\transcription_factor_enrichment_analysis\CheA3\ENCODE_ChIP-seq.csv', index=False)

# Display the first few rows of the updated DataFrame (optional)
print(df.head())
