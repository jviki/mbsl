#! /bin/sh

###
# Wrapper to call patch utility. Applies the patch and
# if there exists a documentation for the patch it is
# printed to console. The patch name is given without
# extension. Extension is always 'patch'. Documentation
# can be stored in file of the same name with different
# extension - 'doc'.
#
# Logging is prefixed by "[PATCH]" string. 
# Documentation prints are prefixed with "*" string.
#
# Usage: ./patch.sh <src-dir> <dst-dir> <name>
#
#   <src-dir> dir where patch is located
#   <dst-dir> dir where the patch will be applied
#   <name>    name of the patch without extension
###

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

