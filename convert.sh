#!/bin/bash

# Function to convert a PDF file to text and move it to the output folder
convert_pdf_to_txt() {
  local pdf_file="$1"
  local output_folder="$2"
  local txt_file="$output_folder/$(basename "${pdf_file%.pdf}.txt")"
  pdf2txt.py --outfile "$txt_file" "$pdf_file" 
  echo "Converted $pdf_file to $txt_file"
}

# Function to process all PDF files in a folder recursively
process_pdfs_in_folder() {
  local input_folder="$1"
  local output_folder="$2"
  shopt -s nullglob
  for file in "$input_folder"/*; do
    if [[ -d "$file" ]]; then
      # If it's a directory, recursively process its contents
      process_pdfs_in_folder "$file" "$output_folder"
    elif [[ -f "$file" && "$file" =~ \.pdf$ ]]; then
      # If it's a PDF file, convert it to text and move it to the output folder
      convert_pdf_to_txt "$file" "$output_folder"
    fi
  done
}

# Main script
if [[ $# -ne 2 ]]; then
  echo "Usage: $0 <input_folder> <output_folder>"
  exit 1
fi

input_folder="$1"
output_folder="$2"

if [[ ! -d "$input_folder" ]]; then
  echo "Error: The input folder does not exist."
  exit 1
fi

if [[ ! -d "$output_folder" ]]; then
  mkdir -p "$output_folder"
fi

process_pdfs_in_folder "$input_folder" "$output_folder"
