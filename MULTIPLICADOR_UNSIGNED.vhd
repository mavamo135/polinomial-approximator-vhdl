
library IEEE;
use IEEE.STD_LOGIC_1164.all;  
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity MULTIPLICADOR_UNSIGNED is 
	generic(
	n : integer := 8;
	m : integer := 8
	);
	port(
	X : in  std_logic_vector(n-1   downto 0);
	A : in  std_logic_vector(m-1   downto 0);
	R : out std_logic_vector(m+n-1 downto 0)
	);
end MULTIPLICADOR_UNSIGNED;

--}} End of automatically maintained section

architecture MULTIPLICADOR_UNSIGNED of MULTIPLICADOR_UNSIGNED is
begin
	   process(X,A)
	variable Q : unsigned(n+m-1 downto 0);
	begin
		Q := unsigned(X) * unsigned(A);
		R <= std_logic_vector(Q);
	end process;
end MULTIPLICADOR_UNSIGNED;
