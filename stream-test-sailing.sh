#!/bin/bash

cd lmbench-3.0-a9/bin/lmbench

function stream_test_64core() {
        echo ": streamv2core0-63"
        numactl --cpunodebind=0,1,2,3 --localalloc ./stream -v 1 -M 200M -P 64
		sleep 10
        numactl --cpunodebind=0,1,2,3 --localalloc ./stream -v 2 -M 200M -P 64
		sleep 10
}

for ((i=0;i<10;i++));do
	stream_test_64core
done
