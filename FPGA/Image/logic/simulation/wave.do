onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic -radix hexadecimal /camera_TB_v/clk
add wave -noupdate -format Logic -radix decimal /camera_TB_v/reset
add wave -noupdate -format Literal -radix hexadecimal /camera_TB_v/uut/addr
add wave -noupdate -format Logic /camera_TB_v/uut/ncs
add wave -noupdate -format Logic /camera_TB_v/uut/noe
add wave -noupdate -format Logic /camera_TB_v/uut/nwe
add wave -noupdate -format Literal /camera_TB_v/uut/camera/state
add wave -noupdate -format Logic -radix decimal /camera_TB_v/cvsync
add wave -noupdate -format Logic -radix decimal /camera_TB_v/chsync
add wave -noupdate -format Logic /camera_TB_v/cmclk
add wave -noupdate -format Logic -radix decimal /camera_TB_v/cvclk
add wave -noupdate -format Logic /camera_TB_v/uut/camera/e_mclk
add wave -noupdate -format Logic -radix decimal /camera_TB_v/capture_trigger
add wave -noupdate -format Logic /camera_TB_v/uut/cap_trig
add wave -noupdate -format Logic /camera_TB_v/uut/sncap_trig
add wave -noupdate -format Logic /camera_TB_v/uut/camera/togg_row
add wave -noupdate -format Literal -radix decimal /camera_TB_v/uut/camera/row_count
add wave -noupdate -format Logic /camera_TB_v/uut/camera/mem_full
add wave -noupdate -format Logic /camera_TB_v/uut/camera/rst_mem
add wave -noupdate -format Logic -radix decimal /camera_TB_v/capture_done
add wave -noupdate -format Logic /camera_TB_v/uut/camera/read_mem
add wave -noupdate -format Logic /camera_TB_v/uut/camera/load_mem
add wave -noupdate -format Logic /camera_TB_v/uut/camera/mem_we
add wave -noupdate -format Literal -radix hexadecimal /camera_TB_v/uut/camera/mem_addr
add wave -noupdate -format Literal -radix hexadecimal /camera_TB_v/uut/camera/pixel_count
add wave -noupdate -format Literal -radix hexadecimal /camera_TB_v/uut/camera/mem_data
add wave -noupdate -format Literal -radix hexadecimal /camera_TB_v/uut/camera/in_mem_data
add wave -noupdate -format Logic -radix hexadecimal /camera_TB_v/uut/camera/inc_mem
add wave -noupdate -format Literal -radix hexadecimal /camera_TB_v/ycbcr
add wave -noupdate -format Literal -radix hexadecimal {/camera_TB_v/uut/ba0/mem[29]}
add wave -noupdate -format Literal -radix hexadecimal {/camera_TB_v/uut/ba0/mem[28]}
add wave -noupdate -format Literal -radix hexadecimal {/camera_TB_v/uut/ba0/mem[27]}
add wave -noupdate -format Literal -radix hexadecimal {/camera_TB_v/uut/ba0/mem[26]}
add wave -noupdate -format Literal -radix hexadecimal {/camera_TB_v/uut/ba3/mem[4]}
add wave -noupdate -format Literal -radix hexadecimal {/camera_TB_v/uut/ba3/mem[3]}
add wave -noupdate -format Literal -radix hexadecimal {/camera_TB_v/uut/ba3/mem[2]}
add wave -noupdate -format Literal -radix hexadecimal {/camera_TB_v/uut/ba3/mem[1]}
add wave -noupdate -format Literal -radix hexadecimal {/camera_TB_v/uut/ba3/mem[0]}
add wave -noupdate -format Literal -radix hexadecimal {/camera_TB_v/uut/ba2/mem[4]}
add wave -noupdate -format Literal -radix hexadecimal {/camera_TB_v/uut/ba2/mem[3]}
add wave -noupdate -format Literal -radix hexadecimal {/camera_TB_v/uut/ba2/mem[2]}
add wave -noupdate -format Literal -radix hexadecimal {/camera_TB_v/uut/ba2/mem[1]}
add wave -noupdate -format Literal -radix hexadecimal {/camera_TB_v/uut/ba2/mem[0]}
add wave -noupdate -format Literal -radix hexadecimal {/camera_TB_v/uut/ba1/mem[4]}
add wave -noupdate -format Literal -radix hexadecimal {/camera_TB_v/uut/ba1/mem[3]}
add wave -noupdate -format Literal -radix hexadecimal {/camera_TB_v/uut/ba1/mem[2]}
add wave -noupdate -format Literal -radix hexadecimal {/camera_TB_v/uut/ba1/mem[1]}
add wave -noupdate -format Literal -radix hexadecimal {/camera_TB_v/uut/ba1/mem[0]}
add wave -noupdate -format Literal -radix hexadecimal {/camera_TB_v/uut/ba0/mem[4]}
add wave -noupdate -format Literal -radix hexadecimal {/camera_TB_v/uut/ba0/mem[3]}
add wave -noupdate -format Literal -radix hexadecimal {/camera_TB_v/uut/ba0/mem[2]}
add wave -noupdate -format Literal -radix hexadecimal {/camera_TB_v/uut/ba0/mem[1]}
add wave -noupdate -format Literal -radix hexadecimal {/camera_TB_v/uut/ba0/mem[0]}
add wave -noupdate -format Literal -radix decimal {/camera_TB_v/sram_data$inout$reg}
add wave -noupdate -format Logic -radix decimal /camera_TB_v/crst
add wave -noupdate -format Logic -radix decimal /camera_TB_v/snap
add wave -noupdate -format Logic /glbl/GSR
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {8133045 ps} 0}
configure wave -namecolwidth 305
configure wave -valuecolwidth 40
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
update
WaveRestoreZoom {0 ps} {30761720 ps}
