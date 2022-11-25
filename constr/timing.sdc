# timing.sdc: Timing constraints
# Copyright (C) 2022 CESNET z. s. p. o.
# Author(s): Vladislav Valek <vladislav.valek@email.cz>
#
# SPDX-License-Identifier: BSD-3-Clause

derive_clock_uncertainty

create_clock -name {CLK} -period 20.0 [get_ports { CLK }]
