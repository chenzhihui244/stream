#!/bin/bash

cd lmbench-3.0-a9/bin/lmbench

function stream_cpunode_memnode()
{
	if [ $# -lt 2 ];then
		echo "$0 <cpu node> <mem node>"
		return
	fi
	cpunode=$1
	memnode=$2

	echo "cpunode: $cpunode-$memnode"
	for ((k=0;k<10;k++));do
		echo "cpunode: $cpunode-$memnode-$k"
		numactl --cpunodebind=$cpunode --membind=$memnode ./stream -v 1 -M 200M -P 16
		sleep 10
		numactl --cpunodebind=$cpunode --membind=$memnode ./stream -v 2 -M 200M -P 16
		sleep 10
	done
}

export LMBENCH_SCHED=BALANCED
for ((i=0;i<4;i++));do
	for ((j=0;j<4;j++));do
		stream_cpunode_memnode $i $j
	done
done
