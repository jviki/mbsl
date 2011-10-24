#! /usr/bin/awk -f

/^BEGIN/ {
	name = $2
	ADDR_SPACE = 0
}

/^[ \t]*PARAMETER/ {
	if($1 == "")
		first = 2
	else
		first = 1

	key = $(first + 1)
	value = $(first + 3)
	parameter[key] = value
}

/^END/ {
	name_print()
	detail_print()
}

function name_print()
{
	print name " " parameter["HW_VER"]
}

function detail_print()
{
	if(name == "microblaze") {
		addr_print("C_DCACHE")
		microblaze_detail()
	}
	else if(name == "xps_uartlite") {
		addr_print("C")
		uartlite_detail()
	}
	else if(name == "mpmc") {
		addr_print("C_MPMC")
		mpmc_detail()
	}
	else {
		addr_print("C")
	}

	for(key in parameter) 
		delete parameter[key]
}

function addr_print(prefix)
{
	if(!ADDR_SPACE)
		return

	if(parameter[prefix "_BASEADDR"]) {
		base = parameter[prefix "_BASEADDR"]
		high = parameter[prefix "_HIGHADDR"]
		print "* address space: " base " .. " high
	}
}

function mpmc_detail()
{
	print "* type: " parameter["C_MEM_TYPE"]
	print "* partno: " parameter["C_MEM_PARTNO"]
	print "* data width: " parameter["C_MEM_DATA_WIDTH"]
}

function uartlite_detail()
{
	print "* baudrate: " parameter["C_BAUDRATE"]
	print "* data bits: " parameter["C_DATA_BITS"]

	if(parameter["C_USE_PARITY"]) {
		odd = parity["C_ODD_PARITY"]

		if(odd)
			print "* parity: odd"
		else
			print "* parity: even"	
	}
}

function microblaze_detail()
{
	if(parameter["C_USE_BARREL"])
		print "* barrel shifter"
	if(parameter["C_USE_HW_MUL"]) {
		val = parameter["C_USE_HW_MUL"]
		if(val == "1")
			val = "32b"
		else if(val == "2")
			val = "64b"

		print "* multiplier (" val ")"
	}
	if(parameter["C_USE_PCMP_INSTR"])
		print "pattern comparator"
	if(parameter["C_USE_ICACHE"]) {
		size = parameter["C_CACHE_BYTE_SIZE"]
		print "* instruction cache (" size "B)"
	}
	if(parameter["C_USE_DCACHE"]) {
		size = parameter["C_DCACHE_BYTE_SIZE"]
		print "* data cache (" size "B)"
	}
	if(parameter["C_USE_MMU"]) {
		val = parameter["C_USE_MMU"]
		print "* MMU (" val ")"
	}
	if(parameter["C_PVR"]) {
		val = parameter["C_PVR"]
		print "* PVR (" val ")"
	}
	if(parameter["C_AREA_OPTIMIZED"])
		print "* area optimized"
}
