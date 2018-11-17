-------------------------------------------------------------------------------
-- Title         : Single Instruction, Multiple Data - SUM operation 
-- Project       : Avaliação II
-------------------------------------------------------------------------------
-- File          : simd_sum.vhd
-- Author        : Pedro Messias Jose da Cunha Bastos
-- Created       : 2018-11-15
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity simd_sum is
	generic(
		WIDTH : natural := 4
	);
	port(
		sysclk   : in std_logic;
		reset_n  : in std_logic;
		add_op_i : in std_logic;
		data_a_i : in std_logic_vector(WIDTH-1 downto 0);
		data_b_i : in std_logic_vector(WIDTH-1 downto 0);
		done_o   : out std_logic;
		data_c_o : out std_logic_vector(WIDTH downto 0)
    );
end entity simd_sum;

architecture simd_sum_rtl of simd_sum is
	-- States of FMS
	type SIMB_SUM_ST_TYPE is (ST_IDLE, ST_OP, ST_END_OP);
	-- Signals
	signal state_reg    : SIMB_SUM_ST_TYPE;
  	signal state_next   : SIMB_SUM_ST_TYPE;
  	signal done_reg     : std_logic;
  	signal done_next    : std_logic;
  	signal dataout_reg  : std_logic_vector(WIDTH downto 0);
	signal dataout_next : std_logic_vector(WIDTH downto 0);
	signal result       : unsigned(WIDTH downto 0);
	
begin
	
	done_o   <= done_reg;
	data_c_o <= dataout_reg;

	process(reset_n, sysclk)
	begin

		if reset_n = '0' then
			state_reg   <= ST_IDLE;
			dataout_reg <= (others => '0');
			done_reg    <= '0';
    	elsif rising_edge(sysclk) then
      		state_reg   <= state_next;
      		dataout_reg <= dataout_next;
      		done_reg    <= done_next;
    	end if;

	end process;

	process (dataout_reg, done_reg, state_reg, add_op_i)
	begin

    state_next   <= state_reg;
    done_next    <= done_reg;
    dataout_next <= dataout_reg;

    case state_reg is

    	when ST_IDLE =>
    		if add_op_i = '1' then
    			state_next <= ST_OP;
    			done_next <= '0';
    		else
    			state_next <= ST_IDLE;
    			done_next <= '0';
			end if;
			
      	when ST_OP =>
      		if add_op_i = '1' then
      			state_next <= ST_END_OP;
        		result <= unsigned(("0" & data_a_i)) + unsigned(data_b_i);
      		end if;
      
  		when ST_END_OP =>
  			state_next <= ST_IDLE;
  			dataout_next <= std_logic_vector(result);
  			done_next <= '1';
  			
	end case;

	end process;

end architecture simd_sum_rtl;
