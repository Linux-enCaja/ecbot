library verilog;
use verilog.vl_types.all;
entity RCServo is
    generic(
        NUM_SERVO       : integer := 10
    );
    port(
        Addr            : in     vl_logic_vector(4 downto 0);
        DataRd          : out    vl_logic_vector(15 downto 0);
        DataWr          : in     vl_logic_vector(15 downto 0);
        En              : in     vl_logic;
        Wr              : in     vl_logic;
        P               : out    vl_logic_vector;
        Clk             : in     vl_logic
    );
end RCServo;
