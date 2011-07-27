#! /bin/sh

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
