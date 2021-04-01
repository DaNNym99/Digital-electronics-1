----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.04.2021 18:32:00
-- Design Name: 
-- Module Name: tb_tlc_improved - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_tlc_improved is
--  Port ( );
end tb_tlc_improved;

architecture testbench of tb_tlc_improved is

    constant c_CLK_100MHZ_PERIOD : time := 10 ns;

    --Local signals
    signal s_clk_100MHz     : std_logic;
    signal s_reset          : std_logic;
    signal s_south          : std_logic_vector(3 - 1 downto 0);
    signal s_west           : std_logic_vector(3 - 1 downto 0);
    signal s_trafic_west    : std_logic;
    signal s_trafic_south   : std_logic;

begin

    uut_tlc_improved : entity work.tlc_improved
        port map(
            clk     => s_clk_100MHz,
            reset   => s_reset,
            south_o => s_south,
            west_o  => s_west,
            trafic_south  => s_trafic_west,
            trafic_west  => s_trafic_south
            
        );
        
    p_clk_gen : process
    begin
        while now < 10000 ns loop   -- 10 usec of simulation
            s_clk_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clk_gen;
    
    p_reset_gen : process
    begin
        s_reset <= '0'; wait for 200 ns;
        -- Reset activated
        s_reset <= '1'; wait for 500 ns;
        -- Reset deactivated
        s_reset <= '0';
        wait;
    end process p_reset_gen;
    
    p_stimulus : process
    begin
         
        s_trafic_west <= '1';
        s_trafic_south <= '1'; wait for 2000 ns;
        -- Reset activated
        s_trafic_west <= '0'; 
        s_trafic_south <= '1';wait for 2000ns;
        -- Reset deactivated
        s_trafic_west <= '0'; 
        s_trafic_south <= '0';wait for 2000ns;
        
        s_trafic_west <= '1'; 
        s_trafic_south <= '0';wait for 2000ns;
        
        s_trafic_west <= '1'; 
        s_trafic_south <= '1';wait for 2000ns;
                
        wait; 
         
        wait;
    end process p_stimulus;        

end testbench;
