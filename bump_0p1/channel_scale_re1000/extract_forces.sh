#!/bin/bash

# Path to the forces.dat file
input_file="postProcessing/forces/0/forces.dat"
output_file="extracted_forces.dat"

# Check if the input file exists
if [[ ! -f "$input_file" ]]; then
  echo "Error: $input_file not found."
  exit 1
fi

# Create or clear the output file
echo -e "Time\tViscous_Force\tPressure_Force" > "$output_file"

# Read the input file line by line
while IFS= read -r line
do
  # Skip comments and empty lines
  if [[ "$line" =~ ^# ]] || [[ -z "$line" ]]; then
    continue
  fi

  # Clean the line by removing brackets and commas
  clean_line=$(echo "$line" | tr -d '()' | tr ',' ' ')

  # Extract data from the cleaned line
  time=$(echo "$clean_line" | awk '{print $1}')
  pressure_force_x=$(echo "$clean_line" | awk '{print $2}')
  pressure_force_y=$(echo "$clean_line" | awk '{print $3}')
  pressure_force_z=$(echo "$clean_line" | awk '{print $4}')
  viscous_force_x=$(echo "$clean_line" | awk '{print $5}')
  viscous_force_y=$(echo "$clean_line" | awk '{print $6}')
  viscous_force_z=$(echo "$clean_line" | awk '{print $7}')

  # Sum the force components (simplified for a single direction, typically x)
  pressure_force=$pressure_force_x
  viscous_force=$viscous_force_x

  # Write the extracted data to the output file
  echo -e "$time\t$viscous_force\t$pressure_force" >> "$output_file"

done < "$input_file"

echo "Forces extracted and written to $output_file."

