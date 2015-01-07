library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_signed.all;

entity ShiftLeft2 is
  port( x : in std_logic_vector(31 downto 0);
        y : out std_logic_vector(31 downto 0)
      );
end ShiftLeft2;
architecture beh of ShiftLeft2 is
begin
  process
    variable temp : std_logic_vector(31 downto 0);
  begin
    temp(31 downto 2):=x(29 downto 0);
    temp(1 downto 0):="00";
    y<=temp;
  end process;
end beh;