module energy_level_detector(
    input  [7:0] rf_energy,
    output reg [1:0] level,
    output reg valid
);

always @(*) begin
    valid = 1'b1;

    if (rf_energy < 20)
        level = 2'b00; // NO ENERGY
    else if (rf_energy < 50)
        level = 2'b01; // LOW
    else if (rf_energy < 80)
        level = 2'b10; // MEDIUM
    else
        level = 2'b11; // HIGH
end

endmodule
