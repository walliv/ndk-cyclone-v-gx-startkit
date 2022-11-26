-- top_fpga.vhd: top level component of the design
-- Author(s): Vladislav Valek  <xvalek14@vutbr.cz>
--

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity TOP_FPGA is
    port(
        CLK_50 : in std_logic;

        L1_OSC    : in  std_logic;
        L1_TX0    : out std_logic;
        L1_TX1    : out std_logic;
        L1_TX_EN  : out std_logic;
        L1_RX0    : in  std_logic;
        L1_RX1    : in  std_logic;
        L1_CRS_DV : in  std_logic;

        UART_TX : out std_logic;
        UART_RX : in  std_logic
        );
end entity;

architecture FULL of TOP_FPGA is

    component top is
        port (
            CLK_50 : in std_logic;

            L1_OSC    : in  std_logic;
            L1_TX0    : out std_logic;
            L1_TX1    : out std_logic;
            L1_TX_EN  : out std_logic;
            L1_RX0    : in  std_logic;
            L1_RX1    : in  std_logic;
            L1_CRS_DV : in  std_logic;

            UART_TX : out std_logic;
            UART_RX : in  std_logic);
    end component;

begin

    hackathon_top_i : top
        port map (
            CLK_50    => CLK_50,

            L1_OSC    => L1_OSC,
            L1_TX0    => L1_TX0,
            L1_TX1    => L1_TX1,
            L1_TX_EN  => L1_TX_EN,
            L1_RX0    => L1_RX0,
            L1_RX1    => L1_RX1,
            L1_CRS_DV => L1_CRS_DV,

            UART_TX => UART_TX,
            UART_RX => UART_RX);

end architecture;
