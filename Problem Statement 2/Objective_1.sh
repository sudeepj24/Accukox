#!/bin/bash

# Thresholds
CPU_THRESHOLD=80
MEMORY_THRESHOLD=80
DISK_THRESHOLD=80

# Log file
LOG_FILE="/var/log/system_health.log"

# Check CPU usage
cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/., *\([0-9.]\)%* id.*/\1/" | awk '{print 100 - $1}')
if (( $(echo "$cpu_usage > $CPU_THRESHOLD" | bc -l) )); then
    echo "ALERT: High CPU usage - $cpu_usage%" | tee -a $LOG_FILE
fi

# Check memory usage
memory_usage=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
if (( $(echo "$memory_usage > $MEMORY_THRESHOLD" | bc -l) )); then
    echo "ALERT: High memory usage - $memory_usage%" | tee -a $LOG_FILE
fi

# Check disk usage
disk_usage=$(df / | grep / | awk '{print $5}' | sed 's/%//g')
if [ $disk_usage -gt $DISK_THRESHOLD ]; then
    echo "ALERT: High disk usage - $disk_usage%" | tee -a $LOG_FILE
fi

# List running processes
running_processes=$(ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 10)
echo "Running processes:" | tee -a $LOG_FILE
echo "$running_processes" | tee -a $LOG_FILE