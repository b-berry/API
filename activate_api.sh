#!/bin/bash

# This file activates *.html file w/ required api_key(s)

SEARCH_KEY='\$WINDY_API_KEY'

function usage {

  echo "Usage: $0 OPT"
  echo "Required OPT:"
  echo "    -i Credentials File [path to]"
  echo "    -a Activate HTML by populating with API_KEY <OR>"
  echo "    -s Sanitize HTML by redacting API_KEY"
  exit 1

}

if [ $# -lt 1 ]; then
  usage
fi

function init {

  action=$1
  credfile=$2

  api_key=$(parse_credfile $credfile)

  parse_html $action $api_key

}

function parse_credfile {

  credfile=$1

  cred=$(cat $credfile | jq '.[].api_key' | awk -F '"' '{print $2}')
  if [[ -z "$cred" ]]; then
    echo "ERROR: parsing: $credfile"
    usage $0
  else
    echo "$cred" 
  fi

}

function parse_html {

  action=$1
  api_key=$2

  case $action in
    "activate" )
      search_text=$SEARCH_KEY
      replace_text=$api_key
      ;;
    "sanitize" )
      search_text=$api_key
      replace_text=$SEARCH_KEY
      ;;
    *)
      echo "ERROR: $0 encountered a problem"
      echo "Aborting"
      ;;
  esac
  
  while read HTML_FILE; do
    if [ ! -f $HTML_FILE ]; then
      echo "Failed to parse file: $HTML_FILE"
      usage $0
    else 
      CMD="sed -i '.bk' -e \"s:$search_text:$replace_text:g\" $HTML_FILE"
      eval $CMD
    fi
  done< <(find . -name *.html)

}

## Run Time Starts Here
while getopts ":hai:s" opt; do
  case $opt in
    h )
      usage
      ;;
    a )
      action="activate"
      ;;
    i )
      credentials=$OPTARG
      ;;
    s )
      action="sanitize"
      ;;
    * )
      usage $0
      ;;
  esac
done

if [ ! -f $credentials ]; then
  echo "Credentials not found: $credentials"
  usage $0
else
  init $action $credentials
  #echo $action
  #echo $credentials
fi
