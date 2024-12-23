#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <log_file>"
    exit 1
fi

if [ ! -f "$1" ]; then
    echo "File not found!"
    exit 1
fi


echo -e 'Top 5 IP addresses with the most requests:';
awk '{print $1}' $1 | sort | uniq -c | sort -r | head -n 5 | awk '{line=$2" - "$1" requests"; print line}'

echo -e "\nTop 5 user agents";
awk -F'"' '/(GET|POST|DELETE|PATCH|HEAD|OPTIONS|PUT|CONNECT|TRACE)/ {print $6}' $1 | sort | uniq -c | sort -r | head -n 5 | awk '{line=$2" - "$1" requests"; print line}'

echo -e '\nTop 5 most requested paths:';
awk '{print $7}' $1 | sort -n | uniq -c | sort -r | head -n 5 | awk '{line=$2" - "$1" requests"; print line}'

echo -e '\nTop 5 response status codes:';
awk -F'"' '/(GET|POST|DELETE|PATCH|HEAD|OPTIONS|PUT|CONNECT|TRACE)/ {split($3, a, " "); print a[1]}' $1| sort | uniq -c | sort -rn | head -n 5 | awk '{print $2" - "$1" requests"}'