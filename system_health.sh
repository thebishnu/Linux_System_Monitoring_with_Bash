#!/bin/bash

LOG_FILE="$HOME/system_health.log"

echo "===========================================================================" >> "$LOG_FILE"

echo "System Health Check - $(date)" >> "$LOG_FILE"

echo "===========================================================================" >> "$LOG_FILE"
# Check CPU Usage
echo "CPU Usage:" >> "$LOG_FILE"
uptime >> "$LOG_FILE"

echo "---------------------------------------------------------------------------" >> "$LOG_FILE"

# Check Memory Usage
echo "Memory Usage:" >> "$LOG_FILE"
free -h >> "$LOG_FILE"

echo "---------------------------------------------------------------------------" >> "$LOG_FILE"

# Check Disk Usage
echo "Disk Usage" >> "$LOG_FILE"
df -h >> "$LOG_FILE"

echo "===========================================================================" >> "$LOG_FILE"
