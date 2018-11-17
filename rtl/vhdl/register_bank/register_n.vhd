-------------------------------------------------------------------------------
-- Title         : Register N bits
-- Project       : Exercise
-------------------------------------------------------------------------------
-- File          : register_n.vhd
-- Author        : Pedro Messias Jose da Cunha Bastos
-- Company       : 
-- Created       : 2018-09-07
-- Last update   : 2018-09-10
-- Target Device : 
-- Standard      : VHDL'93/02
-------------------------------------------------------------------------------
-- Description   : 
-------------------------------------------------------------------------------
-- Copyright (c) 2018
-------------------------------------------------------------------------------
-- Revisions     :
-- Date        Version  Author  Description
-- 2018-09-07  1.0      Ordep   Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register_n is
	generic(
		WIDTH : natural := 32
	);
	
	port(
		sysclk 		  : in std_logic;
		clk_enable_i  : in std_logic;
		syn_reset_n_i : in std_logic;
		data_i		  : in std_logic_vector(WIDTH-1 downto 0);
		data_o		  : out std_logic_vector(WIDTH-1 downto 0)		
	);
end entity register_n;

architecture register_n_rtl of register_n is
	
begin
	process(sysclk, syn_reset_n_i, clk_enable_i)
	
	begin
		if syn_reset_n_i = '0' then
			data_o <= (others => '0');
		else
			if clk_enable_i = '1' then
				if rising_edge(sysclk) then
					data_o <= data_i;
				end if;
			end if;
		end if;		
	end process;

end architecture register_n_rtl;
