LIBRARY ieee  ; 
LIBRARY work  ; 
USE ieee.MATH_REAL."CEIL"  ; 
USE ieee.MATH_REAL."LOG2"  ; 
USE ieee.NUMERIC_STD.all  ; 
USE ieee.std_logic_1164.all  ; 
USE work.all  ; 
USE work.CoeffPak.all  ; 
use ieee.fixed_pkg.all;

ENTITY parallel_neuron_tb  IS 
  GENERIC (
    float_bit  : INTEGER   := 5 ;  
    int_bit  : INTEGER   := 3 ;  
    N  : INTEGER   := 3 ); 
END ; 
 
ARCHITECTURE parallel_neuron_tb_arch OF parallel_neuron_tb IS
 
  SIGNAL LCounter   :  integer ; 
  SIGNAL X   :  DataArray:=(others=>(others=>'0'));  
  SIGNAL output   :  sfixed(int_bit-1 downto -float_bit); 
  SIGNAL clk   :  STD_LOGIC  ; 
  SIGNAL b   :  sfixed(int_bit-1 downto -float_bit); 
  SIGNAL reset   :  STD_LOGIC  ; 
  SIGNAL W   : DataArray:=(others=>(others=>'0')); 
  constant X_in: DataArray:=( 
  "00100000",
  "00100000",
  "00100000"
  );
  
  constant Weight: DataArray:=( 
  "00100000",
  "00010000",
  "00011000"
  );
  COMPONENT parallel_neuron  
    GENERIC ( 
      float_bit  : INTEGER ; 
      int_bit  : INTEGER ; 
      N  : INTEGER  );  
    PORT ( 
  
      LCounter  : in integer ; 
      X  : in DataArray:=(others=>(others=>'0')); 
      output  : out sfixed(int_bit-1 downto -float_bit);
      clk  : in STD_LOGIC ; 
      b  : in sfixed(int_bit-1 downto -float_bit);
      reset  : in STD_LOGIC ; 
      W  : in DataArray:=(others=>(others=>'0'))); 
  END COMPONENT; 
  
BEGIN
  DUT  : parallel_neuron  
    GENERIC MAP ( 
      float_bit  => float_bit  ,
      int_bit  => int_bit  ,
      N  => N   )
    PORT MAP ( 
      
      LCounter   => LCounter  ,
      X   => X  ,
      output   => output  ,
      clk   => clk  ,
      b   => b  ,
      reset   => reset  ,
      W   => W   ) ; 
      
process 
  begin
    clk<='1';
    wait for 1 ns;
    clk<='0';
    wait for 1 ns;
end process;


process
begin  
  reset<='1';
  wait for 2 ns;
  reset<='0';                
    b<="00100000";
    LCounter<=1;
    for i in 0 to N-1 loop           
    X(i)<=X_in(i);
    W(i)<=Weight(i);
    end loop;
   wait for 2000 ns;
       
end process;
      

END parallel_neuron_tb_arch; 

