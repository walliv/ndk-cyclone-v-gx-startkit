# card_const.tcl: Default parameters for DK-DEV-AGI027RES card (developement only)
# Copyright (C) 2021 CESNET, z. s. p. o.
# Author(s): Jakub Cabal <cabal@cesnet.cz>
#            Vladislav Valek <valekv@cesnet.cz>
#
# SPDX-License-Identifier: BSD-3-Clause

# WARNING: The user should not deliberately change parameters in this file. For
# the description of this file, visit the Parametrization section in the
# documentation of the NDK-CORE repostiory

set CARD_NAME "DK-DEV-AGI027RES"
# Achitecture of Clock generator
set CLOCK_GEN_ARCH "INTEL"
# Achitecture of PCIe module
set PCIE_MOD_ARCH "R_TILE"
# Achitecture of Network module
set NET_MOD_ARCH "F_TILE"
# Achitecture of SDM/SYSMON module
set SDM_SYSMON_ARCH "INTEL_SDM"

# Total number of QSFP cages
# Only QSFP1 cage is used, QSFP0 is completely disconnected.
set QSFP_CAGES       1
# I2C address of each QSFP cage
set QSFP_I2C_ADDR(0) "0xF8"
