
// chaffing and winnowing implementation


module cw #(
	   parameter cwbits = 32,
     parameter ctrsize = 16,
     parameter tagsize = 16,
     parameter cachesize = 10
	)
    (  input clk,               
       input rstn,
       output reg[ctrsize+tagsize: 0] out [0:cwbits*2-1]);   
  
  reg[tagsize -1 : 0] maccache [0:cachesize];

  integer j = 0 ;
  always @ (posedge clk) begin
    for (j=0; j<cwbits; j++) begin
        out[j*2][1] =  maccache[1][1];
        out[j*2+1][1] =  maccache[1][1];
    end
  end
endmodule