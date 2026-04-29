module power_fsm(
    input clk,
    input reset,
    input [1:0] energy_level,
    input trend_up,
    input stable,

    output reg esp32_en,
    output reg oled_en,
    output reg sensor_en,
    output reg sleep_mode
);

reg [2:0] state;
reg [2:0] next_state;

/* State Encoding */
parameter IDLE       = 3'b000,
          CHARGING   = 3'b001,
          LOW_POWER  = 3'b010,
          MED_POWER  = 3'b011,
          HIGH_POWER = 3'b100,
          SLEEP      = 3'b101;

/* State Register */
always @(posedge clk or posedge reset) begin
    if (reset)
        state <= IDLE;
    else
        state <= next_state;
end

/* Next State Logic */
always @(*) begin
    case (state)

        IDLE: begin
            if (energy_level != 2'b00)
                next_state = CHARGING;
            else
                next_state = IDLE;
        end

        CHARGING: begin
            if (energy_level == 2'b11)
                next_state = HIGH_POWER;
            else if (energy_level == 2'b10)
                next_state = MED_POWER;
            else if (energy_level == 2'b01)
                next_state = LOW_POWER;
            else
                next_state = CHARGING;
        end

        LOW_POWER: begin
            if (trend_up)
                next_state = MED_POWER;
            else
                next_state = SLEEP;
        end

        MED_POWER: begin
            if (stable)
                next_state = HIGH_POWER;
            else
                next_state = LOW_POWER;
        end

        HIGH_POWER: begin
            next_state = SLEEP;
        end

        SLEEP: begin
            next_state = IDLE;
        end

        default: begin
            next_state = IDLE;
        end

    endcase
end

/* Output Logic */
always @(*) begin
    esp32_en   = 1'b0;
    oled_en    = 1'b0;
    sensor_en  = 1'b0;
    sleep_mode = 1'b0;

    case (state)

        IDLE: begin
            esp32_en   = 1'b0;
            oled_en    = 1'b0;
            sensor_en  = 1'b0;
            sleep_mode = 1'b0;
        end

        CHARGING: begin
            esp32_en   = 1'b0;
            oled_en    = 1'b1;
            sensor_en  = 1'b0;
            sleep_mode = 1'b0;
        end

        LOW_POWER: begin
            esp32_en   = 1'b0;
            oled_en    = 1'b1;
            sensor_en  = 1'b1;
            sleep_mode = 1'b0;
        end

        MED_POWER: begin
            esp32_en   = 1'b0;
            oled_en    = 1'b1;
            sensor_en  = 1'b1;
            sleep_mode = 1'b0;
        end

        HIGH_POWER: begin
            esp32_en   = 1'b1;
            oled_en    = 1'b1;
            sensor_en  = 1'b1;
            sleep_mode = 1'b0;
        end

        SLEEP: begin
            esp32_en   = 1'b0;
            oled_en    = 1'b0;
            sensor_en  = 1'b0;
            sleep_mode = 1'b1;
        end

        default: begin
            esp32_en   = 1'b0;
            oled_en    = 1'b0;
            sensor_en  = 1'b0;
            sleep_mode = 1'b0;
        end

    endcase
end

endmodule
