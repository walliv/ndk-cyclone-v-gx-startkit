-- top_fpga.vhd: top level component of the design
-- Author(s): Vladislav Valek  <xvalek14@vutbr.cz>
--

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity TOP_FPGA is
    port(
        CLK        : in  std_logic;
        BTN_I      : in  std_logic_vector (3 downto 0);
        SW_I       : in  std_logic_vector (9 downto 0);
        LEDR_O     : out std_logic_vector (9 downto 0) := (others => '0');
        LEDG_O     : out std_logic_vector (7 downto 0) := (others => '0');
        DISP_DIG_0 : out std_logic_vector (6 downto 0) := (others => '1');
        DISP_DIG_1 : out std_logic_vector (6 downto 0) := (others => '1');
        DISP_DIG_2 : out std_logic_vector (6 downto 0) := (others => '1');
        DISP_DIG_3 : out std_logic_vector (6 downto 0) := (others => '1')
        );
end entity;

architecture FULL of TOP_FPGA is

    constant PWM_RESOLUTION : positive := 8;
    constant NUM_LEDS       : positive := 10;

    signal ce_fade     : std_logic;
    signal fade_cntr   : std_logic_vector(PWM_RESOLUTION -1 downto 0);
    type fade_sh_reg_type is array (NUM_LEDS -1 downto 0) of std_logic_vector(PWM_RESOLUTION -1 downto 0);
    signal fade_sh_reg : fade_sh_reg_type := (others => (others => '0'));

    type segm_all_type is array (4 -1 downto 0) of std_logic_vector(7 -1 downto 0);
    signal segm_all : segm_all_type := (others => (others => '1'));

begin

    DISP_DIG_0 <= segm_all(0);
    DISP_DIG_1 <= segm_all(1);
    DISP_DIG_2 <= segm_all(2);
    DISP_DIG_3 <= segm_all(3);

    -- ===============================================================================================
    -- Clock divider
    -- ===============================================================================================
    clk_div_i : entity work.CNT_GEN
        generic map (
            MAX_VAL          => 2000000,
            LENGTH           => 32,
            INC_VAL          => 1,
            AUTO_REVERSE_DIR => FALSE,
            DYNAMIC_CNT_DIR  => FALSE)
        port map (
            CLK => CLK,
            RST => not BTN_I(0),

            EN      => '1',
            CNT_DIR => '0',
            CNT_OUT => open,
            OVF     => ce_fade,
            UNF     => open);

    -- ===============================================================================================
    -- Segment display writer
    -- ===============================================================================================

    segm_cycle_g: for i in 0 to 3 generate
        segment_cycle_i : entity work.SEGMENT_CYCLE
            generic map (
                DIV_FACTOR => 15000000)
            port map (
                CLK     => CLK,
                RESET   => not BTN_I(0),
                SEG_DIG => segm_all(i));
    end generate;

    -- ===============================================================================================
    -- PWM driver
    -- ===============================================================================================
    fade_cntr_i : entity work.CNT_GEN
        generic map (
            MAX_VAL          => 255,
            LENGTH           => PWM_RESOLUTION,
            INC_VAL          => 16,
            AUTO_REVERSE_DIR => TRUE,
            DYNAMIC_CNT_DIR  => FALSE
            )
        port map(
            CLK     => CLK,
            RST     => not BTN_I(0),
            EN      => ce_fade,
            CNT_DIR => '0',
            CNT_OUT => fade_cntr,
            OVF     => open,
            UNF     => open
            );

    fade_sh_reg_p : process (CLK)
    begin
        if (rising_edge(CLK)) then
            if (ce_fade = '1') then
                fade_sh_reg <= fade_sh_reg(NUM_LEDS -2 downto 0) & fade_cntr;
            end if;
        end if;
    end process;

    pwm_driv_g : for i in 0 to (NUM_LEDS -1) generate
        pwm_driv_i : entity work.PWM_DRIVER
            generic map (
                RESOLUTION => PWM_RESOLUTION)
            port map (
                CLK     => CLK,
                PWM_REF => fade_sh_reg(i),
                PWM_OUT => LEDR_O(i),
                CNT_OUT => open);

        g_led: if (i < 7) generate
            pwm_driv_i : entity work.PWM_DRIVER
                generic map (
                    RESOLUTION => PWM_RESOLUTION)
                port map (
                    CLK     => CLK,
                    PWM_REF => fade_sh_reg(i),
                    PWM_OUT => LEDG_O(i),
                    CNT_OUT => open);
        end generate;
    end generate;
end architecture;
