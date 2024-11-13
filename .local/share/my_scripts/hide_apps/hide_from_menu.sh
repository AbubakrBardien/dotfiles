#!/bin/bash

while IFS= read -r line; do
	apps_to_hide+=("$line")
done < apps_to_hide.txt

# shellcheck disable=SC2164
cd /usr/share/applications/

file="${app}.desktop"

for app in "${apps_to_hide[@]}"; do
	# If file exists
	if [ -e "$file" ]; then 		
		if [[ $(tail -1 "$file") != "Hidden=true" ]]; then
			# Appends to the file, with sudo permissions
			echo -e "\nHidden=true" | sudo tee -a "$file"
		fi
	fi
done

