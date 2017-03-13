#!/bin/bash

if [ -z $1 ]; then
	echo "usage: $0 <log file>"
	exit
fi

output=${1//.*/.csv}
echo "input:$1, output:$output"

awk -F: '{print $2}' $1 | awk '{print $1}' > ./$output
