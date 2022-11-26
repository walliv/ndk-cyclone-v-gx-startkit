# Modules.tcl: script to compile DK-DEV-AGI027RES card
# Author(s): Vladislav Valek <vladislav.valek@email.cz>
#
# SPDX-License-Identifier: BSD-3-Clause

set COMBO_BASE $ARCHGRP

set HACKATHON_BASE  "$COMBO_BASE/app/hackathon_base"

lappend COMPONENTS [list "HACKATHON_TOP" $HACKATHON_BASE "FULL"]

# Top-level
set MOD "$MOD $ENTITY_BASE/top_fpga.vhd"
