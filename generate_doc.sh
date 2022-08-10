#!/bin/bash

# check if first argument is set
if [ -z "$1" ]; then
    echo "Please provide a path to the module folder."
    exit 1
fi

# check if the first argument is a directory
if [ ! -d "$1" ]; then
    echo "The first argument is not a directory."
    exit 1
fi

sed -i '/## Requirements/Q' $1/README.md

# add the generated output
terraform-docs markdown $1/ >> $1/README.md