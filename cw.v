// module aont #(
// 	 parameter messgalen = 512,
//       parameter noofblocks = 9,
//       parameter lslen = 16,
//       parameter lslenlog = 4
// 	)
//     (  input clk,               
//        input rstn,
//        input [messgalen-1:0] messageIn 
//     ); 
  
//   reg[lslenlog-1:0] latinsquare [0:lslen-1] [0:lslen-1];
//   reg[lslenlog-1:0] etemp [0:noofblocks-1] [0: lslen - 1];
//   reg[lslenlog-1:0] b [0:noofblocks-1] [0: lslen - 1];
//   integer j = 0 ;
//   integer i = 1 ;

//   always @ (posedge clk) begin
//     for (i=1; i<lslen; i++) begin
//         for (j=0; j<4; j++) begin
//             latinsquare[i][j] = ( i * 1 ) % 4 ;
//         end
//     end

//     for (i=0; i<noofblocks; i++) begin
//         for (j=0; j<lslen; j++) begin
//             etemp[i][j] = latinsquare[i][j];
//         end
//         for (j=0; j<4; j++) begin
//             b[i][j] = latinsquare[i][j] ;
//         end
//     end
//   end

// endmodule


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





// module counter (  input clk,               
//                   input rstn );   

//   reg[1:0] out [0:3] [0:3];
//   integer j = 0 ;
//   always @ (posedge clk) begin
//     for (j=0; j<4; j++) begin
//         out[1][j] = ( 1 * 1 ) % 4 ;
//         $display("%b",out[1][j]);
//     end
//   end
// endmodule






// module main;
//   reg clk;                     // Declare an internal TB variable called clk to drive clock to the design
//   reg rstn;                    // Declare an internal TB variable called rstn to drive active low reset to design
//   wire[1:0] out [3:0] [3:0];              // Declare a wire to connect to design output

//   // Instantiate counter design and connect with Testbench variables
//   counter   c0 ( .clk (clk),
//                  .rstn (rstn));

//   // Generate a clock that should be driven to design
//   // This clock will flip its value every 5ns -> time period = 10ns -> freq = 100 MHz
//   always #5 clk = ~clk;

//   // This initial block forms the stimulus of the testbench
//   initial begin
//     // $monitor ("[%0tns] clk=%0b rstn=%0b out=0x%0h", $time, clk, rstn, out);
    
//     // 1. Initialize testbench variables to 0 at start of simulation
//     clk <= 0;
//     rstn <= 0;
    
//     // 3. Finish the stimulus after 200ns
//     #20 $finish;
//   end
  
//   initial begin
//     $dumpvars;
//     $dumpfile("dump.vcd");
//   end
// endmodule