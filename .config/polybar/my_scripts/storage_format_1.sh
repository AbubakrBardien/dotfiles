#!/bin/bash

output="$(df -h / --output="avail" | awk "NR==2") Free ("

perc_used=$(df -h / --output="pcent" | awk "NR==2")
perc_used_val=${perc_used%?}
perc_free=$((100 - perc_used_val))

output="$output$perc_free%)"

echo $output