module energy_predictor(
    input clk,
    input reset,
    input [7:0] energy_in,

    output reg trend_up,
    output reg stable
);

reg [7:0] prev;
reg [7:0] diff;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        prev <= 0;
        trend_up <= 0;
        stable <= 0;
    end else begin
        diff = (energy_in > prev) ? (energy_in - prev) : (prev - energy_in);

        trend_up <= (energy_in > prev);

        // stability detection
        stable <= (diff < 5);

        prev <= energy_in;
    end
end

endmodule
