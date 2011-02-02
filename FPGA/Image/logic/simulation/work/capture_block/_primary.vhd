library verilog;
use verilog.vl_types.all;
entity capture_block is
    generic(
        DW              : integer := 15;
        AW              : integer := 11;
        MC              : integer := 4;
        init            : integer := 0;
        start           : integer := 1;
        new_row         : integer := 2;
        new_pixel       : integer := 3;
        wr_bytes        : integer := 4;
        wr_mem          : integer := 6;
        up_mem          : integer := 7;
        resume          : integer := 5;
        resume2         : integer := 13;
        inc_row         : integer := 14;
        new_frame       : integer := 15;
        RESET_ALL       : integer := 28;
        RESET_MEM       : integer := 28;
        ENAB_MCLK       : integer := 12;
        LD_MEM          : integer := 76;
        WRITE_MEM       : integer := 4;
        INCR_MEM        : integer := 44;
        DONE_ROW        : integer := 30;
        DIS_MCLK        : integer := 26;
        INCR_ROW        : integer := 29
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        c_trigg         : in     vl_logic;
        c_done          : out    vl_logic;
        mem_data        : out    vl_logic_vector;
        in_mem_data     : in     vl_logic_vector;
        mem_addr        : out    vl_logic_vector;
        mem_we          : out    vl_logic;
        crst            : out    vl_logic;
        mclk            : out    vl_logic;
        vclk            : in     vl_logic;
        hsync           : in     vl_logic;
        vsync           : in     vl_logic;
        pixel_data      : in     vl_logic_vector(7 downto 0)
    );
end capture_block;
