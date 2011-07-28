##
## MBSL Main Makefile
##

#################
# General targets

all: help-main
download: download-init download-body download-fini
configure: configure-init configure-body configure-fini
build: build-init build-body build-fini
install: install-init install-body install-fini
clean: clean-init clean-body clean-fini
distclean: distclean-init distclean-body distclean-fini

boot: boot-design boot-image

version: current-version
help: help-advanced

#################
# Path to distribution home

MBSL_HOME  ?= $(PWD)

#################
# Used distribution configuration

CONFIG ?= default
include Makefile.default
include $(CONFIG).cfg

#################
# General directory names (relative)

SRC_DIR    ?= src
TMP_DIR    ?= tmp
CFG_DIR    ?= config
TOOLS_DIR  ?= tools
PKGS_DIR   ?= pkgs
PATCHS_DIR ?= patchs
DTS_DIR    ?= dts
UTIL_DIR   ?= util
INITRAMFS_DIR ?= initramfs
GENRAMFS_DIR ?= gen-ramfs
DESIGN_DIR ?= design

#################
# General directory paths (absolute)

SRC_PATH    := $(MBSL_HOME)/$(SRC_DIR)
TMP_PATH    := $(MBSL_HOME)/$(TMP_DIR)
CFG_PATH    := $(MBSL_HOME)/$(CFG_DIR)
TOOLS_PATH  := $(MBSL_HOME)/$(TOOLS_DIR)
PKGS_PATH   := $(MBSL_HOME)/$(PKGS_DIR)
PATCHS_PATH := $(MBSL_HOME)/$(PATCHS_DIR)
DTS_PATH    := $(MBSL_HOME)/$(DTS_DIR)
UTIL_PATH   := $(MBSL_HOME)/$(UTIL_DIR)
INITRAMFS_PATH := $(MBSL_HOME)/$(INITRAMFS_DIR)
GENRAMFS_PATH  := $(MBSL_HOME)/$(GENRAMFS_DIR)
DESIGN_PATH := $(MBSL_HOME)/$(DESIGN_DIR)

#################
# Common options

Q ?= @

#################
# Includes

include Makefile.version
include Makefile.help

include Makefile.path
include Makefile.initramfs
include Makefile.xilinx

include Makefile.download
include Makefile.patch
include Makefile.configure
include Makefile.build
include Makefile.install
include Makefile.clean
include Makefile.distclean

include Makefile.pkgs

