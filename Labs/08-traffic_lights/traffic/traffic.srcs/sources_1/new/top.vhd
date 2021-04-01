----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.03.2021 14:08:29
-- Design Name: 
-- Module Name: top - Behavioral
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

entity top is
Port ( 
           CLK100MHZ : in STD_LOGIC;
           BTNC : in STD_LOGIC;
           
           LED16_R : out STD_LOGIC;
           LED16_G : out STD_LOGIC;
           LED16_B : out STD_LOGIC;
           LED17_R : out STD_LOGIC;
           LED17_G : out STD_LOGIC;
           LED17_B : out STD_LOGIC
           );
end top;

architecture Behavioral of top is

    signal s_south      : std_logic_vector(3 - 1 downto 0);
    signal s_west       : std_logic_vector(3 - 1 downto 0);

begin

    tlc : entity work.tlc
        port map( 
        clk        => CLK100MHZ,
        reset      => BTNC,
        south_o => s_south,
        west_o  => s_west
        );
        
     LED16_R  <= '1' when (s_south = "100" OR s_south = "110") else '0';
     LED16_G  <= '1' when (s_south = "010" OR s_south = "110") else '0';
     LED16_R  <= '0'; 
     
     LED17_R  <= '1' when (s_west = "100" OR s_west = "110") else '0';
     LED17_G  <= '1' when (s_west = "010" OR s_west = "110") else '0';
     LED17_R  <= '0';  

end Behavioral;
