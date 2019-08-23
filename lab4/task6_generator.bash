#!/bin/bash

while true; do
	read line
	if [[ $line == "TERM" ]]; then
		kill $(cat .pid)
		exit 0
	fi
done