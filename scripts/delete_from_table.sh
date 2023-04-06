awk -v id="3" -F: '$1 != id' file.txt > tmp.txt && mv tmp.txt file.txt

