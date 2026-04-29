/*
 * SPDX-FileCopyrightText: © 2026 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_rf_energy_harvesting (
    input  wire [7:0] ui_in,     // Dedicated inputs
    output wire [7:0] uo_out,    // Dedicated outputs
    input  wire [7:0] uio_in,    // IOs: Input path
    output wire [7:0] uio_out,   // IOs: Output path
    output wire [7:0] uio_oe,    // IOs: Enable path
    input  wire       ena,       // always 1 when design is powered
    input  wire       clk,       // clock
    input  wire       rst_n      // reset_n (active low)
);

wire reset;
assign reset = ~rst_n;

/* Internal outputs */
wire esp32_power;
wire oled_power;
wire sensor_power;
wire sensor_read;
wire data_tx;
wire oled_update;
wire sleep_mode;
wire duty_enable;

/* Instantiate your main design */

top_rf_energy_soc uut (
    .clk(clk),
    .reset(reset),
    .rf_energy(ui_in),

    .esp32_power(esp32_power),
    .oled_power(oled_power),
    .sensor_power(sensor_power),
    .sensor_read(sensor_read),
    .data_tx(data_tx),
    .oled_update(oled_update),
    .sleep_mode(sleep_mode),
    .duty_enable(duty_enable)
);

/* Map outputs */

assign uo_out[0] = esp32_power;
assign uo_out[1] = oled_power;
assign uo_out[2] = sensor_power;
assign uo_out[3] = sensor_read;
assign uo_out[4] = data_tx;
assign uo_out[5] = oled_update;
assign uo_out[6] = sleep_mode;
assign uo_out[7] = duty_enable;

/* Unused bidirectional pins */

assign uio_out = 8'b0;
assign uio_oe  = 8'b0;

wire _unused = &{ena, uio_in, 1'b0};

endmodule

`default_nettype wire
