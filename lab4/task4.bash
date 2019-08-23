#!/bin/bash

loop="./loop.bash"

nice -n 20 $loop &
pid1=$!

nice -n 1 $loop &
pid2=$!

sleep 10
kill $pid1
kill $pid2