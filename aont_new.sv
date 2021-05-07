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
    etemp[8][0] = latinsquare2[leader[lslen-1]*lslen + 4'b0000];
    for (j=1; j<lslen; j=j+1) begin
        etemp[8][j] = latinsquare2[etemp[8][j-1]*lslen + 4'b1000];
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
    for (j=0; j<lslen; j=j+1) begin
        btemp[8][j] = latinsquare2[etemp[8][j]*lslen + msgInBlocks[8][j]];
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
    for (j=0; j<lslen; j=j+1) begin
        atemp[8][j] = (atemp[7][j] * btemp[8][j]) % (lslen + 1);
    end

    //B'
    for (j=0; j<lslen; j=j+1) begin
        btemp[9][j] = (atemp[8][j] * k[j]) % (lslen + 1);
    end

    msgOut = btemp;

  end

endmodule
