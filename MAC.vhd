library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity MAC is 
	GENERIC(
	n: INTEGER:=8; 	--BITS DE LA SEÑAL DE ENTRADA DEL CONVERTIDOR
	m: INTEGER:=8;	--BITS DE LOS COEFICIENTES 
	k: INTEGER:=3	  --BITS DE ORDEN DEL FILTRO
	);
	port(
	RST: in std_logic;
	CLK: in std_logic;
	STP: in std_logic;
	X:   in std_logic_vector(n-1 downto 0);
	COEF:   in std_logic_vector(m-1 downto 0);
	ORDEN: in std_logic_vector(k-1 downto 0); 
	Y:   out std_logic_vector(n+m+k-1 downto 0);
	I:   out std_logic_vector(k-1 downto 0);	 
	FIN:	out std_logic
	);
		
end MAC;

--}} End of automatically maintained section

architecture MAC of MAC is 
--MULTIPLICADOR
SIGNAL 	 Z1:STd_logic_VEctor(n+m-1 downto 0);	  
--SUMADOR
SIGNAL 	 Z3:STd_logic_VEctor(n+m+k-1 downto 0);	
--REGISTRO PARALELO HOLD CLEAR
SIGNAL 	 Z4:STd_logic_VEctor(n+m+k-1 downto 0);
--REGISTRO PARALELO HOLD
SIGNAL 	 Y1:STd_logic_VEctor(n+m+k-1 downto 0);	
--CONTADOR ASCENDENTE
SIGNAL 	 Q:STd_logic_VEctor(k-1 downto 0);	
--COMPARADOR
SIGNAL 	 IGUAL:STd_logic;  
--FSM
SIGNAL 	 OPC:STd_logic_VEctor(1 downto 0);	 
SIGNAL 	 H1:STd_logic_VEctor(1 downto 0);
SIGNAL 	 H2,EOP:STd_logic; 
--SENALES AUXILIARES
SIGNAL 	 Z2:STd_logic_VEctor(n+m+k-1 downto 0);
begin
	--COMPARADOR
	IGUAL<='1'WHEN Q=ORDEN ELSE '0'; 
	--SUMADOR
	Z3<=Z2+Z4;
	--EXTENSION DE Z2
	Z2(n+m+k-1 downto n+m)<=(OTHERS =>Z1(n-1));
	Z2(n+m-1 downto 0) <=Z1;  
	
	A0: entity work.Multiplicador_nm_ss generic map(n,m) port map(X,COEF,Z1); 
	A1: entity work.REGISTRO_PARALELO_HOLD_CLEAR generic map(n+m+k) port map(RST,CLK,H1,Z3,Z4);	 
	A2: entity work.registro_hold generic map(n+m+k) port map(RST,CLK,H2,Z4,Y1);   
	A3: entity work.contador_ascendente_clear_sincrono generic map(k) port map(RST,CLK,OPC,Q);	
	A4: entity work.FSM_MAC  port map(RST,CLK,STP,IGUAL,OPC,H1,H2,EOP);	   
	FIN<=H2;	
	I<=Q;  
	--LA SALIDA 'Y' DEPENDE DEL FORMATO QUE ESTAMOS TRABAJANDO
	Y<=	Y1(n+m+k-1 DOWNTO 0);

end MAC;

	
