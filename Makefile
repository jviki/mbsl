#
# Makefile
#
# Downloads software, builds, etc.
#

INITRAMFS  ?= $(PWD)/build/initramfs
SW_SRC     ?= $(PWD)/src
TOOLS_DIR  ?= $(PWD)/tools
PATCHS_DIR ?= $(PWD)/patchs
DTS_FILE   ?= $(PWD)/src/xilinx.dts
Q          ?= @

##############################

CONFIG ?= default
include Makefile.cfg.$(CONFIG)

##############################

all: help
patch: patch-kernel patch-software patch-tools
configure: configure-kernel configure-software
download: download-prepare download-tools download-pkgs download-kernel
build: build-image
help: help-main

##############################

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

