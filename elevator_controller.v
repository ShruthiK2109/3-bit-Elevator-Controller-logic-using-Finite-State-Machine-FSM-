`timescale 1ns/1ps

module elevator_controller (
input wire clk,
input wire rst,
input wire [2:0] current_floor,
input wire [2:0] requested_floor,
output reg [2:0] next_floor);

// State encoding
localparam IDLE = 3'b000;
localparam UP = 3'b001;
localparam DOWN = 3'b010;

// Internal signals
reg [2:0] state, next_state;

//FSM Controller
always @(posedge clk or posedge rst)
begin
if(rst)
begin
state <= IDLE;
next_state <= IDLE;
next_floor <= 3'b000; // Initial floor (door will be closed)
end
else begin
state <= next_state;
next_floor <= (state == UP) ? (current_floor + 1):
              (state == DOWN) ? (current_floor - 1):
              next_floor;

case(state)

IDLE: begin
if (requested_floor > current_floor)
next_state <= UP;
else if (requested_floor < current_floor)
next_state <= DOWN;

end

UP: begin
if (next_floor == requested_floor)
next_state <= IDLE;
else if (next_floor < requested_floor)
next_state <= UP;
else 
next_state <= DOWN;
end 

DOWN: begin
if (next_floor == requested_floor)
next_state <= IDLE;
else if (next_floor > requested_floor)
next_state <= DOWN;
else 
next_state <= UP;
end 
endcase
end
end

endmodule
