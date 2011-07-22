#! /bin/sh

download_dir="$1"
shift
download_name="$1"
shift
download_url="$1"
shift

download_target="$download_dir/$download_name"

if [ ! -f "$download_target" ]; then
    echo "[DOWNLOAD] Processing $download_name" > /dev/stderr
    wget "$@" "$download_url" -O "$download_target"
else
    echo "[DOWNLOAD] Skipping $download_name" > /dev/stderr
fi

