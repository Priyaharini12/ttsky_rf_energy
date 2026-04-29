# Makefile for Tiny Tapeout cocotb simulation

SIM ?= icarus
TOPLEVEL_LANG ?= verilog

SRC_DIR = $(PWD)/../src

# RTL sources (ALL your modules)
VERILOG_SOURCES = $(shell find $(SRC_DIR) -name "*.v")

# Top module (IMPORTANT)
TOPLEVEL = tt_um_rf_energy_harvesting

# Python test module (test/test.py)
MODULE = test

# Cocotb makefile
include $(shell cocotb-config --makefiles)/Makefile.sim
