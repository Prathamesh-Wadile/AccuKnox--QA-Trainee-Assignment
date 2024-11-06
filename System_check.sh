#!/bin/bash

EMAIL_ADDRESS="prathameshwadile0@gmail.com"

CPU_THRESHOLD=80
MEMORY_THRESHOLD=90
DISK_SPACE_THRESHOLD=10  # Percentage of free disk space

# Function to get disk space usage
function get_disk_usage() {
  df -h / | grep -v Filesystem | awk '{print $5}' | sed 's/%//'
}

# Function to get number of running processes
function get_running_processes() {
  ps aux | wc -l
}

while true; do
  cpu_usage=$(get_cpu_usage)
  memory_usage=$(get_memory_usage)
  disk_space_usage=$(get_disk_usage)
  running_processes=$(get_running_processes)

  # Check CPU usage and send alert if needed
  if [[ $cpu_usage -gt $CPU_THRESHOLD ]]; then
    echo "CPU USAGE IS HIGH! ($cpu_usage%) Sending alert..."
    echo "CPU usage is at $cpu_usage%." | mail -s "HIGH CPU USAGE on $(hostname)" $EMAIL_ADDRESS
  fi

  # Check memory usage and send alert if needed
  if [[ $memory_usage -gt $MEMORY_THRESHOLD ]]; then
    echo "MEMORY USAGE IS HIGH! ($memory_usage%) Sending alert..."
    echo "Memory usage is at $memory_usage%." | mail -s "HIGH MEMORY USAGE on $(hostname)" $EMAIL_ADDRESS
  fi

  # Check disk space usage and send alert if needed
  if [[ $disk_space_usage -gt $DISK_SPACE_THRESHOLD ]]; then
    echo "DISK SPACE IS LOW! ($disk_space_usage%) Sending alert..."
    echo "Disk space usage is at $disk_space_usage%." | mail -s "LOW DISK SPACE on $(hostname)" $EMAIL_ADDRESS
  fi

  # Check number of running processes and send alert if needed
  # (You may want to customize this based on your specific needs)
  if [[ $running_processes -gt 100 ]]; then
    echo "HIGH NUMBER OF RUNNING PROCESSES ($running_processes) Sending alert..."
    echo "Number of running processes is at $running_processes." | mail -s "HIGH PROCESS COUNT on $(hostname)" $EMAIL_ADDRESS
  fi

  sleep 300
done