
module pc(
   input wire clk, 
   input wire rst_n, 
   input wire [31:0] pc_in,
   output reg [31:0] pc_out
   );
   
   always@(posedge clk or negedge rst_n) begin : PC_FLOP
      if(!rst_n) begin //reset
         pc_out <= 32'h0000_0000;
      end else begin //active clock
         pc_out <= pc_in;
      end
   end : PC_FLOP
   
endmodule
