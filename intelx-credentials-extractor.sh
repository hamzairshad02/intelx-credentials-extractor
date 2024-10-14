#!/bin/bash

read -p "Enter the domain (e.g., domain.com): " domain

echo "Running grep search for domain: $domain"
grep -rh "$domain" > Results/grep_results.txt
echo "Raw grep results saved in Results/grep_results.txt"

echo "Processing grep results..."
grep -Eo "[a-zA-Z0-9._%+-]+@$domain(:[a-zA-Z0-9._%+-]+)?" < Results/grep_results.txt > Results/raw_results.txt

echo "Removing duplicates..."
sort -u Results/raw_results.txt > Results/unique_results.txt

mkdir -p Results

echo "Email/Username,Password" > Results/output.csv
echo "" > Results/output.txt  # Empty the .txt file first, then add results

echo "" > Results/username.txt
echo "" > Results/password.txt
echo "" > Results/creds.txt

echo "Processing unique results into CSV, TXT, username.txt, password.txt, and creds.txt files..."
line_count=$(wc -l < Results/unique_results.txt)
counter=0

while IFS= read -r line; do
    # Update progress
    counter=$((counter + 1))
    percent=$(( (counter * 100) / line_count ))
    echo -ne "Processing: $percent% complete\r"

    # Check if the line contains a password (i.e., contains a colon)
    if [[ $line == *":"* ]]; then
        # Split the line by colon (email and password)
        email=$(echo "$line" | cut -d':' -f1)
        password=$(echo "$line" | cut -d':' -f2)

        # Append to both the .csv and .txt files
        echo "$email,$password" >> Results/output.csv
        echo "$email:$password" >> Results/output.txt

        # Add the email/username to username.txt
        echo "$email" >> Results/username.txt

        # Add the password to password.txt
        echo "$password" >> Results/password.txt

        # Add the full credentials (email:password) to creds.txt
        echo "$line" >> Results/creds.txt
    else
        # If no password, include it in both the .csv and .txt with a blank password
        email="$line"
        password=""
        echo "$email,$password" >> Results/output.csv
        echo "$email" >> Results/output.txt  # Just the email, no colon

        # Add the email/username to username.txt
        echo "$email" >> Results/username.txt
    fi
done < Results/unique_results.txt

echo "Cleaning up output.txt..."
sed -i '1d' Results/output.txt  # Remove the first line (header)

echo "Removing duplicates from username.txt..."
sort -u Results/username.txt -o Results/username.txt

rm Results/raw_results.txt Results/unique_results.txt

echo -e "\nProcessing complete! The results are saved in the 'Results' folder."
