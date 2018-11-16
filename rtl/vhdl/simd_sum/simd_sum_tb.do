-------------------------------------------------------------------------------
-- Title         : Single Instruction, Multiple Data - SUM operation 
-- Project       : Avalia��o II
-------------------------------------------------------------------------------
-- File          : simd_sum_tb.do
-- Author        : Pedro Messias Jose da Cunha Bastos
-- Created       : 2018-11-15
-------------------------------------------------------------------------------

#Cria biblioteca do projeto
vlib work

#compila projeto: todos os aquivo. Ordem é importante
vcom simd_sum.vhd 
vcom simd_sum_tb.vhd

#Simula (work é o diretorio, testbench é o nome da entity)
vsim -t ns work.testbench

#Mosta forma de onda
view wave

#Adiciona ondas específicas
# -radix: binary, hex, dec
# -label: nome da forma de onda
add wave -radix binary /dut/sysclk
add wave -radix binary /dut/reset_n
add wave -radix binary /dut/state_next
add wave -radix binary /dut/add_op_i
add wave -radix hex /dut/data_a_i
add wave -radix hex /dut/data_b_i
add wave -radix binary /dut/done_o
add wave -radix hex /dut/data_c_o

#Como mostrar sinais internos do processo

#Simula até um 500ns
run 500us

wave zoomfull
write wave wave.ps
