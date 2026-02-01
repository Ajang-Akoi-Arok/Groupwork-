#!/bin/bash

# Script: analyze_logs.sh
# Purpose: Analyze log files and generate reports

LOG_DIR="hospital_data/active_logs"
REPORT_DIR="hospital_data/reports"
REPORT_FILE="$REPORT_DIR/analysis_report.txt"

# Ensure report directory exists
mkdir -p "$REPORT_DIR"

echo "Select log file to analyze:"
echo "1) Heart Rate (heart_rate.log)"
echo "2) Temperature (temperature.log)"
echo "3) Water Usage (water_usage.log)"
read -p "Enter choice (1-3): " choice

# Validate input
if [[ ! "$choice" =~ ^[1-3]$ ]]; then
    echo "Error: Invalid choice. Please enter 1, 2, or 3."
    exit 1
fi

# Map choice to log file
case $choice in
    1)
        log_file="heart_rate.log"
        log_name="Heart Rate"
        ;;
    2)
        log_file="temperature.log"
        log_name="Temperature"
        ;;
    3)
        log_file="water_usage.log"
        log_name="Water Usage"
        ;;
esac

log_path="$LOG_DIR/$log_file"

# Check if log file exists
if [ ! -f "$log_path" ]; then
    echo "Error: Log file $log_file not found in $LOG_DIR!"
    exit 1
fi

echo "Analyzing $log_name log ($log_file)..."

# Create temporary file for analysis
temp_file=$(mktemp)

# Count occurrences of each device and get first/last timestamps
echo "Device analysis for $log_name log:" > "$temp_file"
echo "=========================================" >> "$temp_file"

# Get unique devices
devices=$(awk '{print $3}' "$log_path" | sort | uniq)

total_entries=0
for device in $devices; do
    # Count entries for this device
    count=$(grep -c " $device " "$log_path")
    
    # Get first and last timestamps for this device
    first=$(grep " $device " "$log_path" | head -1 | awk '{print $1 " " $2}')
    last=$(grep " $device " "$log_path" | tail -1 | awk '{print $1 " " $2}')
    
    echo "$device: $count entries (First: $first, Last: $last)" >> "$temp_file"
    total_entries=$((total_entries + count))
done

echo "" >> "$temp_file"
echo "Total log entries:      $total_entries" >> "$temp_file"

# Display results
cat "$temp_file"

# Append to report with timestamp
echo "=========================================" >> "$REPORT_FILE"
echo "Analysis Report - $(date)" >> "$REPORT_FILE"
echo "Log file: $log_file" >> "$REPORT_FILE"
cat "$temp_file" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

echo ""
echo "Report appended to $REPORT_FILE"

# Clean up
rm "$temp_file"
