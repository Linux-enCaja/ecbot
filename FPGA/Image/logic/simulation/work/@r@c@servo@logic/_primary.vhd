library verilog;
use verilog.vl_types.all;
entity RCServoLogic is
    generic(
        NUM_PWM         : integer := 2
    );
    port(
        ChannelReg      : in     vl_logic_vector;
        ChannelOut      : out    vl_logic_vector;
        Clk             : in     vl_logic
    );
end RCServoLogic;
