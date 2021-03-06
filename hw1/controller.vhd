library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity controller is
	port(	go, clk, rst, zi: in std_logic;
			en : out std_logic_vector(4 downto 0) := (others => '0');
			gt : in std_logic_vector(2 downto 0);
			done, s2, s3 : out std_logic := '0');
end controller;

architecture acon of controller is

	signal state : integer := 0;
	signal regrise : std_logic;

begin
	process(clk, rst)
	begin
		if(rst = '1') then
				done <= '0';
				en <= "00000";
				s2 <= '0';
				s3 <= '0';
		elsif rising_edge(clk) then
			if(go = '0') then regrise <= '0';
			end if;
			if(zi = '1') then
				done <= '1';
			elsif(go = '1' and state = 0 and regrise<='0') then
				regrise <= '1';
				en <= "00100";
				if(gt(0) = '1') then	-- Highest
					state <= 1;
					s2 <= '0';
					s3 <= '0';
				elsif(gt(1) = '1') then -- Second
					s3 <= '0';
					s2 <= '1';
					state <= 3;
				elsif(gt(2) = '1') then -- Third
					s3 <= '1';
					s2 <= '0';
					state <= 10;
				end if;
			elsif(state = 1) then
				en <= "00010";
				state <= 2;
			elsif(state = 2) then
				en <= "00001";
				state <= 10;
			elsif(state = 3) then
				en <= "00010";
				state <= 10;
			elsif(state = 10) then
				en <= "11000";
				state <= 11;
			elsif(state = 11) then
				en <= "00000";
				state <=0;
			end if;
		end if;
	end process;
end acon;