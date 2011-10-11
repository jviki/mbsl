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
	print "# Commented on " strftime()
	print "#" $0
	next
}

## detect the end of OS section and comment it:
/^END/ {
	if(os == 1) {
		print "#" $0 "\n"
		print_os()
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
function print_os()
{
	print "BEGIN OS"
	print " PARAMETER OS_NAME = device-tree"
	print " PARAMETER OS_VER = 0.00.x"
	print " PARAMETER PROC_INSTANCE = microblaze_0"
	print " PARAMETER bootargs = console=" os_tty " root=" os_root " ip=" os_ip
	if(os_console)
		print " PARAMETER console device = " os_console
	else
		print "# PARAMETER console device = UNKNOWN"
		
	print "END"
}

