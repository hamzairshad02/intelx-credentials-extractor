#!/bin/bash

read -p "Enter the domain (e.g., domain.com): " domain

mkdir -p Results

echo "Running grep search for domain: $domain"
grep -rh "$domain" > Results/grep_results.txt
echo "Raw grep results saved in Results/grep_results.txt"

echo "Processing grep results..."
grep -Eo "[a-zA-Z0-9._%+-]+@$domain(:[a-zA-Z0-9._%+-]+)?" < Results/grep_results.txt > Results/raw_results.txt

echo "Removing duplicates..."
sort -u Results/raw_results.txt > Results/unique_results.txt

echo "Email/Username,Password" > Results/output.csv
echo "" > Results/output.txt

echo "" > Results/username.txt
echo "" > Results/password.txt
echo "" > Results/creds.txt

echo "Processing unique results into CSV, TXT, username.txt, password.txt, and creds.txt files..."
line_count=$(wc -l < Results/unique_results.txt)
counter=0

while IFS= read -r line; do
    counter=$((counter + 1))
    percent=$(( (counter * 100) / line_count ))
    echo -ne "Processing: $percent% complete\r"

    if [[ $line == *":"* ]]; then
        email=$(echo "$line" | cut -d':' -f1)
        password=$(echo "$line" | cut -d':' -f2)

        echo "$email,$password" >> Results/output.csv
        echo "$email:$password" >> Results/output.txt

        echo "$email" >> Results/username.txt

        echo "$password" >> Results/password.txt

        echo "$line" >> Results/creds.txt
    else
        email="$line"
        password=""
        echo "$email,$password" >> Results/output.csv
        echo "$email" >> Results/output.txt 

        
        echo "$email" >> Results/username.txt
    fi
done < Results/unique_results.txt

echo "Cleaning up output.txt..."
sed -i '1d' Results/output.txt 

echo "Removing duplicates from username.txt..."
sort -u Results/username.txt -o Results/username.txt

rm Results/raw_results.txt Results/unique_results.txt

echo -e "\nProcessing complete! The results are saved in the 'Results' folder."
