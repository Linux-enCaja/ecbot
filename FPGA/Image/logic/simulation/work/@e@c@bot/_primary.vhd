library verilog;
use verilog.vl_types.all;
entity ECBot is
    generic(
        DW              : integer := 15;
        AW              : integer := 11
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        led             : out    vl_logic;
        sram_data       : inout  vl_logic_vector;
        addr            : in     vl_logic_vector;
        nwe             : in     vl_logic;
        ncs             : in     vl_logic;
        noe             : in     vl_logic;
        capture_trigger : in     vl_logic;
        capture_done    : out    vl_logic;
        crst            : out    vl_logic;
        cvsync          : in     vl_logic;
        chsync          : in     vl_logic;
        cvclk           : in     vl_logic;
        cmclk           : out    vl_logic;
        ycbcr           : in     vl_logic_vector(7 downto 0);
        snap            : out    vl_logic;
        P               : out    vl_logic_vector(9 downto 0)
    );
end ECBot;
