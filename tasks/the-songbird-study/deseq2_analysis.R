# # Install and load DESeq2
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("DESeq2")
library(DESeq2)

performDESeq2Analysis <- function(input_file, output_file) {
  count_data <- read.csv(input_file, header = TRUE)
  count_data <- count_data[, !(colnames(count_data) %in% c("sample_id", "social_settting", "study_group", "tissue_id"))]
  print(head(count_data))
  # Create a DESeqDataSet object
  dds <- DESeqDataSetFromMatrix(countData = count_data,
                                colData = NULL,
                                design = ~1)

  # Run DESeq2 analysis
  dds <- DESeq(dds)

  # Get the results
  results <- results(dds)

  # Save the results to the output file
  write.table(results, file = output_file, sep = "\t", quote = FALSE, col.names = NA)
}

# Command-line arguments
args <- commandArgs(trailingOnly = TRUE)

# Extract input and output file paths
input_file <- args[1]
output_file <- args[2]

# Perform DESeq2 analysis
performDESeq2Analysis(input_file, output_file)
