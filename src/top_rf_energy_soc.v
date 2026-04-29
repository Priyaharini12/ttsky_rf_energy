module top_rf_energy_soc(
    input clk,
    input reset,
    input [7:0] rf_energy,

    output esp32_power,
    output oled_power,
    output sensor_power,
    output sensor_read,
    output data_tx,
    output oled_update,
    output sleep_mode,
    output duty_enable
);

/* Internal Wires */
wire [1:0] level;
wire trend_up;
wire stable;

wire esp32_en;
wire oled_en;
wire sensor_en;

/* Module 1 : Energy Level Detector */
energy_level_detector u1 (
    .rf_energy(rf_energy),
    .level(level),
    .valid()
);

/* Module 2 : Energy Predictor */
energy_predictor u2 (
    .clk(clk),
    .reset(reset),
    .energy_in(rf_energy),
    .trend_up(trend_up),
    .stable(stable)
);

/* Module 3 : Power FSM */
power_fsm u3 (
    .clk(clk),
    .reset(reset),
    .energy_level(level),
    .trend_up(trend_up),
    .stable(stable),
    .esp32_en(esp32_en),
    .oled_en(oled_en),
    .sensor_en(sensor_en),
    .sleep_mode(sleep_mode)
);

/* Module 4 : Task Scheduler */
task_scheduler u4 (
    .clk(clk),
    .reset(reset),
    .esp32_en(esp32_en),
    .sensor_read(sensor_read),
    .data_tx(data_tx),
    .oled_update(oled_update)
);

/* Module 5 : Power Gating Unit */
power_gating_unit u5 (
    .esp32_en(esp32_en),
    .oled_en(oled_en),
    .sensor_en(sensor_en),
    .esp32_power(esp32_power),
    .oled_power(oled_power),
    .sensor_power(sensor_power)
);

/* Module 6 : Duty Cycle Controller */
duty_cycle_controller u6 (
    .clk(clk),
    .reset(reset),
    .energy_level(level),
    .duty_enable(duty_enable)
);

endmodule
