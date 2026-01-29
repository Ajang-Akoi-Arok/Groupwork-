#!/usr/bin/env python3
"""
Temperature Monitoring System 
"""

import random
import time
import sys
import os
from datetime import datetime

LOG_DIR = "hospital_data/active_logs"
LOG_FILE = os.path.join(LOG_DIR, "temperature_log.log")
PID_FILE = "/tmp/temp_monitor.pid"
DEVICES = ["TEMP_SENSOR_001", "TEMP_SENSOR_002"]

def ensure_log_dir():
    if not os.path.exists(LOG_DIR):
        os.makedirs(LOG_DIR, exist_ok=True)

def log_data():
    ensure_log_dir()
    try:
        print("Temperature Monitor Started")
        while True:
            timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
            for device in DEVICES:
                temperature = round(random.uniform(36.0, 39.5), 1)
                log_entry = f"{timestamp} [{device}] {temperature} C\n"
                with open(LOG_FILE, "a") as f:
                    f.write(log_entry)
                print(f"Logged: {log_entry.strip()}")
            time.sleep(5)
    except KeyboardInterrupt:
        print("\nTemperature Monitor stopped")

def start():
    if os.path.exists(PID_FILE):
        print("Temperature monitor already running")
        return
    
    pid = os.fork()
    if pid > 0:
        with open(PID_FILE, "w") as f:
            f.write(str(pid))
        print(f"Temperature Monitor started with PID: {pid}")
    else:
        log_data()

def stop():
    if os.path.exists(PID_FILE):
        with open(PID_FILE, "r") as f:
            pid = int(f.read().strip())
        try:
            os.kill(pid, 15)
            time.sleep(1)
        except:
            pass
        os.remove(PID_FILE)
        print("Temperature Monitor stopped")
    else:
        print("Temperature Monitor not running")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python3 temp_monitor.py [start|stop]")
        sys.exit(1)
    
    if sys.argv[1] == "start":
        start()
    elif sys.argv[1] == "stop":
        stop()
    else:
        print("Invalid command")
