#!/bin/bash
# Log Archival System 

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

HOSPITAL_DATA="hospital_data"
ACTIVE_LOGS="$HOSPITAL_DATA/active_logs"
ARCHIVE_DIR="$HOSPITAL_DATA/archived_logs"

HEART_ARCHIVE="$ARCHIVE_DIR/heart_data_archive"
TEMP_ARCHIVE="$ARCHIVE_DIR/temperature_data_archive"
WATER_ARCHIVE="$ARCHIVE_DIR/water_usage_data_archive"

create_directories() {
    mkdir -p "$ACTIVE_LOGS"
    mkdir -p "$HEART_ARCHIVE"
    mkdir -p "$TEMP_ARCHIVE"
    mkdir -p "$WATER_ARCHIVE"
}

display_menu() {
    clear
    echo "=========================================="
    echo "     HOSPITAL LOG ARCHIVAL SYSTEM"
    echo "=========================================="
    echo "Select log to archive:"
    echo "  1) heart_rate_log.log"
    echo "  2) temperature_log.log"
    echo "  3) water_usage_log.log"
    echo "  4) Exit"
    echo "=========================================="
}

archive_log() {
    case $1 in
        1)
            log="heart_rate_log.log"
            archive="$HEART_ARCHIVE"
            name="Heart Rate"
            prefix="heart_rate"
            ;;
        2)
            log="temperature_log.log"
            archive="$TEMP_ARCHIVE"
            name="Temperature"
            prefix="temperature"
            ;;
        3)
            log="water_usage_log.log"
            archive="$WATER_ARCHIVE"
            name="Water Usage"
            prefix="water_usage"
            ;;
    esac
    
    source="$ACTIVE_LOGS/$log"
    
    if [ ! -f "$source" ]; then
        echo -e "${YELLOW}$name log not found. Creating empty file.${NC}"
        touch "$source"
        return 0
    fi
    
    if [ ! -s "$source" ]; then
        echo -e "${YELLOW}$name log is empty. Nothing to archive.${NC}"
        return 0
    fi
    
    timestamp=$(date +"%Y-%m-%d_%H:%M:%S")
    dest="$archive/${prefix}_${timestamp}.log"
    
    echo -e "${YELLOW}Archiving $name log...${NC}"
    
    if mv "$source" "$dest"; then
        echo -e "${GREEN}✓ Successfully archived${NC}"
        touch "$source"
        entries=$(wc -l < "$dest" 2>/dev/null || echo "0")
        echo -e "${GREEN}✓ Archived $entries entries${NC}"
    else
        echo -e "${RED}✗ Failed to archive${NC}"
    fi
}

main() {
    create_directories
    
    while true; do
        display_menu
        read -p "Enter choice (1-4): " choice
        
        case $choice in
            1|2|3)
                echo ""
                archive_log "$choice"
                ;;
            4)
                echo -e "${GREEN}Exiting. Goodbye!${NC}"
                exit 0
                ;;
            *)
                echo -e "${RED}Invalid choice. Enter 1-4${NC}"
                ;;
        esac
        
        echo ""
        read -p "Press Enter to continue..."
    done
}

main
