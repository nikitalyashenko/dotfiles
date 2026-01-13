#!/bin/bash

# Get only the actual temperature (first temperature value after Composite:)
temps=$(sensors 2>/dev/null | grep "Composite:" | awk '{print $2}' | sed 's/[+°C]//g' | awk '{printf "%.0f° ", $1}')

if [ -z "$temps" ]; then
    echo "N/A"
else
    # Remove trailing space
    temps=${temps% }
    echo "$temps"
fi
