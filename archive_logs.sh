#!/bin/bash

# Script: archive_logs.sh
# Purpose: Archive log files with timestamp

LOG_DIR="hospital_data/active_logs"
ARCHIVE_DIR="hospital_data/archived_logs"

# Ensure archive directories exist
mkdir -p "$ARCHIVE_DIR/heart_data_archive"
mkdir -p "$ARCHIVE_DIR/temperature_data_archive"
mkdir -p "$ARCHIVE_DIR/water_usage_data_archive"

echo "Select log to archive:"
echo "1) Heart Rate"
echo "2) Temperature"
echo "3) Water Usage"
read -p "Enter Choice (1-3): " choice

# Validate input
if [[ ! "$choice" =~ ^[1-3]$ ]]; then
    echo "Error: Invalid Choice. Please enter 1, 2, or 3."
    exit 1
fi

# Map choice to log file and archive directory
case $choice in
    1)
        log_file="heart_rate.log"
        log_name="Heart Rate"
        archive_subdir="heart_data_archive"
        ;;
    2)
        log_file="temperature.log"
        log_name="Temperature"
        archive_subdir="temperature_data_archive"
        ;;
    3)
        log_file="water_usage.log"
        log_name="Water Usage"
        archive_subdir="water_usage_data_archive"
        ;;
esac

log_path="$LOG_DIR/$log_file"
archive_path="$ARCHIVE_DIR/$archive_subdir"

# Check if log file exists
if [ ! -f "$log_path" ]; then
    echo "Error: Log file $log_file not found in $LOG_DIR!"
    exit 1
fi

# Check if archive directory exists
if [ ! -d "$archive_path" ]; then
    echo "Error: Archive directory $archive_path not found!"
    exit 1
fi

echo "Archiving $log_name log..."

# Generate timestamp for archive filename
timestamp=$(date '+%Y-%m-%d_%H:%M:%S')
archive_file="$archive_path/${log_file%.*}_${timestamp}.log"

# Archive the log file
if mv "$log_path" "$archive_file"; then
    echo "Successfully archived to $archive_file"
    
    # Create new empty log file for continued monitoring
    touch "$log_path"
    echo "Created new empty log file: $log_path"
else
    echo "Error: Failed to archive log file!"
    exit 1
fi
