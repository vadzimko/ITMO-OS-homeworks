#!/bin/bash
echo $$ > .pid

op='+'
val=1

termination() {
	echo "Terminating..."
	exit 0
}

change_to_sum() {
	op='+'
}

change_to_mul() {
	op='*'
}

trap 'termination' SIGTERM
trap 'change_to_sum' USR1
trap 'change_to_mul' USR2

while true; do
    let "val = val $op 2"
    echo $val
    sleep 1
done