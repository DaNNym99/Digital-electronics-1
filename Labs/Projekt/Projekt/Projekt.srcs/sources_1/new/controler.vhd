----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.04.2021 20:26:12
-- Design Name: 
-- Module Name: controler - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity controler is
 port(
        clk     : in  std_logic;
        reset   : in  std_logic;
        number_i : in  std_logic_vector(4 - 1 downto 0);
        door_i : in  std_logic;
        alarm_o : out  std_logic;
        locker_o : out  std_logic;
        
        rgb_o : out  std_logic_vector(3 - 1 downto 0);
        
        data0_o : out  std_logic_vector(4 - 1 downto 0);
        data1_o : out  std_logic_vector(4 - 1 downto 0);
        data2_o : out  std_logic_vector(4 - 1 downto 0);
        data3_o : out  std_logic_vector(4 - 1 downto 0)
        
    );
end controler;

architecture Behavioral of controler is
    
    type   t_state is (CLOSE, OPENED, WAITH, AFTERTIME, ALARM, MASTER);
    signal s_state  : t_state;
    
    type   t_state_pass is (POS1, POS2, POS3, POS4, ENT);
    signal s_state_pass  : t_state_pass;
    
    signal   s_clk  : std_logic; 
    
    signal   s_cnt  : unsigned(36 - 1 downto 0):= b"0000_0000_0000_0000_0000_0000_0000_0000_0000";
    
    signal   s_alarm  : std_logic;
    signal   s_reset_pass : std_logic;
    
    signal   s_pass_1  : std_logic_vector(4 - 1 downto 0);
    signal   s_pass_2  : std_logic_vector(4 - 1 downto 0);
    signal   s_pass_3  : std_logic_vector(4 - 1 downto 0);
    signal   s_pass_4  : std_logic_vector(4 - 1 downto 0);
    signal   s_pass : std_logic_vector(16 - 1 downto 0);
    
    constant c_DELAY_10SEC : unsigned(36 - 1 downto 0) := b"0010_0101_0100_0000_1011_1110_0100_0000_0000"; --upravit podla cnt
    constant c_ZERO       : unsigned(36 - 1 downto 0) := b"0000_0000_0000_0000_0000_0000_0000_0000_0000";
    
    constant c_MASTER_pass : std_logic_vector(16 - 1 downto 0) := b"0001_0001_0001_0001";
    constant c_SLAVE_pass : std_logic_vector(16 - 1 downto 0) := b"0010_0010_0010_0010";
    constant c_UNDEFINED_pass : std_logic_vector(16 - 1 downto 0) := b"1111_1111_1111_1111";
    
    constant c_UNDEFINED : std_logic_vector(4 - 1 downto 0) := b"1111";
    constant c_CANCEL : std_logic_vector(4 - 1 downto 0) := b"1011";
    constant c_ENTER : std_logic_vector(4 - 1 downto 0) := b"1010";
    
    constant c_RED : std_logic_vector(3 - 1 downto 0) := b"100";
    constant c_GREEN : std_logic_vector(3 - 1 downto 0) := b"010";
    constant c_YELOW : std_logic_vector(3 - 1 downto 0) := b"110";

    begin
    
    
    p_keypad_watcher : process(clk, s_reset_pass)
    begin
        
        if s_reset_pass = '1' then -- treba dako vyhutat
            s_pass <= c_UNDEFINED_pass;
            s_pass_1 <= c_UNDEFINED;
            s_pass_2 <= c_UNDEFINED;
            s_pass_3 <= c_UNDEFINED;
            s_pass_4 <= c_UNDEFINED;
        end if;
        
        if falling_edge(clk) then
            
            if(number_i = c_UNDEFINED)then
            
            
            else
 
                case (s_state_pass) is
                    when POS1 =>
                        if (number_i = c_CANCEL OR number_i = c_ENTER)then
                            s_pass_1 <= c_UNDEFINED;
                            s_pass_2 <= c_UNDEFINED;
                            s_pass_3 <= c_UNDEFINED;
                            s_pass_4 <= c_UNDEFINED;
                            s_state_pass <= POS1;
                        else 
                            s_pass_1 <= number_i;
                            s_state_pass <= POS2;
                        end if;
                        
                    when POS2 => 
                    
                        if (number_i = c_CANCEL OR number_i = c_ENTER)then
                            s_pass_1 <= c_UNDEFINED;
                            s_pass_2 <= c_UNDEFINED;
                            s_pass_3 <= c_UNDEFINED;
                            s_pass_4 <= c_UNDEFINED;
                            s_state_pass <= POS1;
                        else 
                            s_pass_2 <= number_i;
                            s_state_pass <= POS3;
                        end if;
                        
                    when POS3 => 
                        if (number_i = c_CANCEL OR number_i = c_ENTER)then    
                            s_pass_1 <= c_UNDEFINED;
                            s_pass_2 <= c_UNDEFINED;
                            s_pass_3 <= c_UNDEFINED;
                            s_pass_4 <= c_UNDEFINED;
                            s_state_pass <= POS1;
                        else 
                            s_pass_3 <= number_i;
                            s_state_pass <= POS4;
                        end if;  
                        
                    when POS4 => 
                        if (number_i = c_CANCEL)then
                            s_pass_1 <= c_UNDEFINED;
                            s_pass_2 <= c_UNDEFINED;
                            s_pass_3 <= c_UNDEFINED;
                            s_pass_4 <= c_UNDEFINED;
                            s_state_pass <= POS1;
                        else 
                            s_pass_4 <= number_i;
                            s_state_pass <= ENT;
                        end if;
                        
                     when ENT => 
                        if (number_i = c_CANCEL)then
                            s_pass_1 <= c_UNDEFINED;
                            s_pass_2 <= c_UNDEFINED;
                            s_pass_3 <= c_UNDEFINED;
                            s_pass_4 <= c_UNDEFINED;
                            s_state_pass <= POS1;
                        elsif (number_i = c_ENTER)then
                            s_state_pass <= POS1;
                            s_pass <= s_pass_1 & s_pass_2 & s_pass_3 & s_pass_4 ;
                            s_pass_1 <= c_UNDEFINED; -- abo nejaky znak iny 
                            s_pass_2 <= c_UNDEFINED;
                            s_pass_3 <= c_UNDEFINED;
                            s_pass_4 <= c_UNDEFINED;
                        else
                            s_state_pass <= ENT;
                        end if;
                     when others =>
                        s_state_pass <= POS1;
                end case;
          
            end if;
            
            --povodne elsif      
        end if;
    end process p_keypad_watcher;
    

    p_result_controler : process(clk)
    begin
        if rising_edge(clk) then
                     
                case s_state is
           
                    when CLOSE =>
                        
                        if ((s_pass = c_MASTER_pass) OR (s_pass = c_SLAVE_pass))then
                            s_state <= OPENED; -- mozna led
                        else 
                            s_state <= CLOSE;  -- mozna led
                            locker_o <= '0';
                            rgb_o <= c_RED;
                        end if;
                    
                    when OPENED =>

                        if (s_cnt < c_DELAY_10SEC) then
                            s_cnt <= s_cnt + 1;
                            locker_o <= '1';
                            rgb_o <= c_GREEN;
                        else
                            s_state <= WAITH;
                            locker_o <= '0';
                            s_cnt   <= c_ZERO;
                        end if;
                    
                    when WAITH =>
                    
                        if (s_cnt < c_DELAY_10SEC) then
                            s_cnt <= s_cnt + 1;
                            rgb_o <= c_YELOW;
                        elsif (door_i = '1') then
                            s_state <= CLOSE;
                            s_reset_pass <= '1';
                            s_cnt   <= c_ZERO;
                        else
                            s_state <= AFTERTIME;
                            s_cnt   <= c_ZERO;
                            s_reset_pass <= '1';
                        end if;
                    
                    when AFTERTIME => --dopisaù 
                        if (s_pass = c_MASTER_pass) then
                            s_state <= MASTER;
                            s_reset_pass <= '1';
                        else    
                        s_alarm <= '1';
                        end if;
                        
                    when ALARM =>
                        s_alarm <= '1';
                        s_state <= CLOSE;
                     
                    when MASTER =>
                        if (door_i = '1') then
                            s_state <= CLOSE;
                        else    
                            s_state <= MASTER;
                            rgb_o <= c_GREEN;
                        end if;
                    when others =>
                        s_state <= CLOSE;

                end case;
              end if;
          
            if falling_edge(clk) then
            
            s_reset_pass <= '0';
            
            if (s_alarm = '1') then 
                if (s_pass = c_MASTER_pass)then
                    s_alarm <= '0';
                    s_reset_pass <= '1'; 
                else 
                    s_alarm <='1';
                end if; 
            end if; -- Alarm
        end if; -- Falling edge
    end process p_result_controler;
    
    alarm_o <= s_alarm ;
    
    data0_o <= s_pass_1;
    data1_o <= s_pass_2;
    data2_o <= s_pass_3;
    data3_o <= s_pass_4;
    
end Behavioral;
