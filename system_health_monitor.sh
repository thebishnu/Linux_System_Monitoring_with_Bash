#!/bin/bash

# Log file location
LOG_FILE="$HOME/system_health_monitor.log"

# Start logging
echo "============================================================================" >> "$LOG_FILE"
echo "$(date) - System Health Check Started" >> "$LOG_FILE"
echo "============================================================================" >> "$LOG_FILE"

# Monitor CPU Usage
CPU_USAGE=$(top -b -n 1 | grep "Cpu(s)" | awk '{print $2 + $4}')
echo "CPU Usage: $CPU_USAGE%" >> "$LOG_FILE"

# Monitor RAM Usage
RAM_TOTAL=$(free -m | awk 'NR==2{print $2}')
RAM_USED=$(free -m | awk 'NR==2{print $3}')
RAM_USAGE=$(awk "BEGIN {printf \"%.2f\", ($RAM_USED/$RAM_TOTAL)*100}")
echo "RAM Usage: $RAM_USED MB / $RAM_TOTAL MB ($RAM_USAGE%)" >> "$LOG_FILE"

# Monitor Disk Usage
DISK_USAGE=$(df -h / | awk 'NR==2{print $5}')
echo "Disk Usage: $DISK_USAGE" >> "$LOG_FILE"

# End logging
echo "============================================================================" >> "$LOG_FILE"
echo "$(date) - System Health Check Completed" >> "$LOG_FILE"
echo "============================================================================" >> "$LOG_FILE"
