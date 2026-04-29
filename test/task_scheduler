module task_scheduler(
    input clk,
    input reset,
    input esp32_en,

    output reg sensor_read,
    output reg data_tx,
    output reg oled_update
);

reg [2:0] state;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 0;
    else if (esp32_en)
        state <= state + 1;
    else
        state <= 0;
end

always @(*) begin
    sensor_read  = (state == 3'd1);
    oled_update  = (state == 3'd3);
    data_tx      = (state == 3'd5);
end

endmodule
