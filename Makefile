#
# Makefile
#
# Downloads software, builds, etc.
#

##############################

CONFIG ?= default
include Makefile.cfg.$(CONFIG)

##############################

SW_SRC         ?= $(PWD)/src
TOOLS_DIR      ?= $(PWD)/tools
PATCHS_DIR     ?= $(PWD)/patchs
RAMFS_SRC      ?= $(PWD)/initramfs
INITRAMFS_DIR  ?= $(KSRC)/initramfs
CONFIGS_DIR    ?= $(PWD)/config
DTS_DIR        ?= $(PWD)/dts
HW_DESIGN_DIR  ?= $(PWD)/design
KCONFIG_OUTPUT ?= new.kconfig
Q              ?= @

##############################

all: help-main
patch: patch-init
	@echo "Finished $@"
configure: configure-init
	@echo "Finished $@"
download: download-init
	@echo "Finished $@"
build: build-init
	@echo "Finished $@"
install: install-init
	@echo "Finished $@"
clean: clean-init
	@echo "Finished"
distclean: distclean-init
	@echo "Finished $@"

#boot: boot-image
#save-kconfig: save-current-kconfig
help: help-advanced

##############################

include Makefile.pkgs
include Makefile.main
include Makefile.git
include Makefile.wget
include Makefile.xilinx

##############################

help-main:
	@echo "Targets:"
	@echo "  download               ... downloads all software and kernel sources from Internet"
	@echo "  patch                  ... patchs all selected packages if possible"
	@echo "  kconfig_<name>         ... copies the kernel configuration <name> to kernel dir as .config"
	@echo "  bbconfig_<name>        ... copies the busybox configuration <name> to busybox dir as .config"
	@echo "  configure              ... configures all selected packages and possibly kernel and busybox"
	@echo "  build                  ... builds software and kernel"
	@echo "  install                ... installs software into the initramfs and then builds bootable image"
	@echo "  boot-design            ... boots the selected design into FPGA"
	@echo "  boot                   ... boots the kernel image into the running design"
	@echo "  clean                  ... calls clean on all selected packages"
	@echo "  distclean              ... calls distclean on all selected packages and possibly mrproper on kernel"
	@echo "  save-current-kconfig   ... saves current kernel .config in config/ dir as new.kconfig"
	@echo "  help                   ... advanced help"

help-advanced: help-main
	@echo "Useful internal targets:"
	@echo "  build-kernel           ... rebuilds the kernel image"
	@echo "  install-software       ... reinstalls software into initramfs"
	@echo "  kernel-with-system.map ... copies the System.map into initramfs"
	@echo "  prepare-dts            ... copies selected DTS file into kernel dir hierarchy"
	@echo "  copy-image             ... copies generated kernel image to root of the distro"
	@echo "Variables:"
	@echo "  CONFIG                 ... used configuration of distro - constructs: Makefile.cfg.<CONFIG>"
	@echo "  SW_SRC                 ... where to look for software sources"
	@echo "  TOOLS_DIR              ... where to look for tools"
	@echo "  RAMFS_SRC              ... where to look for initramfs source files"
	@echo "  INITRAMFS_SRC          ... where to place generated files to be included in initramfs"
	@echo "  HW_DESIGN_DIR          ... where to look for design bit streams"
	@echo "  PATCHS_DIR             ... where to look for patchs"
	@echo "  CONFIGS_DIR            ... where to look for kconfig and bbconfig files"
	@echo "  DTS                    ... name of used DTS file"
	@echo "  Q                      ... quite for commands in Makefile, default: @"
	@echo "  KCONFIG_OUTPUT         ... name of the new kernel config when running save-current-kconfig"
	@echo "Hints:"
	@echo "  $$ make configure-kernel KERNEL_CONFIG=menuconfig"
	@echo "  $$ make configure-busybox BUSYBOX_CONFIG=menuconfig"

