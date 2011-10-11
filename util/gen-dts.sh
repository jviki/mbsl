#! /bin/sh

dts_generate()
{
	tmp_dir="$1"
	shift
	bsp_dir="$1"
	shift
	processor="$1"
	shift
	mhs_file="$1"
	shift
	mss_file="$1"
	shift
	fpga_type="$1"
	shift
	dts_src="$1"
	shift
	dts_dst="$1"
	shift

	echo "[DTS-GEN] Generating DTS file ($fpga_type, $processor, $bsp_dir)" > /dev/stderr

	check=`grep '^[^#]*PARAMETER.*OS.*standalone' $mss_file | wc -l`
	if [ $check != 0 ]; then
		echo "[DTS-GEN] The MSS file $mss_file seems to be incorrect (OS standalone)" > /dev/stderr
		sleep 2
	fi

	mkdir -p "$tmp_dir"
	libgen -od "$tmp_dir" -lp "$bsp_dir" -mhs "$mhs_file" -p "$fpga_type" -pe "$processor" "$mss_file"
	
	if [ "$?" != "0" ]; then
		exit 1
	fi

	cp "$dts_src" "$dts_dst"
#	rm -Rf "$tmp_dir"
	ls -lh "$dts_dst"
}

dts_generate "$@"
