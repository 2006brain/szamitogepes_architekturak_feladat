#!/bin/bash

# Function to print in the paired color
print_colored() {
    case $1 in
        red)    echo -e "\e[91m$2\e[0m" ;;
        green)  echo -e "\e[92m$2\e[0m" ;;
        blue)   echo -e "\e[94m$2\e[0m" ;;
        yellow) echo -e "\e[93m$2\e[0m" ;;
        *)      echo "$2" ;;
    esac
}

# Function to fetch and display headlines
get_headlines() {
    url=$1
    source_color=$2

    echo "Fetching headlines from $url..."

    # Use curl to fetch the headlines with AWK
    headlines=$(curl -s "$url" | grep -E '<title>' | awk -F '<title>|</title>' 'NF>1{print $2}')

    # Display headlines with source in the paired color
    IFS=$'\n'
    for headline in $headlines; do
        print_colored "$source_color" "Source: $url - Headline: $headline"
    done
}

# Help function
print_help() {
   echo "Usage: hirfeldolgozas_bence_czifrik.sh [-h] <www.bbc.com> <red> <www.theguardian.com/europe> <blue> <nytimes.com/international> <green> <https://www.france24.com/en/> <yellow>"
    echo
    echo "Description:"
    echo "Fetches headlines from the 4 URLs and displays them in the paired color"
    echo
    echo "Options:"
    echo "  -h, --help     Show this help sheet"
    echo
    echo "Arguments:"
    echo --url "https://www.bbc.com" 			--color "red"  
    echo --url "https://www.theguardian.com/europe" 	--color "blue" 
    echo --url "nytimes.com/international" 		--color "green"
    echo --url "https://www.france24.com/en/" 		--color "yellow"
}

# Check for help option
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    print_help
    exit 0
fi

# Main script
get_headlines "https://feeds.bbci.co.uk/news/rss.xml" "red"
get_headlines "https://www.theguardian.com/world/rss" "blue"
get_headlines "https://rss.nytimes.com/services/xml/rss/nyt/World.xml" "green"
get_headlines "https://www.france24.com/en/rss" "yellow"
