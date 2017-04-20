#!/bin/bash

cd lmbench-3.0-a9/bin/x86_64-linux-gnu

function stream_test() {
        echo ": streamv2core0"
        numactl -C 0 --localalloc ./stream -v 1 -M 200M -P 1
		sleep 10
        numactl -C 0 --localalloc ./stream -v 2 -M 200M -P 1
		sleep 10
        echo ": streamv2core0-3"
        numactl -C 0-3 --localalloc ./stream -v 1 -M 200M -P 4
		sleep 10
        numactl -C 0-3 --localalloc ./stream -v 2 -M 200M -P 4
		sleep 10
        echo ": streamv2core0-23"
        numactl --cpunodebind=0 --localalloc ./stream -v 1 -M 200M -P 24
		sleep 10
        numactl --cpunodebind=0 --localalloc ./stream -v 2 -M 200M -P 24
		sleep 10
        echo ": streamv2core0-47"
        numactl --cpunodebind=0,1,2,3 --localalloc ./stream -v 1 -M 200M -P 48
		sleep 10
        numactl --cpunodebind=0,1,2,3 --localalloc ./stream -v 2 -M 200M -P 48
		sleep 10
}

for ((i=0;i<4;i++));do
	stream_test
done
