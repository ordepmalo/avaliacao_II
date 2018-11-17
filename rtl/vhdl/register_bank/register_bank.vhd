-------------------------------------------------------------------------------
-- Title         : Register Bank
-- Project       : Avaliação II
-------------------------------------------------------------------------------
-- File          : register_bank.vhd
-- Author        : Pedro Messias Jose da Cunha Bastos
-- Created       : 2018-11-12
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity register_bank is
	generic(
		WIDTH : integer := 32
	);
	port(
		sysclk      : in  std_logic;
		reset_n     : in  std_logic;
		rd_a_addr_i : in  std_logic_vector(integer(ceil(log2(real(WIDTH))))-1 downto 0);
		rd_b_addr_i : in  std_logic_vector(integer(ceil(log2(real(WIDTH))))-1 downto 0);
		a_data_o    : out std_logic_vector(WIDTH-1 downto 0);
		b_data_o    : out std_logic_vector(WIDTH-1 downto 0);
		wrt_en_i    : in  std_logic;
		wrt_addr_i  : in  std_logic_vector(integer(ceil(log2(real(WIDTH))))-1 downto 0);
		wrt_data_i  : in  std_logic_vector(WIDTH-1 downto 0)
	);
end entity register_bank;

architecture register_bank_rtl of register_bank is

-- Register_n component declaration
component register_n
	generic(
		WIDTH : natural := 32
	);
	port(
		sysclk        : in  std_logic;
		clk_enable_i  : in  std_logic;
		syn_reset_n_i : in  std_logic;
		data_i        : in  std_logic_vector(WIDTH - 1 downto 0);
		data_o        : out std_logic_vector(WIDTH - 1 downto 0)
	);
end component register_n;

-- Register array
type reg_array is array (0 to WIDTH-1) of std_logic_vector(WIDTH - 1 downto 0);
signal registers   : reg_array := (others => (others => '0'));

-- Select register signal
signal reg_sel_int : std_logic_vector(WIDTH-1 downto 0);	
	
begin
	
	register_gen : for i in 0 to WIDTH-1 generate
   	reg_s : entity work.register_n
        generic map(
      	       WIDTH => 32
        )
        port map(
        	sysclk		  => sysclk,
    	    clk_enable_i  => reg_sel_int(i),
		    syn_reset_n_i => reset_n,
		    data_i		  => wrt_data_i,     
		    data_o        => registers(i)
		);
	end generate;
	
	write_register_bank : process(reset_n, sysclk)
	begin

		if reset_n = '0' then
			reg_sel_int <= (others => '0');
		elsif rising_edge(sysclk) then
			reg_sel_int <= (others => '0');
			if wrt_en_i = '1' then
				reg_sel_int(to_integer(unsigned(wrt_addr_i))) <= '1';
			end if;
		end if;

	end process write_register_bank;
	
	read_register_bank : process(reset_n, sysclk)
	begin
		
		if reset_n = '0' then
			a_data_o <= (others => '0');
			b_data_o <= (others => '0');
		elsif rising_edge(sysclk) then
			a_data_o <= registers(to_integer(unsigned(rd_a_addr_i)));
			b_data_o <= registers(to_integer(unsigned(rd_b_addr_i)));
		end if;
		
	end process read_register_bank;

end architecture register_bank_rtl;
