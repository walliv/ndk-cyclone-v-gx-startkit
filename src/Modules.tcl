# Modules.tcl: script to compile DK-DEV-AGI027RES card
# Author(s): Vladislav Valek <vladislav.valek@email.cz>
#
# SPDX-License-Identifier: BSD-3-Clause

set COMBO_BASE $ARCHGRP

set CNT_GEN_BASE        "$COMBO_BASE/app/cnt_gen"
set PWM_DRIVER_BASE     "$COMBO_BASE/app/pwm_driver"
set SEGMENT_CYCLE_BASE  "$COMBO_BASE/app/segment_cycle"

lappend COMPONENTS [list "CNT_GEN" $CNT_GEN_BASE "FULL"]
lappend COMPONENTS [list "PWM_DRIVER" $PWM_DRIVER_BASE "FULL"]
lappend COMPONENTS [list "SEGMENT_CYCLE" $SEGMENT_CYCLE_BASE "FULL"]

# Top-level
set MOD "$MOD $ENTITY_BASE/top_fpga.vhd"
