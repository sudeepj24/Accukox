#!/bin/bash

# Log file location
LOG_FILE="/var/log/apache2/access.log"

# Analyzing log file
echo "Number of 404 errors:"
grep " 404 " $LOG_FILE | wc -l

echo "Total number of requests:"
wc -l < $LOG_FILE

echo "Breakdown of request methods:"
awk '{print $6}' $LOG_FILE | sort | uniq -c | sort -rn

echo "Most common response status codes:"
awk '{print $9}' $LOG_FILE | sort | uniq -c | sort -rn | head -10

echo "Most requested pages:"
awk '{print $7}' $LOG_FILE | sort | uniq -c | sort -rn | head -10

echo "IP addresses with the most requests:"
awk '{print $1}' $LOG_FILE | sort | uniq -c | sort -rn | head -10

echo "User agents making the requests:"
awk -F\" '{print $6}' $LOG_FILE | sort | uniq -c | sort -rn | head -10

echo "Referrer URLs:"
awk -F\" '{print $4}' $LOG_FILE | grep -v '^-$' | sort | uniq -c | sort -rn | head -10

echo "Requests by hour:"
awk '{print $4}' $LOG_FILE | cut -d: -f2 | sort | uniq -c | sort -rn

echo "Requests by day:"
awk '{print $4}' $LOG_FILE | cut -d: -f1 | sort | uniq -c | sort -rn
