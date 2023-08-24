`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/23/2023 05:05:28 PM
// Design Name: FIFO
// Module Name: fifo
// Project Name: fifo
// Target Devices: Artix-7 AC701 Evaluation Platform (xc7a200tfbg676-2)
// Tool Versions: 2021.2
// Description: This is the design of FIFO 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module fifo( 
  input clock, rd, wr,
  output full, empty,
  input [7:0] data_in,
  output reg [7:0] data_out,
  input rst);
 
  integer i;
  reg [7:0] mem [31:0];
  reg [4:0] wr_ptr;
  reg [4:0] rd_ptr; 
     
always@(posedge clock)    
  begin
    if (rst == 1'b1)
      begin
        data_out <= 0;
        rd_ptr <= 0;
        wr_ptr <= 0;
        for(i=0; i < 32; i=i+1) begin
          mem[i] <= 0;
        end
      end
    else
      begin
        if ((wr == 1'b1)  && (full == 1'b0))
          begin
          mem[wr_ptr] <= data_in;
          wr_ptr = wr_ptr + 1;
          end
        
        if((rd == 1'b1) && (empty == 1'b0))
          begin
          data_out <= mem[rd_ptr];
          rd_ptr <= rd_ptr + 1;
          end

      end
end
  
  
assign empty = ((wr_ptr - rd_ptr) == 0) ? 1'b1 : 1'b0;   
assign full = ((wr_ptr - rd_ptr) == 31) ? 1'b1 : 1'b0;   
endmodule
