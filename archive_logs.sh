#!/bin/bash

# Configuration
LOG_FILES=("heart_rate_log.log" "temperature_log.log" "water_usage_log.log")
LOG_NAMES=("Heart Rate" "Temperature" "Water Usage")
ARCHIVE_SUBDIRS=("heart_data_archive" "temperature_data_archive" "water_usage_data_archive")

ACTIVE_LOGS="hospital_data/active_logs"
ARCHIVE_BASE="hospital_data/archived_logs"

show_menu() {
    echo "Select log to archive:"
    echo "1) Heart Rate"
    echo "2) Temperature"
    echo "3) Water Usage"
    printf "Enter choice (1-3): "
}

get_timestamp() {
    date +"%Y-%m-%d_%H:%M:%S"
}

# Main execution
main() {
    # Display menu and get user input
    show_menu
    read -r choice
    
    # Error handling: Invalid user input
    if [[ ! "$choice" =~ ^[1-3]$ ]]; then
        echo "Error: Invalid choice. Please enter a number between 1 and 3." >&2
        exit 1
    fi
    
    # Get selected log details
    index=$((choice-1))
    log_file="${LOG_FILES[$index]}"
    log_name="${LOG_NAMES[$index]}"
    archive_subdir="${ARCHIVE_SUBDIRS[$index]}"
    
    source_path="$ACTIVE_LOGS/$log_file"
    archive_dir="$ARCHIVE_BASE/$archive_subdir"
    
    echo "Archiving $log_name log..."
    
    # Error handling: Missing log files
    if [ ! -f "$source_path" ]; then
        echo "Error: Log file '$log_file' not found." >&2
        exit 1
    fi
    
    # Create archive directory if it doesn't exist
    mkdir -p "$archive_dir"
    
    # Error handling: Archive directory issues
    if [ ! -d "$archive_dir" ]; then
        echo "Error: Failed to create archive directory '$archive_dir'." >&2
        exit 1
    fi
    
    # Generate timestamp and new filename
    timestamp=$(get_timestamp)
    log_basename="${log_file%.*}"  # Removes .log extension
    archive_name="${log_basename}_${timestamp}.log"
    dest_path="$archive_dir/$archive_name"
    
    # Move the active log to its designated archive folder
    if ! mv "$source_path" "$dest_path"; then
        echo "Error: Failed to move log file to archive." >&2
        exit 1
    fi
    
    # Create a new empty log file for continued monitoring
    if ! touch "$source_path"; then
        echo "Error: Failed to create new log file." >&2
        exit 1
    fi
    
    # Success message matching example exactly
    echo "Successfully archived to $archive_subdir/$archive_name"
    
    exit 0
}

# Run main function
main
