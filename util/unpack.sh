#! /bin/sh

unpack_tmp()
{
    archive_dir="$1"
    shift
    archive_name="$1"
    shift
    archive_fmt="$1"
    shift
    
    archive_path="$archive_dir/$archive_name.$archive_fmt"

    case "$archive_fmt" in
        "tar.bz2" | "tar.gz")
            echo "[UNPACK] Processing $archive_name" > /dev/stderr
            tar "$@" -xf "$archive_path" -C "$archive_dir"
        ;;

        *)
            echo "[UNPACK] Unsupported format of archive: $archive_fmt" > /dev/stderr
            exit 1
        ;;
    esac
}

move_tmp()
{
    archive_dst="$1"
    shift
    archive_orig="$1"
    shift
    archive_dir="$1"
    shift

    mkdir -p "`dirname $archive_dst`"
    mv "$archive_dir/$archive_orig" "$archive_dst"
}

unpack_and_move()
{
    archive_dir="$1"
    shift
    archive_name="$1"
    shift
    archive_fmt="$1"
    shift
    archive_dst="$1"
    shift
    archive_orig="$1"
    shift

    if [ -d "$archive_dst" ]; then
        echo "[UNPACK] Skipping $archive_name" > /dev/stderr
        exit
    fi

    unpack_tmp "$archive_dir" "$archive_name" "$archive_fmt" "$@"
    move_tmp "$archive_dst" "$archive_orig" "$archive_dir"
}

if [ "$1" = "--tmp" ]; then
    shift
    unpack_tmp "$@"
else
    unpack_and_move "$@"
fi

