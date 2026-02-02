# Hospital Data Monitoring & Archival System


## Project Objective
Develop an automated log management system that:
- Collects real-time patient health metrics and resource usage data
- Provides controlled log archiving with user selection
- Generates analytical reports with device statistics and temporal patterns


## Directory Structure
```
Coding-lab_Group17/
├── hospital_data/
│   ├── active_logs/
│   │   ├── heart_rate_log.log
│   │   ├── temperature_log.log
│   │   └── water_usage_log.log
│   ├── archived_logs/
│   │   ├── heart_data_archive/
│   │   ├── temperature_archive/
│   │   └── water_archive/
│   └── reports/
│       └── analysis_report.txt
├── heart_rate_monitor.py
├── temperature_recorder.py
├── water_consumption.py
├── archive_logs.sh
├── analyze_logs.sh
└── README.md
```


## Complete Workflow


### Step 1: Start Data Collection
```bash
cd Coding-lab_Group17
python3 heart_rate_monitor.py start
python3 temperature_recorder.py start
python3 water_consumption.py start
```


**Expected Output:**
```
Started. PID: 60917
Started. PID: 60919
Started. PID: 60921
```


### Step 2: Monitor Real-time Data
```bash
tail -f hospital_data/active_logs/heart_rate_log.log
```


**Expected Log Format:**
```
2026-02-02 17:38:55 HeartRate_Monitor_A 60
2026-02-02 17:38:55 HeartRate_Monitor_B 81
2026-02-02 17:38:56 HeartRate_Monitor_A 82
2026-02-02 17:38:56 HeartRate_Monitor_B 78
2026-02-02 17:38:57 HeartRate_Monitor_A 62
2026-02-02 17:38:57 HeartRate_Monitor_B 76
```


### Step 3: Archive Logs (Interactive)
```bash
./archive_logs.sh
```


**Interactive Menu:**
```
Select log to archive:
1) Heart Rate
2) Temperature
3) Water Usage
Enter choice (1-3): 1
```


**Expected Outcome:**
```
Archiving Heart Rate log...
Successfully archived to hospital_data/archived_logs/heart_data_archive/heart_rate_2026-02-02_17:39:47.log
Created new empty log file: hospital_data/active_logs/heart_rate.log
```


### Step 4: Analyze Archived Data
```bash
./analyze_logs.sh
```


**Interactive Menu:**
```
Select log file to analyze:
1) Heart Rate (heart_rate.log)
2) Temperature (temperature.log)
3) Water Usage (water_usage.log)
Enter choice (1-3): 1
```


**Expected Analysis Output:**
```
Analyzing Heart Rate log (heart_rate.log)...
Device analysis for Heart Rate log:
=========================================
HeartRate_Monitor_A: 54 entries (First: 2026-02-02 17:39:48, Last: 2026-02-02 17:40:14)
HeartRate_Monitor_B: 54 entries (First: 2026-02-02 17:39:48, Last: 2026-02-02 17:40:14)


Total log entries:      108


Report appended to hospital_data/reports/analysis_report.txt
```


### Step 5: View Analysis Report
```bash
cat hospital_data/reports/analysis_report.txt
```


**Expected Report Content:**
```
=========================================
Analysis Report - Mon Feb  2 17:40:14 CAT 2026
Log file: heart_rate.log
Device analysis for Heart Rate log:
=========================================
HeartRate_Monitor_A: 54 entries (First: 2026-02-02 17:39:48, Last: 2026-02-02 17:40:14)
HeartRate_Monitor_B: 54 entries (First: 2026-02-02 17:39:48, Last: 2026-02-02 17:40:14)


Total log entries:      108
```


### Step 6: Stop Monitoring
```bash
python3 heart_rate_monitor.py stop
python3 temperature_recorder.py stop
python3 water_consumption.py stop
```


**Expected Output:**
```
Stopped.
Stopped.
Stopped.
```


## Data Formats


### Heart Rate Log Format
```
YYYY-MM-DD HH:MM:SS HeartRate_Monitor_X XX
```


### Temperature Log Format
```
YYYY-MM-DD HH:MM:SS Temp_Recorder_X XX.X
```


### Water Usage Log Format
```
YYYY-MM-DD HH:MM:SS Water_Consumption_Meter XX
```


## System Features


### Monitoring Capabilities
- **Heart Rate**: 2 monitors (HeartRate_Monitor_A/B), 60-100 BPM range
- **Temperature**: 2 sensors (Temp_Recorder_A/B), temperature monitoring
- **Water Usage**: 1 meter (Water_Consumption_Meter), usage tracking


### Archival Features
- **Timestamp Naming**: `heart_rate_YYYY-MM-DD_HH:MM:SS.log`
- **Organized Storage**: Separate archive directories per data type
- **Interactive Selection**: User-friendly menu system
- **File Management**: Creates new empty log files after archival


### Analysis Features
- **Device Statistics**: Entry count per device with timestamps
- **Temporal Analysis**: First and last entry timestamps
- **Automated Reporting**: Results appended to centralized report
- **Report Format**: Timestamped analysis with device breakdown


## Troubleshooting


### Common Issues
1. **Permission Denied**: Run `chmod +x *.sh`
2. **Directory Not Found**: Scripts auto-create required directories
3. **Process Management**: Simple start/stop commands with PID tracking


### Verification Commands
```bash
# Check if logs are being generated
ls -la hospital_data/active_logs/


# Check archived files
ls -la hospital_data/archived_logs/*/


# View recent log entries
tail hospital_data/active_logs/heart_rate_log.log
```



