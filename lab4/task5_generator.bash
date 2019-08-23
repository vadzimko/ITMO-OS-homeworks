#!/bin/bash

while true; do
	read -r line
	echo "$line" > mypipe
	if [[ $line == "QUIT" ]]; then
		exit 0
	fi
done