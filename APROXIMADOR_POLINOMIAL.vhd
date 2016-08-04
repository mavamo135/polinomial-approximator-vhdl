library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity APROXIMADOR_POLINOMIAL is 	   
	GENERIC(
	n: INTEGER:=36;  --BITS DE LA SEÑAL DE ENTRADA DEL CONVERTIDOR
	m: INTEGER:=8;	--BITS DE LOS COEFICIENTES 
	k: INTEGER:=1;	--BITS DE ORDEN DEL FILTRO 
	h: INTEGER:=3	--BITS DE REPETICIÓN DE LA MAC
	);
	port(
	RST: in std_logic;
	CLK: in std_logic; 
	T: IN STD_LOGIC_VECTOR(m-1 DOWNTO 0);
	CONTROL_DIS: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	DP: OUT std_logic;
	DISPLAY: OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
end APROXIMADOR_POLINOMIAL;

--}} End of automatically maintained section

architecture APROXIMADOR_POLINOMIAL of APROXIMADOR_POLINOMIAL is 		
--MAC
SIGNAL EOP: STD_LOGIC;
SIGNAL X: STD_LOGIC_VECTOR(n-1 DOWNTO 0);	
SIGNAL Y: STD_LOGIC_VECTOR(m+k+n-1 DOWNTO 0);
SIGNAL COEF: STD_LOGIC_VECTOR(m-1 DOWNTO 0); 
SIGNAL I: STD_LOGIC_VECTOR(k-1 DOWNTO 0);
SIGNAL ORDEN: STD_LOGIC_VECTOR(k-1 DOWNTO 0):=(others => '1');  
SIGNAL REP: STD_LOGIC_VECTOR(h-1 DOWNTO 0):="110";
SIGNAL AUX: STD_LOGIC_VECTOR(h DOWNTO 0);

--CONTADOR
SIGNAL OPC,OPC1,Q1: STD_LOGIC_VECTOR(1 DOWNTO 0); 
SIGNAL Q: STD_LOGIC_VECTOR(h DOWNTO 0);
SIGNAL IGUAL: STD_LOGIC;  

--CONTROL LUT
SIGNAL CONTROL: STD_LOGIC_VECTOR(k+h-1 DOWNTO 0); 	 

--CODIFICADOR ENTERO DECIMAL
SIGNAL	ENTERO:  STd_logic_VEctor(18 downto 0);
SIGNAL	FORMATO:  STd_logic_VEctor(11 downto 0);
SIGNAL	ESCALADOR: STd_logic_VEctor(9 downto 0):="0011110100";
SIGNAL	D5E:  std_logic_vector(3 downto 0); 
SIGNAL	D4E:  std_logic_vector(3 downto 0);
SIGNAL	D3E:  std_logic_vector(3 downto 0);
SIGNAL	D2E:  std_logic_vector(3 downto 0);
SIGNAL	D1E:  std_logic_vector(3 downto 0);
SIGNAL	D0E:  std_logic_vector(3 downto 0);
SIGNAL	D5D:  std_logic_vector(3 downto 0); 
SIGNAL	D4D:  std_logic_vector(3 downto 0);
SIGNAL	D3D:  std_logic_vector(3 downto 0);
SIGNAL	D2D:  std_logic_vector(3 downto 0);
SIGNAL	D1D:  std_logic_vector(3 downto 0);
SIGNAL	D0D:  std_logic_vector(3 downto 0);	  

--REGISTRO 
SIGNAL SALIDA: STD_LOGIC_VECTOR(n+m+k-1 DOWNTO 0):=(others => '0');	 

--BASE DE TIEMPO
SIGNAL EOBT: STD_LOGIC;	  

--BCD_7SEGMENTOS
SIGNAL DIS :STD_LOGIC_VECTOR(3 DOWNTO 0);

begin

	A0: entity work.MAC generic map(n,m,k) port map(RST,CLK,'1',X,COEF,ORDEN,Y,I,EOP);	
	A1: entity work.LUT_MAC port map(T,Y(39 DOWNTO 4),CONTROL,X,COEF);--(39 DOWNTO 4)	  
	A2: entity work.contador_ascendente_clear_sincrono generic map(h+1) port map(RST,CLK,OPC,Q);
	A3: entity work.COMPARADOR generic map(h+1) port map(Q,AUX,IGUAL);	
	A4: entity work.FSM_WAVELET port map(RST,CLK,'1',EOP,IGUAL,OPC);
	AUX<='0'&REP+1;
	CONTROL<=Q(h-1 DOWNTO 0)&I;		  
	
	A5: entity work.registro_hold generic map(n+m+k) port map(RST,CLK,IGUAL,Y,SALIDA);	  
	
	ENTERO<="000000000000000000"&SALIDA(39 DOWNTO 39);
	FORMATO<=SALIDA(38 DOWNTO 27);

	A6: entity work.CODIFICADOR_ENTERO_DECIMAL port map (RST,CLK,ENTERO,FORMATO,ESCALADOR,D5E,D4E,D3E,D2E,D1E,D0E,D5D,D4D,D3D,D2D,D1D,D0D);
	A7: entity work.base_de_tiempo generic map(16) port map (RST,CLK,'1',"1100001101010000",EOBT); 
	A8: entity work.contador_ascendente_clear_sincrono generic map(2) port map(RST,CLK,OPC1,Q1);
	A9: entity work.CONTROL port map (Q1,D0E,D5D,D4D,D3D,CONTROL_DIS,DIS,DP);  
	A10: entity work.BCD_7SEGMENTOS port map (DIS,DISPLAY);
	
	PROCESS(EOBT)
	BEGIN
		IF EOBT='1' THEN
			OPC1<="01";
		ELSE
			OPC1<="00";
		END IF;
	END PROCESS;

end APROXIMADOR_POLINOMIAL;		 

	

