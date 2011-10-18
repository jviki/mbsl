#! /usr/bin/awk -f

BEGIN {
	os = 0
	os_tty  = "ttyUL0,9600"
	os_root = "/dev/ram"
	os_ip   = "192.168.0.2"
}

## detect the begin of OS section, and comment it:
/^BEGIN OS/ {
	os = 1
	os_console = 0
	print "# Commented on " strftime()
	print "#" $0
	next
}

## detect the end of OS section and comment it:
/^END/ {
	if(os == 1) {
		print "#" $0 "\n"
		print_os()
		if(LOG > 0)
			print_os("/dev/stderr")

		os = 0
		next
	}
}

## comment the OS section parameters:
/PARAMETER/ {
	if($2 == "STDOUT") {
		eqpos = index($0, "=");

		if(eqpos > 0) {
			os_console = substr($0, eqpos + 1);
		}
	}

	if(os) {
		print "#" $0
		next
	}
}

## every other line:
{
	print
}

## new OS section:
function print_os(out)
{
	if(!out)
		out = "/dev/stdout"

	mss_begin("OS", out)
	mss_param("OS_NAME", "device-tree", out)
	mss_param("OS_VER", "0.00.x", out)
	mss_param("PROC_INSTANCE", "microblaze_0", out)
	mss_param("bootargs", "console=" os_tty " root=" os_root " ip=" os_ip, out)
	mss_param("console device", os_console, out, !os_console)
	mss_end(out)		
}

function mss_begin(what, out)
{
	print "BEGIN " what >> out
}

function mss_param(name, value, out, comment)
{
	if(comment)
		print "# PARAMETER " name " = " value >> out
	else
		print " PARAMETER " name " = " value >> out
}

function mss_end(out)
{
	print "END" >> out
}
