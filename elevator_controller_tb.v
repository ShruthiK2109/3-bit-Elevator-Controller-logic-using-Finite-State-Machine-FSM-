`timescale 1ns/1ps
module elevator_controller_tb;

//Inputs 
reg clk, rst;
reg [2:0] current_floor, requested_floor;

//Outputs
wire [2:0] next_floor;

// Instantiate the elevator controller
elevator_controller uut (
.clk (clk),
.rst (rst),
.current_floor (current_floor),
.requested_floor (requested_floor),
.next_floor (next_floor));

// clock generation
initial begin
clk = 0;
forever #5 clk = ~clk;
end

//Stimulus
initial begin
rst = 1;
current_floor = 3'b000;
requested_floor = 3'b001; // request floor 1

// Reset and wait for a few clock cycles
#10 rst = 0;

// Test case 1: Move UP
#10 requested_floor = 3'b010; // request floor 2
#10 requested_floor = 3'b011; // request floor 3

// Test case 2: Move DOWM
#10 requested_floor = 3'b001; // request floor 1
#10 requested_floor = 3'b000; // request floor 0

// Test case 3: Stay IDLE
#10 requested_floor = 3'b011; // request floor 3

#100 $finish; // End simulation after 100 time units
end
endmodule
