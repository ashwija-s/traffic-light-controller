`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.10.2025 19:46:33
// Design Name: 
// Module Name: traffic_light
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////




module traffic_light (
    input wire clk,
    input wire reset,
    output reg [2:0] lights // {Red, Yellow, Green}
);

    reg [1:0] state; // 2-bit state machine
    reg [23:0] counter; // for delay

    // Parameters for states
    parameter RED = 2'b00, GREEN = 2'b01, YELLOW = 2'b10;
    
    // --- State and Counter Logic (Synchronous) ---
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= RED;
            counter <= 0;
        end else begin
            counter <= counter + 1;
            case (state)
                RED: begin
                    if (counter == 24'd5) begin
                        state <= GREEN;
                        counter <= 0; // Reset counter for the next state
                    end
                end
                GREEN: begin
                    if (counter == 24'd5) begin
                        state <= YELLOW;
                        counter <= 0;
                    end
                end
                YELLOW: begin
                    if (counter == 24'd2) begin
                        state <= RED;
                        counter <= 0;
                    end
                end
            endcase
        end
    end
    
    // --- Output Logic (Combinational) ---
    // This block determines the lights based on the current state
    always @(*) begin
        case (state)
            RED: lights = 3'b100; // Red ON
            GREEN: lights = 3'b001; // Green ON
            YELLOW: lights = 3'b010; // Yellow ON
            default: lights = 3'b000; // All OFF for a safe default
        endcase
    end

endmodule