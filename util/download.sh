#! /bin/sh

###
# Downloads the file specified by URL to a directory with
# the given name.
#
# All logging is prefixed by "[DOWNLOAD]" string.
#
# Usage ./download.sh <dest-dir> <dest-name> <src-url>
###

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

