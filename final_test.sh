#!/bin/bash
echo "=== FINAL PROJECT TEST ==="

echo "1. Testing archive script..."
echo "1" | ./archive_logs.sh
echo "2" | ./archive_logs.sh
echo "3" | ./archive_logs.sh

echo ""
echo "2. Testing analysis script..."
echo "2024-06-18 10:30:00 HeartRate_Monitor_A 72" > hospital_data/active_logs/heart_rate_log.log
echo "1" | ./analyze_logs.sh

echo ""
echo "3. Results:"
echo "Active logs:"
ls -la hospital_data/active_logs/
echo ""
echo "Archives created:"
find hospital_data/archived_logs -name "*.log" | wc -l
echo ""
echo "Latest report:"
tail -10 hospital_data/reports/analysis_report.txt
