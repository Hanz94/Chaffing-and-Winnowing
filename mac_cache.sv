module cw #(
     parameter ctrsize = 16,
     parameter tagsize = 16,
     parameter cachesize = 64
	)
  (    input clk,               
       input wire[cachesize-1:0][tagsize -1:0] maccache,
       output reg[cachesize-1:0][tagsize -1:0] maccacheOut
  );   
  

  integer j = 0 ;

  always @ (posedge clk) begin

    for (j=0; j<cachesize; j++) begin
        maccacheOut[j] =  maccache[cachesize - j - 1];
    end
  end

endmodule