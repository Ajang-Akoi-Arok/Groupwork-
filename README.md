# Hospital Data Monitoring & Archival System
## Coding Lab - Group 17


## Project Overview
Develop an automated log management system that:
1. Collects real-time patient health metrics and resource usage data
2. Provides controlled log archiving with user selection
3. Generates analytical reports with device statistics and temporal patterns


## System Setup


### 1. Directory Structure
Coding-lab_Group17/
├── README.md
├── archive_logs.sh
├── analyze_logs.sh
├── heart_rate_monitor.py
├── temperature_recorder.py
├── water_consumption.py
└── hospital_data/
├── active_logs/
├── archived_logs/
└── reports/
text
### 2. Initialization
```bash
# Start monitoring devices (run in separate terminals)
python3 heart_rate_monitor.py start
python3 temperature_recorder.py start
python3 water_consumption.py start


# Verify data collection
tail -f hospital_data/active_logs/heart_rate_log.log
Required Tasks
Task 1: Interactive Archival Script (archive_logs.sh)
Requirements:
Presents numbered menu: 1) heart_rate_log.log, 2) temperature_log.log, 3) water_usage_log.log
Archives only selected log type
Moves the active log to the designated archive folder
Renames with timestamp: heart_rate_YYYY-MM-DD_HH:MM:SS.log
Creates a new empty log file for continued monitoring
Error handling for invalid input, missing files, and archive directory issues
Example Usage:
bash
$ ./archive_logs.sh
Select log to archive:
1) Heart Rate
2) Temperature
3) Water Usage
Enter choice (1-3): 1


Archiving heart_rate.log...
Successfully archived to heart_data_archive/heart_rate_2024-06-18_15:22:10.log
Task 2: Intelligent Analysis Script (analyze_logs.sh)
Script Requirements:
Interactive prompt with exact menu format
Validates user input (only 1, 2, or 3)
Counts occurrences of each device in the selected log file
Records both the total count per device and the timestamp of the first/last entry (bonus)
Appends results to reports/analysis_report.txt
Example Usage:
bash
$ ./analyze_logs.sh
Select log file to analyze:
1) Heart Rate (heart_rate.log)
2) Temperature (temperature.log)
3) Water Usage (water_usage.log)
Enter choice (1-3): 1


Analyzing Heart Rate log (heart_rate.log)...
Device analysis for Heart Rate log:
=========================================
HeartRate_Monitor_A: 15 entries (First: 2026-02-01 02:00:22, Last: 2026-02-01 02:00:36)
HeartRate_Monitor_B: 15 entries (First: 2026-02-01 02:00:22, Last: 2026-02-01 02:00:36)


Total log entries: 30
Report appended to hospital_data/reports/analysis_report.txt
Commands Used
Archival Commands:
date - Generate timestamps
mv - Move files to archive
touch - Create new empty logs
mkdir - Create archive directories
test - Validate inputs and file existence
Analysis Commands:
awk - Extract device data
grep - Search for device entries
sort - Sort device IDs
uniq - Count unique devices
head/tail - Get first/last entries
wc - Count total entries
Reporting Commands:
echo - Display/output results
>> - Append to report file
date - Timestamp reports
How to Run the Project
Step 1: Clone and Prepare
git clone [repository-url]
cd Coding-lab_Group17
chmod +x archive_logs.sh analyze_logs.sh
Step 2: Start Data Collection
# Terminal 1 - Heart Rate
python3 heart_rate_monitor.py start


# Terminal 2 - Temperature
python3 temperature_recorder.py start


# Terminal 3 - Water Usage
python3 water_consumption.py start
Step 3: Use the System
# Archive logs
./archive_logs.sh
# Follow prompts: Enter 1, 2, or 3


# Analyze logs
./analyze_logs.sh
# Follow prompts: Enter 1, 2, or 3


# View reports
cat hospital_data/reports/analysis_report.txt
Step 4: Test All Features
# Test archival
echo "1" | ./archive_logs.sh  # Archive heart rate
echo "2" | ./archive_logs.sh  # Archive temperature
echo "3" | ./archive_logs.sh  # Archive water usage


# Test analysis with sample data
echo "2024-06-18 10:30:00 HeartRate_Monitor_A 72" > hospital_data/active_logs/heart_rate_log.log
echo "1" | ./analyze_logs.sh


# Check results
ls -la hospital_data/archived_logs/
cat hospital_data/reports/analysis_report.txt
Learning Objectives Demonstrated
1. Shell Scripting Proficiency
Interactive scripts with user menus (select/case)
File operations (mv, touch, awk, grep)
Error handling and input validation
2. Log Management & Automation
Structured archival systems with timestamping
Automated log rotation without disrupting active processes
Organize files into dedicated directories programmatically
3. Data Analysis with CLI Tools
Extract insights from logs using awk, sort, and uniq
Generate formatted reports with device statistics
Append results to cumulative analysis files
Error Handling Implemented
Invalid user input: Only accepts 1, 2, or 3
Missing log files: Checks if file exists before operations
Archive directory issues: Creates directories if missing
File operation failures: Validates mv and touch commands
Team Members
Ajang Akoi Arok Biar 
Emmanuel Chetachi Amarikwa
Marion Wambui Gitau
Chol Mach Kuol Chol 

