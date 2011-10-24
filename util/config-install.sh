#! /bin/sh

###
# Installs selected kernel/busybox/other config file to used
# by the build system. Target config file name is .config to be
# compatible with Linux kernel and Busybox build systems. When
# there already exists one, it is backed up (with extension: bak).
#
# All logging is prefixed by "[CONFIG-INSTALL]" string.
#
# Usage: ./config-install <path-to-file.config> <path-to-dest-dir>
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
    cp "$config_target" "$config_target.bak"
fi

echo "[CONFIG-INSTALL] `basename $config_src`" > /dev/stderr
cp "$config_src" "$config_target"
