module power_gating_unit(
    input esp32_en,
    input oled_en,
    input sensor_en,

    output reg esp32_power,
    output reg oled_power,
    output reg sensor_power
);

always @(*) begin
    esp32_power  = esp32_en;
    oled_power   = oled_en;
    sensor_power = sensor_en;
end

endmodule
