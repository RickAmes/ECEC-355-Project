library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_signed.all;

entity ALU is
generic(n:natural:=32);
port(	a,b:in std_logic_vector(n-1 downto 0);
		Oper:in std_logic_vector(3 downto 0);
		Result:buffer std_logic_vector(n-1 downto 0);
		Zero,Set,Overflow:buffer std_logic);
 end ALU;
architecture beh of ALU is
	component ALU1 is
		port(	A, B, AInvert, BInvert, CarryIn, Less:in STD_LOGIC;
				Operation:in STD_LOGIC_VECTOR(1 downto 0);
				Result, Set, CarryOut :out STD_LOGIC );
	end component;
	component NOR32 is
	port(	X:in std_logic_vector(n-1 downto 0);
			Y:out std_logic );
	end component;
	component XOR2 is
	port(	A,B: in std_logic;
			C:out std_logic	);
	end component;
	signal CARRY:STD_LOGIC_VECTOR(0 to n);
	signal ainvert, binvert: std_logic;
	signal operation: STD_LOGIC_VECTOR(1 downto 0);
	signal LESS:STD_LOGIC_VECTOR(0 to n-1);
	signal SETInternal:STD_LOGIC;
begin
	ainvert <= Oper(3);
	binvert <= Oper(2);
	operation <= Oper(1 downto 0);
	carry(0)<=binvert;
	g0: for j in 1 to n-1 generate
		LESS(j) <= '0';
	end generate g0;
	X1:XOR2 port map(carry(n),carry(n-1),Overflow);
	X2:XOR2 port map(SETInternal,Overflow,Less(0));
	Set <= Less(0);
	NOR1:NOR32 port map(Result,Zero);
	g1: for i in 0 to n-2 generate
		innerALU: ALU1 port map(a(i),b(i),ainvert,binvert,carry(i),LESS(i),operation,Result(i),open,carry(i+1));
	end generate g1;
	finalALU: ALU1 port map(a(n-1),b(n-1),ainvert,binvert,carry(n-1),LESS(n-1),operation,Result(n-1),SETInternal,carry(n));
end beh;