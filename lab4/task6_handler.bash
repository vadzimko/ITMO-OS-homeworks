#!/bin/bash
echo $$ > .pid

op='+'
val=1

termination() {
	echo "Terminating..."
	exit 0
}
trap 'termination' SIGTERM

while true; do
    let "val = val $op 1"
    echo $val
    sleep 1
done