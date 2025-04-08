#!/bin/bash

URL=$1
MAX_RETRIES=5
RETRY_DELAY=5

for ((i=1; i<=$MAX_RETRIES; i++)); do
  response=$(curl -s -o /dev/null -w "%{http_code}" $URL)
  
  if [ "$response" -eq 200 ]; then
    echo "Success: Received 200 OK from $URL"
    exit 0
  else
    echo "Attempt $i: Failed to get 200 OK (got $response). Retrying in $RETRY_DELAY seconds..."
    if [ "$i" -ne "$MAX_RETRIES" ]; then
      sleep $RETRY_DELAY
    fi
  fi
done

echo "Error: Max retries reached without success"
exit 1
