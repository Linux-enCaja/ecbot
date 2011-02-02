library verilog;
use verilog.vl_types.all;
entity DBUSMUX is
    generic(
        BW              : integer := 15
    );
    port(
        DIUART0         : in     vl_logic_vector;
        DIUART1         : in     vl_logic_vector;
        DIUART2         : in     vl_logic_vector;
        DIUART3         : in     vl_logic_vector;
        DIPIC           : in     vl_logic_vector;
        DICONS          : in     vl_logic_vector;
        CSUART0         : in     vl_logic;
        CSUART1         : in     vl_logic;
        CSUART2         : in     vl_logic;
        CSUART3         : in     vl_logic;
        CSPIC           : in     vl_logic;
        CSCONS          : in     vl_logic;
        nRW             : in     vl_logic;
        DO              : out    vl_logic_vector
    );
end DBUSMUX;
