#! /bin/sh

archive_dir="$1"
shift
archive_name="$1"
shift
archive_fmt="$1"
shift
archive_dst="$1"
archive_dstdir="`dirname $archive_dst`"
shift

archive_path="$archive_dir/$archive_name.$archive_fmt"
archive_target="$archive_dstdir"

if [ -d "$archive_dst" ]; then
    echo "[UNPACK] Skipping $archive_name" > /dev/stderr
    exit
fi

case "$archive_fmt" in
    "tar.bz2" | "tar.gz")
        echo "[UNPACK] Processing $archive_name" > /dev/stderr
        tar "$@" -xf "$archive_path" -C "$archive_target"
    ;;

    *)
        echo "[UNPACK] Unsupported format of archive: $archive_fmt" > /dev/stderr
        exit 1
    ;;
esac

