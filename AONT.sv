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
       output reg [lslen*lslenlog*(noofblocks + 1) -1 : 0] msgOut,
       output reg lll
    ); 
  
  reg[lslen - 1:0][lslenlog-1:0] leader ;
  reg[noofblocks-1:0][lslen - 1:0][lslenlog-1:0] etemp ;
  reg[noofblocks:0][lslen - 1:0][lslenlog-1:0] btemp ;
  reg[noofblocks-1:0][lslen - 1:0][lslenlog-1:0] atemp ;
  integer j = 0 ;

  wire[noofblocks-1:0][lslen - 1:0][lslenlog-1:0] msgInBlocks;
  wire[lslen-1:0][lslen-1:0][lslenlog-1:0] latinsquare;
  wire[lslen*lslen-1:0][lslenlog-1:0] latinsquare2;

  latin_square ls (clk, k, latinsquare);
  
  assign latinsquare2 = latinsquare;
  assign msgInBlocks = msgIn;
  
  always @ (posedge clk) begin

// leader
    leader[0] = k[0][0];
    for (j=1; j<lslen; j=j+1) begin
        leader[j] = latinsquare2[k[j]*lslen + leader[j-1]];
    end
    lll = leader[15];

//etemp
    etemp[0][0] = latinsquare2[leader[lslen-1]*lslen + 4'b0000];
    for (j=1; j<lslen; j=j+1) begin
        etemp[0][j] = latinsquare2[etemp[0][j-1]*lslen + 4'b0000];
    end
    etemp[1][0] = latinsquare2[leader[lslen-1]*lslen + 4'b0000];
    for (j=1; j<lslen; j=j+1) begin
        etemp[1][j] = latinsquare2[etemp[1][j-1]*lslen + 4'b0001];
    end
    etemp[2][0] = latinsquare2[leader[lslen-1]*lslen + 4'b0000];
    for (j=1; j<lslen; j=j+1) begin
        etemp[2][j] = latinsquare2[etemp[2][j-1]*lslen + 4'b0010];
    end
    etemp[3][0] = latinsquare2[leader[lslen-1]*lslen + 4'b0000];
    for (j=1; j<lslen; j=j+1) begin
        etemp[3][j] = latinsquare2[etemp[3][j-1]*lslen + 4'b0011];
    end

    etemp[4][0] = latinsquare2[leader[lslen-1]*lslen + 4'b0000];
    for (j=1; j<lslen; j=j+1) begin
        etemp[4][j] = latinsquare2[etemp[4][j-1]*lslen + 4'b0100];
    end
    etemp[5][0] = latinsquare2[leader[lslen-1]*lslen + 4'b0000];
    for (j=1; j<lslen; j=j+1) begin
        etemp[5][j] = latinsquare2[etemp[5][j-1]*lslen + 4'b0101];
    end
    etemp[6][0] = latinsquare2[leader[lslen-1]*lslen + 4'b0000];
    for (j=1; j<lslen; j=j+1) begin
        etemp[6][j] = latinsquare2[etemp[6][j-1]*lslen + 4'b0110];
    end
    etemp[7][0] = latinsquare2[leader[lslen-1]*lslen + 4'b0000];
    for (j=1; j<lslen; j=j+1) begin
        etemp[7][j] = latinsquare2[etemp[7][j-1]*lslen + 4'b0111];
    end
// btemp
    for (j=0; j<lslen; j=j+1) begin
        btemp[0][j] = latinsquare2[etemp[0][j]*lslen + msgInBlocks[0][j]];
    end
    for (j=0; j<lslen; j=j+1) begin
        btemp[1][j] = latinsquare2[etemp[1][j]*lslen + msgInBlocks[1][j]];
    end
    for (j=0; j<lslen; j=j+1) begin
        btemp[2][j] = latinsquare2[etemp[2][j]*lslen + msgInBlocks[2][j]];
    end
    for (j=0; j<lslen; j=j+1) begin
        btemp[3][j] = latinsquare2[etemp[3][j]*lslen + msgInBlocks[3][j]];
    end

    for (j=0; j<lslen; j=j+1) begin
        btemp[4][j] = latinsquare2[etemp[4][j]*lslen + msgInBlocks[4][j]];
    end
    for (j=0; j<lslen; j=j+1) begin
        btemp[5][j] = latinsquare2[etemp[5][j]*lslen + msgInBlocks[5][j]];
    end
    for (j=0; j<lslen; j=j+1) begin
        btemp[6][j] = latinsquare2[etemp[6][j]*lslen + msgInBlocks[6][j]];
    end
    for (j=0; j<lslen; j=j+1) begin
        btemp[7][j] = latinsquare2[etemp[7][j]*lslen + msgInBlocks[7][j]];
    end

    //atemp
    atemp[0] = btemp[0];
    for (j=0; j<lslen; j=j+1) begin
        atemp[1][j] = (atemp[0][j] * btemp[1][j]) % (lslen + 1);
    end
    for (j=0; j<lslen; j=j+1) begin
        atemp[2][j] = (atemp[1][j] * btemp[2][j]) % (lslen + 1);
    end
    for (j=0; j<lslen; j=j+1) begin
        atemp[3][j] = (atemp[2][j] * btemp[3][j]) % (lslen + 1);
    end
    for (j=0; j<lslen; j=j+1) begin
        atemp[4][j] = (atemp[3][j] * btemp[4][j]) % (lslen + 1);
    end
    for (j=0; j<lslen; j=j+1) begin
        atemp[5][j] = (atemp[4][j] * btemp[5][j]) % (lslen + 1);
    end
    for (j=0; j<lslen; j=j+1) begin
        atemp[6][j] = (atemp[5][j] * btemp[6][j]) % (lslen + 1);
    end
    for (j=0; j<lslen; j=j+1) begin
        atemp[7][j] = (atemp[6][j] * btemp[7][j]) % (lslen + 1);
    end

    //B'
    for (j=0; j<lslen; j=j+1) begin
        btemp[8][j] = (atemp[7][j] * k[j]) % (lslen + 1);
    end

    msgOut = btemp;

  end

endmodule




// /* 
//  * Do not change Module name 
// */
// module main (  input clk,               
//        input rstn
//     ); 
    
//  reg [3:0][7:0] 	m_data; 	// A MDA, 4 bytes
//    integer i = 0 ;
//    wire[31:0] tt;
   
//    assign tt = m_data;
	
// 	initial begin
// 	  m_data = 32'hface_cafe;
      
//       $display ("m_data = 0x%0h", m_data);
		
	  
//       for (i = 0; i < 4; i++) begin
//         $display ("m_data[%0d] = %b (0x%0h)", i, m_data[i], m_data[i]);
// 		end
		
// 	for (i = 0; i < 32; i++) begin
//         $display ("tt[%0d] = %b (0x%0h)", i, tt[i], tt[i]);
// 	end
// 	end
// endmodule


// /* 
//  * Do not change Module name 
// */
// module main (  input clk,               
//        input rstn
//     ); 
    
//    reg [2:0][3:0][7:0] 	m_data; 	// A MDA, 4 bytes
//    integer i = 0 ;
//    wire[3*4-1:0][7:0] tt;
   
//    assign tt = m_data;
	
// 	initial begin
// 	  m_data[0] = 32'hface_cafe;
//       m_data[1] = 32'h1234_5678;
//       m_data[2] = 32'hc0de_fade;
      
//       $display ("m_data = 0x%0h", m_data);
		
	  
//       for (i = 0; i < 3; i++) begin
//         $display ("m_data[%0d] = %b (0x%0h)", i, m_data[i], m_data[i]);
// 		end
		
// 	for (i = 0; i < 12; i++) begin
//         $display ("tt[%0d] = %b (0x%0h)", i, tt[i], tt[i]);
// 	end
// 	end
// endmodule


// m_data = 0xc0defade12345678facecafe
// m_data[0] = 11111010110011101100101011111110 (0xfacecafe)
// m_data[1] = 00010010001101000101011001111000 (0x12345678)
// m_data[2] = 11000000110111101111101011011110 (0xc0defade)
// tt[0] = 11111110 (0xfe)
// tt[1] = 11001010 (0xca)
// tt[2] = 11001110 (0xce)
// tt[3] = 11111010 (0xfa)
// tt[4] = 01111000 (0x78)
// tt[5] = 01010110 (0x56)
// tt[6] = 00110100 (0x34)
// tt[7] = 00010010 (0x12)
// tt[8] = 11011110 (0xde)
// tt[9] = 11111010 (0xfa)
// tt[10] = 11011110 (0xde)
// tt[11] = 11000000 (0xc0)