import pandas as pd

# Read the TSV file
tsv_file = pd.read_csv('plots\\transcription_factor_enrichment_analysis\CheA3\ENCODE_ChIP-seq (3).tsv', sep='\t')

# Write the data to a CSV file
tsv_file.to_csv('plots\\transcription_factor_enrichment_analysis\CheA3\ENCODE_ChIP-seq (3).csv', index=False)
