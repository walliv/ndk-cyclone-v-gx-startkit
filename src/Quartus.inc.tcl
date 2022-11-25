# Quartus.inc.tcl: Quartus.tcl include for DK-DEV-AGI027RES card
# Copyright (C) 2021 CESNET z. s. p. o.
# Author(s): Vladislav Valek <vladislav.valek@email.cz>
#
# SPDX-License-Identifier: BSD-3-Clause

set FIRMWARE_BASE   $env(FIRMWARE_BASE)
set COMBO_BASE      $env(COMBO_BASE)
set CARD_BASE       $env(CARD_BASE)
set OFM_PATH        $env(OFM_PATH)
set OUTPUT_NAME     $env(OUTPUT_NAME)

source $OFM_PATH/build/Quartus.inc.tcl

# Prerequisites for generated VHDL package
# set UCP_PREREQ [list $CARD_CONST $CORE_CONF $CARD_CONF [expr {[info exists APP_CONF] ? $APP_CONF : ""}]]

# ----- Default target: synthesis of the project ------------------------------
proc target_default {} {
    global SYNTH_FLAGS HIERARCHY
    SynthesizeProject SYNTH_FLAGS HIERARCHY
}

# Main component
lappend HIERARCHY(COMPONENTS) [list "TOPLEVEL" $CARD_BASE/src "$COMBO_BASE"]

# Design parameters
set SYNTH_FLAGS(MODULE) "TOP_FPGA"
set SYNTH_FLAGS(FPGA)   "5CSEMA5F31C6"
# Enable Quartus Support-Logic Generation stage
set SYNTH_FLAGS(OUTPUT) $OUTPUT_NAME
set SYNTH_FLAGS(ASSERT_OFF) 1

# QSF constraints for specific parts of the design
set SYNTH_FLAGS(CONSTR) ""
set SYNTH_FLAGS(CONSTR) "$SYNTH_FLAGS(CONSTR) $CARD_BASE/constr/timing.sdc"
set SYNTH_FLAGS(CONSTR) "$SYNTH_FLAGS(CONSTR) $CARD_BASE/constr/general.qsf"
