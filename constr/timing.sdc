# timing.sdc: Timing constraints
# Copyright (C) 2022 CESNET z. s. p. o.
# Author(s): Vladislav Valek <vladislav.valek@email.cz>
#
# SPDX-License-Identifier: BSD-3-Clause

derive_clock_uncertainty

create_clock -period 50MHz [get_ports {CLK_50}]
create_clock -period 50MHz [get_ports {L1_OSC}]

set_clock_groups -asynchronous -group [get_clocks {CLK_50}] \
-group [get_clocks {L1_OSC}] \
-group [get_clocks {altera_reserved_tck}]
