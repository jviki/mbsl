#
# Default distro configuration
#

PKGS   ?= iptables iperf-2.0.5 busybox
TOOLS  ?= microblaze-v2.0
KERNEL ?= xlnx-26
DTS    ?= default.dts
RAMFS  ?= $(INITRAMFS_DIR) $(RAMFS_SRC)/basic $(RAMFS_SRC)/basic.initramfs $(RAMFS_SRC)/profile

configure: kconfig_profile bbconfig_default