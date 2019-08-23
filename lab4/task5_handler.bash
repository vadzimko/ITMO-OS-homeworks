#!/bin/bash

op='+'
val=1

(tail -f mypipe) | while read line; do
	case "$line" in
		'*') op='*' ;;
		'+') op='+' ;;
		"QUIT")
			echo $val
			echo "Stopping handler.."
			killall tail
			exit 0
		    ;;
		[0-9-])
		    let "val=val $op line"
		    echo $val
		    ;;
		*)
			echo "Invalid argument"
			killall tail
			exit 1
			;;
	esac
done