#!/usr/bin/env bash

gcc main.c -o main

function start
{
	n = $1
	time ./main $n &
	pid=$!
	mask=0
	while [ "`cat /proc/$pid/cmdline`" != "./main" ]; do
		taskset -p $((mask+1)) $pid > /dev/null
		mask=$((mask^1))
	done
	time ./main $n
}

start 100
start 500
start 1000