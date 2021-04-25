// Message length -: 512, n =16, s=8

module aont #(
	  parameter msglen = 512,
      parameter noofblocks = 8,
      parameter lslen = 16,
      parameter lslenlog = 4
	)
    (  input clk,               
       input rstn,
       input wire [msglen-1:0] msgIn,
       // down must not be input
       input wire [lslen - 1:0][lslenlog-1:0] k,
       output reg [lslen*lslenlog*noofblocks -1 : 0] msgOut
    ); 
  
  reg[lslen - 1:0][lslenlog-1:0] leader ;
  reg[noofblocks-1:0][lslen - 1:0][lslenlog-1:0] etemp ;
  reg[noofblocks-1:0][lslen - 1:0][lslenlog-1:0] b ;
  integer j = 0 ;

  wire[lslen-1:0][lslen-1:0][lslenlog-1:0] latinsquare;

  latin_square ls (clk, k, latinsquare);

  always @ (posedge clk) begin

    leader[j] = k[0][0];
    for (j=1; j<lslen; j=j+1) begin
        leader[j] = latinsquare[k[1]][leader[0]];
    end
  end

endmodule