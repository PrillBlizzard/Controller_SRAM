----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.11.2025 09:08:22
-- Design Name: 
-- Module Name: tb_state_machine - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_state_machine is
--  Port ( );
end tb_state_machine;

architecture Behavioral of tb_state_machine is

component state_machine 
        Port ( read_write : in STD_LOGIC;
           burst : in STD_LOGIC;
           idle : in STD_LOGIC;
           CLK : in STD_LOGIC;
           ST_CTRL : out STD_LOGIC_VECTOR (1 downto 0);
           T : out STD_LOGIC); 
end component;

signal sRead_Write: STD_LOGIC;
signal sBurst: STD_LOGIC;
signal sIdle: STD_LOGIC;
signal sCLK: STD_LOGIC;

signal sST_CTRL: STD_LOGIC_VECTOR(1 downto 0);
signal sT: STD_LOGIC;

signal clock_period: time := 20ns;

begin

DSM : component state_machine port map (read_write => sRead_Write,
                                       burst => sBurst,
                                       idle => sIdle,
                                       CLK => sCLK,
                                       ST_CTRL => sST_CTRL,
                                       T => sT );
    
stimulus: process
begin

sread_write <= '0';       -- nOP 1
sBurst <= '0';
sIdle <= '1';

wait for 10*clock_period;

sread_write <= '0';       -- Read 2
sBurst <= '0';
sIdle <= '0';
wait for 3*clock_period;


sread_write <= '0';        -- nOP 3
sBurst <= '0';
sIdle <= '1';
wait for 3*clock_period;


sread_write <= '1';        -- write 4
sBurst <= '0';
sIdle <= '0';
wait for 3*clock_period;

sread_write <= '0';        -- nOP 5
sBurst <= '0';
sIdle <= '1';
wait for 3*clock_period;

sread_write <= '1';        -- write 6
sBurst <= '0';
sIdle <= '0';
wait for 3*clock_period;

sread_write <= '1';        -- write burst 7
sBurst <= '1';
sIdle <= '0';
wait for 3*clock_period;

sread_write <= '1';        -- write 8
sBurst <= '0';
sIdle <= '0';
wait for 3*clock_period;

sread_write <= '1';        -- write burst 9
sBurst <= '1';
sIdle <= '0';
wait for 3*clock_period;

sread_write <= '0';        -- nOP 10
sBurst <= '0';
sIdle <= '1';
wait for 3*clock_period;

sread_write <= '1';        -- write 11
sBurst <= '0';
sIdle <= '0';
wait for 3*clock_period;

sread_write <= '1';        -- write burst 12
sBurst <= '1';
sIdle <= '0';
wait for 3*clock_period;

sread_write <= '0';       -- Read 13
sBurst <= '0';
sIdle <= '0';
wait for 3*clock_period;

sread_write <= '0';       -- Read burst 14
sBurst <= '1';
sIdle <= '0';
wait for 3*clock_period;

sread_write <= '0';        -- nOP 15
sBurst <= '0';
sIdle <= '1';
wait for 3*clock_period;

sread_write <= '0';       -- Read 16
sBurst <= '0';
sIdle <= '0';
wait for 3*clock_period;

sread_write <= '0';       -- Read burst 17 
sBurst <= '1';
sIdle <= '0';
wait for 3*clock_period;

sread_write <= '1';        -- write 18
sBurst <= '0';
sIdle <= '0';
wait for 3*clock_period;

sread_write <= '0';        -- nOP 19
sBurst <= '0';
sIdle <= '1';
wait for 3*clock_period;


end process stimulus;



clokcing: process
begin
     sCLK <= '0';
     wait for clock_period/2;
     sCLK <= '1';
     wait for clock_period/2;
end process clokcing;      


end Behavioral;
