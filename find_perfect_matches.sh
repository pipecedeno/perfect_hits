#!/bin/bash

# Saving input arguments
query_file="$1"
subject_file="$2"
output_file="$3"

# obtain length of the query sequence
query_lenght=$(grep -v ">" $query_file | tr -d '\n' | wc -c | awk '{print $1}')

# Doing blast of the sequence and filtering results to keep only perfect matches
blastn -query ${query_file} -subject ${subject_file} -task blastn-short -outfmt 6 | awk -v query_length="$query_lenght" '$5==0 && $4==query_length {print $0}' > ${output_file}

# print the number of perfect matches that were stored in the output file
echo "Number of perfect matches: $(wc -l $output_file)"
