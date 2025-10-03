`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.10.2025 19:50:40
// Design Name: 
// Module Name: traffic_light_tb
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




module tb_traffic_light;

    // Corrected signal width for 'lights' (3 bits, matching the DUT)
    logic clk;
    logic reset;
    logic [2:0] lights; // Corrected from [1:0] to [2:0]

    // Instantiate DUT (Design Under Test)
    traffic_light dut (
        .clk(clk),
        .reset(reset),
        .lights(lights)
    );

    // Clock generation: 10ns period (5ns high, 5ns low)
    initial clk = 0;
    always #5 clk = ~clk;

    // Stimulus
    initial begin
        // Monitor outputs
        $monitor("Time=%0t | state=%b | counter=%d | lights=%b (R-Y-G)", $time, dut.state, dut.counter, lights);

        // 1. Apply Reset
        reset = 1;
        #20; // Hold reset for 2 clock cycles
        reset = 0;

        // 2. Run for a sufficient duration
        // We need 120,000,000 ns to see one full cycle.
        // We will run for 150,000,000 ns to observe the transitions clearly.
        $display("--- Starting Simulation ---");
        $display("Simulation requires 120,000,000 ns to see one full light cycle.");
        #2000; 

        // 3. Stop Simulation
        $finish;
    end

endmodule

