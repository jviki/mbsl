#
# Makefile
#
# Downloads software, builds, etc.
#

SW_SRC        ?= $(PWD)/src
TOOLS_DIR     ?= $(PWD)/tools
PATCHS_DIR    ?= $(PWD)/patchs
DTS_FILE      ?= $(PWD)/src/xilinx.dts
RAMFS_SRC     ?= $(PWD)/initramfs
INITRAMFS_DIR ?= $(KSRC)/initramfs
CONFIGS_DIR   ?= $(PWD)/config
DTS_DIR       ?= $(PWD)/dts
Q             ?= @

##############################

CONFIG ?= default
include Makefile.cfg.$(CONFIG)

##############################

all: help
patch: patch-kernel patch-software patch-tools
configure: configure-kernel configure-software
download: download-prepare download-tools download-pkgs download-kernel
build: build-image
clean: clean-pkgs clean-kernel
distclean: distclean-pkgs distclean-kernel
help: help-main

##############################

include Makefile.pkgs
include Makefile.main
include Makefile.git
include Makefile.wget
include Makefile.xilinx

##############################

help-main:
	@echo "Targets:"
	@echo "  download ... downloads all software and kernel"
	@echo "  build    ... builds the image for microblaze"
	@echo "  help     ... this help"

