##
## MBSL Main Makefile
##

MBSL_HOME  ?= $(PWD)

#################

CONFIG ?= default
include $(CONFIG).cfg

#################

SRC_DIR    ?= src
TMP_DIR    ?= tmp
CFG_DIR    ?= config
TOOLS_DIR  ?= tools
PKGS_DIR   ?= pkgs
PATCHS_DIR ?= patchs
DTS_DIR    ?= dts
UTIL_DIR   ?= util

#################

SRC_PATH    := $(MBSL_HOME)/$(SRC_DIR)
TMP_PATH    := $(MBSL_HOME)/$(TMP_DIR)
CFG_PATH    := $(MBSL_HOME)/$(CFG_DIR)
TOOLS_PATH  := $(MBSL_HOME)/$(TOOLS_DIR)
PKGS_PATH   := $(MBSL_HOME)/$(PKGS_DIR)
PATCHS_PATH := $(MBSL_HOME)/$(PATCHS_DIR)
DTS_PATH    := $(MBSL_HOME)/$(DTS_DIR)
UTIL_PATH   := $(MBSL_HOME)/$(UTIL_DIR)

#################

Q ?= @

#################

all: help-main
download: download-init download-body download-fini
configure: configure-init configure-body configure-fini
build: build-init build-body build-fini
install: install-init install-body install-fini
clean: clean-init clean-body clean-fini
distclean: distclean-init distclean-body distclean-fini

version: current-version
help: help-advanced

#################

include Makefile.version
include Makefile.help

include Makefile.download
include Makefile.configure
include Makefile.build
include Makefile.install
include Makefile.clean
include Makefile.distclean

include Makefile.pkgs

#################
