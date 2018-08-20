#!/bin/bash

# This file activates *.html file w/ required api_key(s)

if [ -z $1 ]; then
  echo "Please provide a credentials file!"
  exit 1
fi

CREDENTIALS=$1
REPLACE_TEXT='\$WINDY_API_KEY'

if [ ! -f $CREDENTIALS ]; then
  echo "Credentials not found: $CREDENTIALS"
  exit 2
fi

API_KEY=$(cat $CREDENTIALS | jq '.[].api_key' | awk -F '"' '{print $2}')
while read HTML_FILE; do
  if [ ! -f $HTML_FILE ]; then
    echo "Failed to parse file: $HTML_FILE"
    exit 3
  else 
    CMD="sed -i '.bk' -e \"s:$REPLACE_TEXT:$API_KEY:g\" $HTML_FILE"
    eval $CMD
  fi
done< <(find . -name *.html)
