// Message length -: 512, n =16, s=8


module aont #(
	 parameter messgalen = 512,
      parameter noofblocks = 9,
      parameter lslen = 16,
      parameter lslenlog = 4
	)
    (  input clk,               
       input rstn,
       input [messgalen-1:0] messageIn 
    ); 
  
  reg[lslenlog-1:0] etemp [0:noofblocks-1] [0: lslen - 1];
  reg[lslenlog-1:0] b [0:noofblocks-1] [0: lslen - 1];
  integer j = 0 ;
  integer i = 1 ;

  always @ (posedge clk) begin
    for (i=1; i<lslen; i=i+1) begin
        for (j=0; j<4; j=j+1) begin
            latinsquare[i][j] = ( i * 1 ) % 4 ;
        end
    end

    for (i=0; i<noofblocks; i=i+1) begin
        for (j=0; j<lslen; j=j+1) begin
            etemp[i][j] = latinsquare[i][j];
        end
        for (j=0; j<4; j=j+1) begin
            b[i][j] = latinsquare[i][j] ;
        end
    end
  end

endmodule


module latin_square#(
      parameter lslen = 16,
      parameter lslenlog = 4
	)
    (  input clk,
       input wire[0:lslen-1][lslenlog-1:0] firstRow ,   
       output reg[0:lslen-1][0:lslen-1][lslenlog-1:0] latinsquare 
    ); 

    integer j = 0 ;

    always @ (posedge clk) begin
        latinsquare[0] = firstRow;

        for (j=0; j<lslen; j=j+1) begin
            latinsquare[1][j] = ( 1 * latinsquare[1][j] ) % lslen;
        end
        for (j=0; j<lslen; j=j+1) begin
            latinsquare[2][j] = ( 2 * latinsquare[1][j] ) % lslen;
        end
        for (j=0; j<lslen; j=j+1) begin
            latinsquare[3][j] = ( 3 * latinsquare[1][j] ) % lslen;
        end
        for (j=0; j<lslen; j=j+1) begin
            latinsquare[4][j] = ( 4 * latinsquare[1][j] ) % lslen;
        end

        for (j=0; j<lslen; j=j+1) begin
            latinsquare[5][j] = ( 5 * latinsquare[1][j] ) % lslen;
        end
        for (j=0; j<lslen; j=j+1) begin
            latinsquare[6][j] = ( 6 * latinsquare[1][j] ) % lslen;
        end
        for (j=0; j<lslen; j=j+1) begin
            latinsquare[7][j] = ( 7 * latinsquare[1][j] ) % lslen;
        end
        for (j=0; j<lslen; j=j+1) begin
            latinsquare[8][j] = ( 8 * latinsquare[1][j] ) % lslen;
        end

        for (j=0; j<lslen; j=j+1) begin
            latinsquare[9][j] = ( 9 * latinsquare[1][j] ) % lslen;
        end
        for (j=0; j<lslen; j=j+1) begin
            latinsquare[10][j] = ( 10 * latinsquare[1][j] ) % lslen;
        end
        for (j=0; j<lslen; j=j+1) begin
            latinsquare[11][j] = ( 11 * latinsquare[1][j] ) % lslen;
        end
        for (j=0; j<lslen; j=j+1) begin
            latinsquare[12][j] = ( 12 * latinsquare[1][j] ) % lslen;
        end

        for (j=0; j<lslen; j=j+1) begin
            latinsquare[13][j] = ( 13 * latinsquare[1][j] ) % lslen;
        end
        for (j=0; j<lslen; j=j+1) begin
            latinsquare[14][j] = ( 14 * latinsquare[1][j] ) % lslen;
        end
        for (j=0; j<lslen; j=j+1) begin
            latinsquare[15][j] = ( 15 * latinsquare[1][j] ) % lslen;
        end
    end

endmodule








// module cw #(
// 	 parameter cwbits = 32,
//      parameter ctrsize = 16,
//      parameter tagsize = 16,
//      parameter cachesize = 10
// 	)
//     (  input clk,               
//        input rstn );   
  
//   reg maccache[tagsize -1 : 0] [0:cachesize];
//   reg out[ctrsize+tagsize: 0] [0:cwbits*2-1];

//   integer j = 0 ;
//   always @ (posedge clk) begin
//     for (j=0; j<cwbits; j++) begin
//         out[j*2][1] =  maccache[1][1];
//         out[j*2+1][1] =  maccache[1][1];
//     end
//   end
// endmodule





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