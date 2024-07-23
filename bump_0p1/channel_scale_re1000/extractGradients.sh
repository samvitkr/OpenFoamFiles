#!/bin/bash

# Output file for the results
output_file="gradients_output.txt"
# Clear the output file if it exists
> $output_file

# Loop through all folders from 0.1 to 15 with an increment of 0.1
for i in $(seq 0.1 0.1 15)
do
    # Convert the current number to the folder name (remove trailing zeroes)
    folder=$(printf "%.1f" $i | sed 's/\.0$//')

    # Define the path to the momentumSourceProperties file
    file_path="$folder/uniform/momentumSourceProperties"

    # Check if the file exists
    if [ -f "$file_path" ]
    then
        # Extract the gradient value
        gradient_value=$(grep "gradient" "$file_path" | awk '{print $2}' | tr -d ';' )
        
        # Append the folder name and gradient value to the output file, separated by a tab
        echo -e "$folder\t$gradient_value" >> $output_file
    else
        echo -e "$folder\tFile not found!" >> $output_file
    fi
done


