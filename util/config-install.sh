#! /bin/sh

###
# Installs selected kernel/busybox/other config file to used
# by the build system. Target config file name is .config to be
# compatible with Linux kernel and Busybox build systems. When
# there already exists one, it is backed up (with extension: bak).
#
# Allows to overwrite some lines in the resulted copy. Just path a
# pair (or any number of pairs) of strings to the command. The first
# item from the pair is key (eg. CONFIG_CROSS_COMPILE) and the second
# one its new value (eg. microblaze-unknown-linux-gnu-).
# Then the source is transformed from:
#   CONFIG_CROSS_COMPILE="anything here"
# to
#   CONFIG_CROSS_COMPILE="microblaze-unknown-linux-gnu-"
#
# All logging is prefixed by "[CONFIG-INSTALL]" string.
#
# Usage: ./config-install <path-to-file.config> <path-to-dest-dir> [<overwrite-what> <overwrite-by>]*
###

config_src="$1"
shift
config_dst="$1"
shift

config_target="$config_dst/.config"

if [ ! -d "$config_dst" ]; then
    echo "[CONFIG-INSTALL] Missing directory $config_dst" > /dev/stderr
    exit 1
fi

if [ -f "$config_target" ]; then
    echo "[CONFIG-INSTALL] Backup of $config_target" > /dev/stderr
    cp -v "$config_target" "$config_target.bak"
fi

copy_raw()
{
	echo "[CONFIG-INSTALL] `basename $config_src`" > /dev/stderr
	cp -v "$config_src" "$config_target"
}

copy_with_filtering()
{
	filter=""

	# This should never happen:
	if [ -z "$pair_first" ]; then
		copy_raw
		exit 0
	fi

	if [ -z "$pair_second" ]; then
		echo "[CONFIG-INSTALL] Missing second part of substitute pair: `basename $config_src` ($pair_first)" > /dev/stderr
		exit 1
	fi

	while [ -n "$pair_first" -a -n "$pair_second" ]; do
		filter="$filter -e s/^\($pair_first\).*\$/\\1=\"$pair_second\"/;"

		if [ -n "$1" ]; then
			pair_first="$1"
			shift
		else
			break
		fi

		if [ -z "$1" ]; then
			echo "[CONFIG-INSTALL] Missing second part of substitute pair: `basename $config_src` ($pair_first)" > /dev/stderr
			exit 1
		fi
		pair_second="$1"
		shift
	done

	echo "[CONFIG-INSTALL] `basename $config_src` with filtering" > /dev/stderr
	#echo "[DEBUG] $filter" > /dev/stderr
	sed $filter "$config_src" > "$config_target"
}

###############

if [ -z "$1" ]; then
	copy_raw
else
	pair_first="$1"
	shift
	pair_second="$1"
	shift

	copy_with_filtering "$@"
fi
