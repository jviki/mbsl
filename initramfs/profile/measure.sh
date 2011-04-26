#! /bin/sh

wait_for_input()
{
	old_tty_settings="`stty -g`"
	stty -icanon
	echo $1 >&2
	head -c1
	stty "$old_tty_settings"
}

iperf_start()
{
	date | tee -a iperf.$1.log >&2
	iperf -s 2>&1 >> iperf.$1.log 
	echo >> iperf.$1.log
}

iperf_stop()
{
	pkill iperf
}

measure_start()
{
	wait_for_input "Press any key to start the measure '$1'"
	echo "Starting in 2 seconds..." >&2
	sleep 2
	echo "Started" >&2
	readprofile -r
}

measure_stop()
{
	wait_for_input "Press any key to dump the results of '$1'"
	cat /proc/profile > profile.$1.buff
}

###################

echo "Name the measure:" >&2
name="`head -n1`"

iperf_start "$name" &
measure_start "$name"
measure_stop "$name"
iperf_stop

ls -lh *.$name.*

