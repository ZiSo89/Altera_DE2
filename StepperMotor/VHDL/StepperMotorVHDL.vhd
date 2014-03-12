-- =============================================================================
-- file name is:  SteperMotorVHDL.vhd    
-- Author:        Sakis Zisoglou
-- Created:       11.04.14      last modified: 
-- =============================================================================
--  It is a 4 output with the function as:
--  LED lights and gpio pin enable cycle to move a stepper motors only one step at a time
-- =============================================================================

library IEEE;
 use IEEE.STD_LOGIC_1164.ALL;
 use IEEE.numeric_std.all;
 use IEEE.STD_LOGIC_ARITH.ALL;
 use IEEE.STD_LOGIC_UNSIGNED.ALL;
 
 entity SteperMotorVHDL is
    Port ( 
           clk             : in  std_logic;
           phase : out std_logic_vector (3 downto 0);
		   gpio: out std_logic_vector (3 downto 0);
		   led_cathode     : out std_logic;
           led_anode       : out std_logic
		   
		  
    );
 end SteperMotorVHDL;
 
 architecture RTL of SteperMotorVHDL is
   constant max_count : natural := 48000000;
   signal Rst_n : std_logic;
 begin
 
    Rst_n <= '1';
    led_cathode <= '0';
 
    -- 0 to max_count counter
    compteur : process(clk, Rst_n)
        variable count : natural range 0 to max_count;
		variable st : std_logic_vector (1 downto 0) := "00";
    begin
        if Rst_n = '0' then
            count := 0;
            led_anode <= '1';
        elsif rising_edge(Clk) then
     st:=st+1;
            if count < max_count/2 then
                led_anode    <='1';
                count := count + 1;				
            elsif count < max_count then
                led_anode    <='0';
                count := count + 1;
            else
                count := 0;
                led_anode    <='1';

    case (st) is                
          when "00" => phase <= "1000";  
          when "01" => phase <= "0100";
          when "10" => phase <= "0010";
          when "11" => phase <= "0001"; 
 	end case;
  	
	case (st) is     
		  when "00" => gpio <= "1000";  
          when "01" => gpio <= "0100";
          when "10" => gpio <= "0010";
          when "11" => gpio <= "0001"; 
     end case;

 end if;
        end if;
    end process compteur; 
   
 end RTL;