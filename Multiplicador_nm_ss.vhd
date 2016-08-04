library	IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity Multiplicador_nm_ss is
	generic(
	n : integer := 8;
	m : integer := 8
	);
	port(
	X : in  std_logic_vector(n-1   downto 0);
	A : in  std_logic_vector(m-1   downto 0);
	R : out std_logic_vector(m+n-1 downto 0)
	);
end Multiplicador_nm_ss;

architecture Aritmetica of Multiplicador_nm_ss is
begin
	process(X,A)
	variable Q : signed(n+m-1 downto 0);
	begin
		Q := signed(X) * 
		signed(A);
		R <= std_logic_vector(Q);
	end process;
end Aritmetica;