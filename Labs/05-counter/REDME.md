# Laboratórna úloha číslo 5
### *Daniel Haluška*

## GitHub:

Link repozitára: https://github.com/DaNNym99/Digital-electronics-1

## 1. Zapojenie Nexis 7 a Tabuľka počítaných hodnôt:

### 1.1. Board
![Board](Images/NexisA7.png)
### 1.2. Mapovanie 7-segment
| **Ozacenie** | **Port (Entity)** |**Funkcia** |
| :-: | :-: | :-: | 
| J15 | SW | L=0V, H=3,3V | 
| P17 | RESET | L=0V, H=3,3V |
| T10 | CA | A | 
| R10 | CB | B |
| K16 | CC | C |
| K13 | CD | D |
| P15 | CE | E |
| T11 | CF | F |
| L18 | CG | G |
| J17 | AN[0] | KAT 1 |
| J18 | AN[1] | KAT 2 |
| T9 | AN[2] | KAT 3 |
| J14 | AN[3] | KAT 4 |
| P14 | AN[4] | KAT 5 |
| T14 | AN[5] | KAT 6 |
| K2 | AN[6] | KAT 7 |
| U13 | AN[7] | KAT 8 |


### 1.3. Tabuľka prepočátaných hodnôt


| **Time interval** | **Number of clk periods** | **Number of clk periods in hex** | **Number of clk periods in binary** |
   | :-: | :-: | :-: | :-: |
   | 2&nbsp;ms | 200 000 | `x"3_0d40"` | `b"0011_0000_1101_0100_0000"` |
   | 4&nbsp;ms | 400 000 | `x"6_1a80"` | `b"0110_0001_1010_1000_0000"` |
   | 10&nbsp;ms | 1 000 000 | `x"f_4240"` | `b"1111_0100_0010_0100_0000"` |
   | 250&nbsp;ms | 25 000 000 | `x"17d_7840"` | `b"0001_0111_1101_0111_1000_0100_0000"` |
   | 500&nbsp;ms | 50 000 000 | `x"2fa_f080"` | `b"0010_1111_1010_1111_0000_1000_0000"` |
   | 1&nbsp;sec | 100 000 000 | `x"5f5_e100"` | `b"0101_1111_0101_1110_0001_0000_0000"` |

## 2. Obojsmerný čítač

### 2.1. Proces p_cnt_up_down
```vhdl
p_cnt_up_down : process(clk)
    begin
        if rising_edge(clk) then
        
            if (reset = '1') then               -- Synchronous reset
                s_cnt_local <= (others => '0'); -- Clear all bits

            elsif (en_i = '1') then       -- Test if counter is enabled

                -- TEST COUNTER DIRECTION HERE
                if (cnt_up_i = '1') then
                    s_cnt_local <= s_cnt_local + 1;
                elsif (cnt_up_i = '0') then
                    s_cnt_local <= s_cnt_local - 1;
                end if;
            end if;
        end if;
    end process p_cnt_up_down;
```
### 2.2. Proces p_reset_gen  p_stimulus
```vhdl
   p_reset_gen : process
    begin
        s_reset <= '0';
        wait for 12 ns;
        
        -- Reset activated
        s_reset <= '1';
        wait for 74 ns;

        s_reset <= '0';
        wait;
    end process p_reset_gen;

    
    p_stimulus : process
    begin
        report "Stimulus process started" severity note;

        -- Enable counting
        s_en     <= '1';
        
        -- Change counter direction
        s_cnt_up <= '1';
        wait for 400 ns;
        s_cnt_up <= '0';
        wait for 340 ns;

        -- Disable counting
        s_en     <= '0';

        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;
```
### 2.3. Vystup symulácie
![Counter](Images/CNT1.png)
- Pri umiestnení kurzora dôjde k pretečeniu čátač počíta odznova 

## 3. Top level

### 3.1. Súbor top.vhl pre 4-bit
```vhdl
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
```
### 3.2. Rozšírenie pre 16-bit

```vhdl
p_cnt_up_down : process(clk)
    begin
        if rising_edge(clk) then
        
            if (reset = '1') then               -- Synchronous reset
                s_cnt_local <= (others => '0'); -- Clear all bits

            elsif (en_i = '1') then       -- Test if counter is enabled

                -- TEST COUNTER DIRECTION HERE
                if (cnt_up_i = '1') then
                    s_cnt_local <= s_cnt_local + 1;
                elsif (cnt_up_i = '0') then
                    s_cnt_local <= s_cnt_local - 1;
                end if;
            end if;
        end if;
    end process p_cnt_up_down;
```

### 3.3. Schema 4-bit + 16-bit čítača
![Vystup](Images/scheme.png)