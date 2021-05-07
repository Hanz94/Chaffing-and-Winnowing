
// chaffing and winnowing implementation


module cw #(
	   parameter cwbits = 32,
     parameter ctrsize = 16,
     parameter tagsize = 16,
     parameter cachesize = 64
	)
  (  input clk,               
       input rstn,
       input wire [ctrsize-1:0] ctr,
       input wire [cwbits-1:0] msgIn,
       input wire[cachesize-1:0][tagsize -1:0] maccache,
       output reg[cwbits*2-1:0][ctrsize+tagsize: 0] msgOut
  );   
  

  integer j = 0 ;
  // reg[cachesize-1:0][tagsize -1:0] macCacheReg;

  always @ (posedge clk) begin
    // macCacheReg = maccache;

    for (j=0; j<cwbits; j++) begin
        msgOut[j*2] =  { msgIn[j], maccache[j], ctr};
        msgOut[j*2+1] =  { ~msgIn[j], maccache[cwbits -1 - j], ctr};
    end
  end

endmodule






// module cwMini #(
// 	   parameter cwbits = 32,
//      parameter ctrsize = 16,
//      parameter tagsize = 16,
//      parameter cachesize = 64
// 	)
//   (  input clk,               
//        input wire[1:0][1:0] rstn,
//        input wire [1:0]ctr,
//        output reg[1:0][2:0] msgOut
//   );   
  
//   integer j = 0 ;
//   always @ (posedge clk) begin
//     for (j=0; j<cwbits; j++) begin
//       msgOut[j] =  { ctr[j], rstn[j]};
//     end
//   end
  
// endmodule