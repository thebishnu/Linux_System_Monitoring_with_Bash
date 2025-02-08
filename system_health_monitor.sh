#!/bin/bash

# Log file location
LOG_FILE="$HOME/system_health_monitor.log"

# Email Alert Configuration 
EMAIL="your_email@example.com" # Use your email
CPU_THRESHOLD=80.0   # CPU usage threshold for alerts
RAM_THRESHOLD=80.0   # RAM usage threshold for alerts
DISK_THRESHOLD=80     # Disk usage threshold for alerts

# Function to send email alerts
send_alert() {
    echo -e "$1" | mail -s "$2" "$EMAIL"
}


echo "=============================================================================" >> "$LOG_FILE"
echo "$(date) - System Health Check Started" >> "$LOG_FILE"
echo "=============================================================================" >> "$LOG_FILE"

# Monitor CPU Usage
CPU_USAGE=$(top -b -n 1 | grep "Cpu(s)" | awk '{print $2 + $4}')
echo "CPU Usage: $CPU_USAGE%" >> "$LOG_FILE"

# Monitor RAM Usage
RAM_TOTAL=$(free -m | awk 'NR==2{print $2}')
RAM_USED=$(free -m | awk 'NR==2{print $3}')
RAM_USAGE=$(awk "BEGIN {printf \"%.2f\", ($RAM_USED/$RAM_TOTAL)*100}")
echo "RAM Usage: $RAM_USED MB / $RAM_TOTAL MB ($RAM_USAGE%)" >> "$LOG_FILE"

# Monitor Disk Usage
DISK_USAGE=$(df -h / | awk 'NR==2{print $5}' | tr -d '%')
echo "Disk Usage: $DISK_USAGE%" >> "$LOG_FILE"


# CPU Alert Condition
if (( $(echo "$CPU_USAGE > $CPU_THRESHOLD" | bc -l) )); then
    ALERT_MSG="Warning: CPU usage is above ${CPU_THRESHOLD}%!\nCurrent Usage: ${CPU_USAGE}%"
    send_alert "$ALERT_MSG" "High CPU Usage Alert"
    echo "ALERT: CPU usage exceeded threshold!" >> "$LOG_FILE"
fi

# RAM Alert Condition
if (( $(echo "$RAM_USAGE > $RAM_THRESHOLD" | bc -l) )); then
    ALERT_MSG="Warning: RAM usage is above ${RAM_THRESHOLD}%!\nCurrent Usage: ${RAM_USAGE}%"
    send_alert "$ALERT_MSG" "High RAM Usage Alert"
    echo "ALERT: RAM usage exceeded threshold!" >> "$LOG_FILE"
fi

# Disk Alert Condition
if (( DISK_USAGE > DISK_THRESHOLD )); then
    ALERT_MSG="Warning: Disk usage is above ${DISK_THRESHOLD}%!\nCurrent Usage: ${DISK_USAGE}%"
    send_alert "$ALERT_MSG" "High Disk Usage Alert"
    echo "ALERT: Disk usage exceeded threshold!" >> "$LOG_FILE"
fi


echo "=============================================================================" >> "$LOG_FILE"
echo "$(date) - System Health Check Completed" >> "$LOG_FILE"
echo "=============================================================================" >> "$LOG_FILE"
