#! /bin/sh

###
# Unpack helper. Unpacks archive and then moves its root (orig)
# directory to the destination path. If --tmp option is given
# Only unpacking is made (no additional moving).
# 
# Knows how to unpack tar.bz2 and tar.gz files.
#
# All logging is prefixed by "[UNPACK]" string.
#
# Usage: ./unpack.sh <dir-with-arch> <arch-name> <arch-ext> <dst-dir> <orig-dir>
#        ./unpack.sh --tmp <dir-with-arch> <arch-name> <arch-ext>
#
#################
# Note to "orig":
#
#  example.tar.gz:
#    + example-v1_00/
#      + src/
#      + include/
#      ...
# 
#  $ tar -xf example.tar.gz
#  $ ls
#  example-v1_00/
#  ^^^^^^^^^^^^^ this is orig
#
# It is often a good idea to remove the version information...
###

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

