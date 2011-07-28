#! /bin/sh

patch_srcdir="$1"
shift
patch_dstdir="$1"
shift
patch_name="$1"
shift

patch_base="$patch_srcdir/$patch_name"
patch_file="$patch_base.patch"
patch_doc="$patch_base.doc"

echo "[PATCH] Applying patch $patch_name" > /dev/stderr

if [ -f "$patch_doc" ]; then
	echo -n "* " > /dev/stderr
	cat "$patch_doc"   > /dev/stderr
fi

patch -cb -p0 -d "$patch_dstdir" --verbose -i "$patch_file"

