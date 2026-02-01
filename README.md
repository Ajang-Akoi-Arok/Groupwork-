digitalaxis@AjangMacBook-Pro Groupwork- % clear






















































digitalaxis@AjangMacBook-Pro Groupwork- % cd ~                    
digitalaxis@AjangMacBook-Pro ~ % ls 
Coding-lab_Group17	Downloads		Movies			alu-shell		demadolla		logs
Cohort1BreakoutRoom1	Groupwork-		Music			alu-zero_day		heart_rate_log.log	reports
Desktop			Jon			Pictures		clear			james_Bond		scenarios.sh
Documents		Library			Public			dem.sh			log_archives		tiral.sh
digitalaxis@AjangMacBook-Pro ~ % cd C
cd: no such file or directory: C
digitalaxis@AjangMacBook-Pro ~ % cd Coding-lab_Group17 
digitalaxis@AjangMacBook-Pro Coding-lab_Group17 % ls 
README.md		archive_logs.sh		hospital_data		water_consumption.py
analyze_logs.sh		heart_rate_monitor.py	temperature_recorder.py
digitalaxis@AjangMacBook-Pro Coding-lab_Group17 % vi README.md 










































3. **water_meter.py** - Simulates water usage meter (1-10 units)

### Shell Scripts
1. **archive_logs.sh** - Interactive archival with timestamp naming
2. **analyze_logs.sh** - Log analysis with device statistics

## Usage Instructions

### 1. Start Monitoring
```bash
python3 heart_monitor.py start
python3 temp_sensor.py start
python3 water_meter.py start
```

### 2. Verify Data Collection
```bash
tail -f hospital_data/active_logs/heart_rate_log.log
```

### 3. Archive Logs
```bash
./archive_logs.sh
```
Select option 1-3 to archive specific log type.

### 4. Analyze Logs
```bash
./analyze_logs.sh
```
Select option 1-3 to analyze specific log file.

### 5. Stop Monitoring
```bash
python3 heart_monitor.py stop
python3 temp_sensor.py stop
python3 water_meter.py stop
```

## Features
- **Interactive Menus**: User-friendly selection for archival and analysis
- **Timestamp Archiving**: Automatic timestamp naming (heart_rate_YYYY-MM-DD_HH:MM:SS.log)
- **Device Statistics**: Count occurrences of each device
- **Temporal Analysis**: First/last entry timestamps
- **Error Handling**: Input validation and file existence checks
- **Automated Reporting**: Results appended to analysis_report.txt

## Technical Implementation
- **Shell Scripting**: select/case statements, input validation
- **File Operations**: mv, touch, awk, grep, sort, uniq
- **Data Analysis**: Statistical analysis with Linux CLI tools
- **Process Management**: Background processes with PID files

## Thanks


