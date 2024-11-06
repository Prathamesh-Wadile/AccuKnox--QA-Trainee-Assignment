#!/bin/bash

# Replace with your application's URL
URL="https://www.example.com"

# Set the expected HTTP status code (e.g., 200 for OK)
EXPECTED_STATUS_CODE=200

# Function to check the application status
check_application_status() {
  response_code=$(curl -s -o /dev/null -w "%{http_code}" "$URL")

  if [[ $response_code -eq $EXPECTED_STATUS_CODE ]]; then
    echo "Application is UP"
  else
    echo "Application is DOWN"
  fi
}

# Main script
check_application_status