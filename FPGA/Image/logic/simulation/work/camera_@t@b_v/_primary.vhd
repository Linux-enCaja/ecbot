library verilog;
use verilog.vl_types.all;
entity camera_TB_v is
    generic(
        PERIOD          : integer := 20;
        DUTY_CYCLE      : real    := 0.500000;
        OFFSET          : integer := 0;
        TSET            : integer := 3;
        THLD            : integer := 3;
        NWS             : integer := 3;
        CAM_OFF         : integer := 4000
    );
end camera_TB_v;
