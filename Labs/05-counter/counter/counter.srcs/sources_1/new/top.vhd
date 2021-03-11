library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
    Port ( 
           CLK100MHZ     : in STD_LOGIC;
           BTNC          : in STD_LOGIC;
           SW            : in STD_LOGIC;
           LED           : out STD_LOGIC_VECTOR (16 -1 downto 0);
           CA            : out STD_LOGIC;
           CB            : out STD_LOGIC;
           CC            : out STD_LOGIC;
           CD            : out STD_LOGIC;
           CE            : out STD_LOGIC;
           CF            : out STD_LOGIC;
           CG            : out STD_LOGIC;
           AN            : out STD_LOGIC_VECTOR (7 downto 0)); 
end top;

------------------------------------------------------------------------
-- Architecture body for top level
------------------------------------------------------------------------
architecture Behavioral of top is
    
    signal s_en  : std_logic;
    signal s_cnt : std_logic_vector(4 - 1 downto 0);
    signal s_en_16 : std_logic;
    signal s_cnt_16 : std_logic_vector(16 - 1 downto 0);

begin
    --------------------------------------------------------------------
    -- Instance (copy) of clock_enable entity
    clk_en0 : entity work.clock_enable
        generic map(
            g_MAX => 100000000
        )
        port map(
            --- WRITE YOUR CODE HERE
            clk   => CLK100MHZ,
            reset => BTNC,
            ce_o  => s_en
        );

    --------------------------------------------------------------------
    -- Instance (copy) of cnt_up_down entity
    bin_cnt0 : entity work.cnt_up_down
        generic map(
            --- WRITE YOUR CODE HERE
            g_CNT_WIDTH => 4
        )
        port map(
            --- WRITE YOUR CODE HERE
            clk   => CLK100MHZ,
            reset => BTNC,
            en_i  => s_en,
            cnt_up_i  => SW,
            cnt_o  => s_cnt
         );

    --------------------------------------------------------------------
    -- Instance (copy) of hex_7seg entity
    hex2seg : entity work.hex_7seg
        port map(
            hex_i    => s_cnt,
            seg_o(6) => CA,
            seg_o(5) => CB,
            seg_o(4) => CC,
            seg_o(3) => CD,
            seg_o(2) => CE,
            seg_o(1) => CF,
            seg_o(0) => CG
        );
    
    -- Connect one common anode to 3.3V
    AN <= b"1111_1110";
    
    clk_en1 : entity work.clock_enable
        generic map(
            --- WRITE YOUR CODE HERE
            g_MAX => 1000000
        )
        port map(
            --- WRITE YOUR CODE HERE
            clk   => CLK100MHZ,
            reset => BTNC,
            ce_o  => s_en_16
        );
        
        bin_cnt1 : entity work.cnt_up_down
        generic map(
            --- WRITE YOUR CODE HERE
            g_CNT_WIDTH => 16
        )
        port map(
            --- WRITE YOUR CODE HERE
            clk   => CLK100MHZ,
            reset => BTNC,
            en_i  => s_en_16,
            cnt_up_i  => SW,
            cnt_o  => s_cnt_16
         );
        -- Display input value on LEDs
    LED(16-1 downto 0) <= s_cnt_16;

end architecture Behavioral;