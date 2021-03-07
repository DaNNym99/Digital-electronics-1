library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_top is

end tb_top;

architecture Behavoral of tb_top is

    signal s_hex : std_logic_vector(4 - 1 downto 0);
    signal s_CA : STD_LOGIC;
    signal s_CB : STD_LOGIC;
    signal s_CC : STD_LOGIC;
    signal s_CD : STD_LOGIC;
    signal s_CE : STD_LOGIC;
    signal s_CF : STD_LOGIC;
    signal s_CG : STD_LOGIC;
    signal s_LED : std_logic_vector (8 - 1 downto 0);
    signal s_AN : std_logic_vector (8 - 1 downto 0);
   
begin
  
    uut_top : entity work.top
        port map
        (

            SW      => s_hex,
            CA      => s_CA,
            CB      => s_CB,
            CC      => s_CC,
            CD      => s_CD,
            CE      => s_CE,
            CF      => s_CF,
            CG      => s_CG,
            LED     => s_LED,
            AN      => s_AN
        );

    p_stimulus : process
    begin
        -- Report a note at the begining of stimulus process
        report "Stimulus process started" severity note;


        s_hex <= "0000";
        wait for 50 ns;
        s_hex <= "0001";
        wait for 50 ns;
        s_hex <= "0010";
        wait for 50 ns;
        s_hex <= "0011";
        wait for 50 ns;
        s_hex <= "0100";
        wait for 50 ns;
        s_hex <= "0101";
        wait for 50 ns;
        s_hex <= "0110";
        wait for 50 ns;
        s_hex <= "0111";
        wait for 50 ns;
        s_hex <= "1000";
        wait for 50 ns;
        s_hex <= "1001";
        wait for 50 ns;
        s_hex <= "1010";
        wait for 50 ns;
        s_hex <= "1011";
        wait for 50 ns;
        s_hex <= "1100";
        wait for 50 ns;
        s_hex <= "1101";
        wait for 50 ns;
        s_hex <= "1110";
        wait for 50 ns;
        s_hex <= "1111";
        wait for 50 ns;
         
        -- Report a note at the end of stimulus process
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;

end architecture Behavoral;