#!/bin/bash

cd lmbench-3.0-a9/bin/lmbench

function stream_cpunode_memnode_1core()
{
	if [ $# -lt 2 ];then
		echo "$0 <cpu node> <mem node>"
		return
	fi
	#cpunode=$1
	(( core = $1 * 16 ))
	memnode=$2

	echo "cpunode: $core-$memnode"
	for ((k=0;k<10;k++));do
		numactl -C $core --membind=$memnode ./stream -v 1 -M 200M -P 1
		sleep 1
		numactl -C $core --membind=$memnode ./stream -v 2 -M 200M -P 1
		sleep 1
	done
}

function stream_cpunode_memnode_1die()
{
	if [ $# -lt 2 ];then
		echo "$0 <cpu node> <mem node>"
		return
	fi
	cpunode=$1
	memnode=$2

	echo "cpunode: $cpunode-$memnode"
	for ((k=0;k<10;k++));do
		numactl --cpunodebind=$cpunode --membind=$memnode ./stream -v 1 -M 200M -P 16
		sleep 1
		numactl --cpunodebind=$cpunode --membind=$memnode ./stream -v 2 -M 200M -P 16
		sleep 1
	done
}

#export LMBENCH_SCHED=BALANCED
for ((i=0;i<4;i++));do
	for ((j=0;j<4;j++));do
		#stream_cpunode_memnode_1die $i $j
		stream_cpunode_memnode_1core $i $j
	done
done
