library IEEE;
 use IEEE.STD_LOGIC_1164.ALL;
 use IEEE.numeric_std.all;
 
 entity SteperMotor is
    Port ( 
           clk             : in  std_logic;
           led_cathode     : out std_logic;
           led_anode       : out std_logic
    );
 end SteperMotor;
 
 architecture RTL of SteperMotor is
   constant max_count : natural := 48000000;
   signal Rst_n : std_logic;
 begin
 
    Rst_n <= '1';
    led_cathode <= '0';
 
    -- 0 to max_count counter
    compteur : process(clk, Rst_n)
        variable count : natural range 0 to max_count;
    begin
        if Rst_n = '0' then
            count := 0;
            led_anode <= '1';
        elsif rising_edge(Clk) then
            if count < max_count/2 then
                led_anode    <='1';
                count := count + 1;
            elsif count < max_count then
                led_anode    <='0';
                count := count + 1;
            else
                count := 0;
                led_anode    <='1';
            end if;
        end if;
    end process compteur; 
 end RTL;