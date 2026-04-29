module duty_cycle_controller(
    input clk,
    input reset,
    input [1:0] energy_level,

    output reg duty_enable
);

reg [3:0] counter;

always @(posedge clk or posedge reset) begin
    if (reset)
        counter <= 0;
    else
        counter <= counter + 1;
end

always @(*) begin
    case(energy_level)

    2'b00: duty_enable = 0;          // OFF
    2'b01: duty_enable = (counter < 2);
    2'b10: duty_enable = (counter < 6);
    2'b11: duty_enable = 1;

    endcase
end

endmodule
