#!/bin/bash

# Replace 'access.log' with your actual log file
LOG_FILE="access.log"

# Function to count 404 errors
count_404_errors() {
  grep ' 404 ' "$LOG_FILE" | wc -l
}

# Function to find top IP addresses
find_top_ips() {
  awk '{ print $1 }' "$LOG_FILE" | sort | uniq -c | sort -nr | head -n 10
}

# Main script
404_errors=$(count_404_errors)
echo "Total 404 Errors: $404_errors"

echo "Top 10 IP Addresses:"
find_top_ips