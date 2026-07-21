# ============================================================
# Quit any currently running simulation before starting fresh
# ============================================================
quit -sim

# ============================================================
# Create the "work" library — this is where all compiled
# design units (modules, interfaces, classes) will be stored
# ============================================================
vlib work

# ============================================================
# Map the logical library name "work" to its physical folder
# (required so the tools know where "work" actually points to)
# ============================================================
vmap work work

# ============================================================
# Store the path to the UVM-1.2 source library in a variable,
# so we don't have to repeat the full path every time.
# Used later with +incdir so `include "uvm_macros.svh"` and
# other UVM headers can be found during compilation.
# ============================================================
set UVM_SRC "C:/questasim64_10.7c/verilog_src/uvm-1.2/src"

# ============================================================
# Compile the top-level file spi_top.sv.
# spi_top.sv internally `includes all other design/testbench
# files (interface, seq_item, sequencer, driver, agent, env,
# seq1, test) — so compiling just this one file compiles
# everything in the correct order.
# +incdir+$UVM_SRC lets the compiler locate uvm_macros.svh
# uvm_pkg itself is NOT compiled manually — QuestaSim
# automatically uses its own precompiled built-in UVM-1.2
# package during this step.
# ============================================================
vlog -sv +incdir+$UVM_SRC spi_top.sv

# ============================================================
# Load the compiled design into the simulator and elaborate
# the top module "spi_top".
#
# -voptargs="+acc"  : keeps full visibility into all signals
#                     (needed for waveform viewing/debugging)
#
# -sv_lib "...uvm_dpi" : loads the precompiled uvm_dpi.dll,
#                     which provides the actual C-language
#                     implementations of UVM's DPI-C functions
#                     (e.g. uvm_hdl_read, uvm_dpi_get_next_arg_c).
#                     Without this, UVM's built-in package would
#                     fail at runtime with "Null foreign function
#                     pointer" errors, since those DPI functions
#                     would have no real implementation to call.
# ============================================================
vsim -voptargs="+acc" -assertdebug -sv_lib "C:/questasim64_10.7c/uvm-1.2/win64/uvm_dpi" -l debug.log work.spi_top
transcript file "./debug.log"

# ============================================================
# Open the Structure window — shows the hierarchical
# instance tree of the design (modules, classes, objects)
# ============================================================
view structure

# ============================================================
# Open the Objects window — shows signals/variables belonging
# to whichever scope is currently selected in Structure view
# ============================================================
view objects

# ============================================================
# Open the Waveform window, where signal activity over time
# will be plotted once the simulation runs
# ============================================================
view wave

# ============================================================
# Open the Assertions pane so pass/fail counts for every
# property in spi_assertions are visible alongside the wave
# ============================================================
view assertions

add wave /spi_top/intf_h/a_miso_tristate
add wave /spi_top/intf_h/a_sclk_stable
add wave /spi_top/intf_h/a_rxdv_pulse
add wave /spi_top/intf_h/a_rxdv_needs_txn
add wave /spi_top/intf_h/a_tx_en_pulse
add wave /spi_top/intf_h/a_reset_idle
add wave /spi_top/intf_h/a_mosi_known

# ============================================================
# Add only the top-level clock signal (declared inside spi_top,
# outside the interface) into the waveform viewer
# ============================================================
#add wave /spi_top/clk

# ============================================================
# Add only the top-level reset signal (declared inside spi_top,
# outside the interface) into the waveform viewer
# ============================================================
#add wave /spi_top/rst_n

# ============================================================
# Add ONLY the SPI interface signals (recursively, -r) from
# intf_h — this includes sclk, miso, mosi, ss_n, tx_data,
# rx_data, and the clocking block signals (drv_cb/mon_cb).
# UVM internal signals (uvm_pkg::*) and other testbench
# clutter are intentionally excluded, so the waveform only
# shows the actual SPI protocol activity for easy debugging.
# ============================================================
add wave /spi_top/intf_h/*
add wave -r /spi_top/intf_h/tx_d
add wave -r /spi_top/intf_h/rx_d


# ============================================================
# Run the simulation until it finishes naturally
# (i.e. until $finish is called, or no more events remain)
# ============================================================
run -all
