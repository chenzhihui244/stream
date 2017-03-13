#!/bin/sh

cd lmbench-3.0-a9/bin/lmbench

for (( i=0;i<10;i++ )); do
	echo ": streamv1core0"
	numactl -C 0 -m 0 ./stream -v 1 -P 1 -N 5 -W 5 -M 1000M
	sleep 10
	echo ": streamv1core0-31"
	numactl -C 0-31 -m 0-1 ./stream -v 1 -P 32 -N 5 -W 5 -M 1000M
	sleep 10
	echo ": streamv1core0-63"
	./stream -v 1 -P 64 -N 5 -W 5 -M 1000M
	sleep 10

	echo ": streamv2core0"
	numactl -C 0 -m 0 ./stream -v 2 -P 1 -N 5 -W 5 -M 1000M
	sleep 10
	echo ": streamv2core0-31"
	numactl -C 0-31 -m 0-1 ./stream -v 2 -P 32 -N 5 -W 5 -M 1000M
	sleep 10
	echo ": streamv2core0-63"
	./stream -v 2 -P 64 -N 5 -W 5 -M 1000M
done
