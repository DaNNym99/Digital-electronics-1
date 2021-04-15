----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.03.2021 16:13:16
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

           btn : in STD_LOGIC_VECTOR (4-1 downto 0);
                      
           ja : in STD_LOGIC_VECTOR (8-1 downto 0);
           jb : out STD_LOGIC_VECTOR (8-1 downto 0);
           jc : out STD_LOGIC_VECTOR (8-1 downto 0)    
           );
           
           
           
           
end top;

------------------------------------------------------------------------
-- Architecture body for top level
------------------------------------------------------------------------
architecture Behavioral of top is
    -- No internal signals
    
    signal   s_number  : std_logic_vector(4 - 1 downto 0);
    
    signal   s_data0  : std_logic_vector(4 - 1 downto 0);
    signal   s_data1  : std_logic_vector(4 - 1 downto 0);
    signal   s_data2  : std_logic_vector(4 - 1 downto 0);
    signal   s_data3  : std_logic_vector(4 - 1 downto 0);
    
    
begin

    --------------------------------------------------------------------
    -- Instance (copy) of driver_7seg_4digits entity
    
    uut_keypad_4x3 : entity work.keypad_4x3
        port map(
            clk     => CLK100MHZ,
            hor_1   => ja(0),
            hor_2   => ja(1),
            hor_3   => ja(2),
            hor_4   => ja(3),
            ver_1   => ja(4),
            ver_2   => ja(5),
            ver_3   => ja(6),
            number_o => s_number
        );
        
     uut_controler : entity work.controler
        port map(
            clk     => CLK100MHZ,
            reset   => btn(0),
            number_i => s_number,
            door_i   => ja(7),
            alarm_o   => jc(7),
            locker_o  => jc(6),
            data0_o => s_data0,
            data1_o => s_data1,
            data2_o => s_data2,
            data3_o => s_data3
    );
    
    driver_seg_4 : entity work.driver_7seg_4digits
        port map(
            clk        => CLK100MHZ,
            reset      => btn(0),
           
            data0_i => s_data0,
            data1_i => s_data1,
            data2_i => s_data2,
            data3_i => s_data3,
            
            
            seg_o(6) => jb(6),
            seg_o(5) => jb(5),
            seg_o(4) => jb(4),
            seg_o(3) => jb(3),
            seg_o(2) => jb(2),
            seg_o(1) => jb(1),
            seg_o(0) => jb(0)  
     );

end architecture Behavioral;
