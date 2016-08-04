library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity COMPARADOR is
	generic(
	n: integer := 5
	);
	 port(
		 A : in STD_LOGIC_VECTOR(n-1 downto 0);
		 B : in STD_LOGIC_VECTOR(n-1 downto 0);
		 C : out STD_LOGIC
	     );
end COMPARADOR;

--}} End of automatically maintained section

architecture COMPARADOR of COMPARADOR is
begin

	 process(A,B)
	begin
	if ( A=B ) then
		C<='1' ;
	else
		C<='0' ;
	end if;		
	end process;

end COMPARADOR;
