vlib work
vlog  +acc  "../ecbot.v"
vlog  +acc  "../dbusmux.v"
vlog  +acc  "../capture_block.v"
vlog  +acc  "../rcservo.v"
vlog  +acc  "../ecbot_TB.v"
vlog  +acc  "/opt/cad/Xilinx/verilog/src/glbl.v"
vsim -t 1ps   -L xilinxcorelib_ver -L unisims_ver  camera_TB_v glbl
view wave
do wave.do
add wave /glbl/GSR
view structure
view signals
run 15ms
