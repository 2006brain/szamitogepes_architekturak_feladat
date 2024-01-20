#!/bin/bash

# Function to print colored text
print_colored() {
    case $1 in
        red)    echo -e "\e[91m$2\e[0m" ;;
        green)  echo -e "\e[92m$2\e[0m" ;;
        yellow) echo -e "\e[93m$2\e[0m" ;;
        blue)   echo -e "\e[94m$2\e[0m" ;;
        *)      echo "$2" ;;
    esac
}

# Function to fetch and extract headlines
get_headlines() {
    url=$1
    source_color=$2

    echo "Fetching headlines from $url..."

    # Fetch webpage and extract headlines
    headlines=$(curl -s "$url" | grep -oP '<h2[^>]*>\K.*?(?=<\/h2>)')

    # Display headlines with source in color
    IFS=$'\n'
    for headline in $headlines; do
        print_colored "$source_color" "Source: $url - Headline: $headline"
    done
}

# Main script
get_headlines "https://www.bbc.com" "red"
get_headlines "https://www.foxnews.com" "green"
get_headlines "https://www.theguardian.com/europe" "blue"

