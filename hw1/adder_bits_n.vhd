library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity adder_bits_n is
	generic(n : integer := 4);
	port(	cin: in std_logic := '0';
			a, b: in std_logic_vector(n-1 downto 0) := (others => '0');
			s : out std_logic_vector(n-1 downto 0);
			cout: out std_logic);
end adder_bits_n;

ARCHITECTURE behv OF adder_bits_n IS
 COMPONENT full_adder
	PORT (i_carry, i_bit1, i_bit2: IN std_logic; o_sum, o_carry: OUT std_logic);
	END COMPONENT;
 SIGNAL t: std_logic_vector(n downto 0);
	BEGIN
		t(0) <= Cin; Cout <= t(n);
		FA: for i in 0 to n-1 generate
		FA_i: full_adder PORT MAP (t(i), a(i), b(i), S(i), t(i+1));
 end generate;
END behv;