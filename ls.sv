// Message length -: 512, n =16, s=8

module latin_square#(
      parameter lslen = 16,
      parameter lslenlog = 4
	)
    (  input clk,
       input wire[lslen-1:0][lslenlog-1:0] firstRow ,   
       output reg[lslen-1:0][lslen-1:0][lslenlog-1:0] latinsquare 
    ); 

    integer j;

    always @ (posedge clk) begin
        latinsquare[0] = firstRow;

        for (j=0; j<lslen; j=j+1) begin
            latinsquare[1][j] = ( 4'b0001 * latinsquare[1][j] ) % (lslen + 1);
        end
        for (j=0; j<lslen; j=j+1) begin
            latinsquare[2][j] = ( 4'b0010 * latinsquare[1][j] ) % (lslen + 1);
        end
        for (j=0; j<lslen; j=j+1) begin
            latinsquare[3][j] = ( 4'b0011  * latinsquare[1][j] ) % (lslen + 1);
        end
        for (j=0; j<lslen; j=j+1) begin
            latinsquare[4][j] = ( 4'b0100 * latinsquare[1][j] ) % (lslen + 1);
        end

        for (j=0; j<lslen; j=j+1) begin
            latinsquare[5][j] = ( 4'b0101 * latinsquare[1][j] ) % (lslen + 1);
        end
        for (j=0; j<lslen; j=j+1) begin
            latinsquare[6][j] = ( 4'b0110 * latinsquare[1][j] ) % (lslen + 1);
        end
        for (j=0; j<lslen; j=j+1) begin
            latinsquare[7][j] = ( 4'b0111 * latinsquare[1][j] ) % (lslen + 1);
        end
        for (j=0; j<lslen; j=j+1) begin
            latinsquare[8][j] = ( 4'b1000 * latinsquare[1][j] ) % (lslen + 1);
        end

        for (j=0; j<lslen; j=j+1) begin
            latinsquare[9][j] = ( 4'b1001 * latinsquare[1][j] ) % (lslen + 1);
        end
        for (j=0; j<lslen; j=j+1) begin
            latinsquare[10][j] = ( 4'b1010 * latinsquare[1][j] ) % (lslen + 1);
        end
        for (j=0; j<lslen; j=j+1) begin
            latinsquare[11][j] = ( 4'b1011 * latinsquare[1][j] ) % (lslen + 1);
        end
        for (j=0; j<lslen; j=j+1) begin
            latinsquare[12][j] = ( 4'b1100 * latinsquare[1][j] ) % (lslen + 1);
        end

        for (j=0; j<lslen; j=j+1) begin
            latinsquare[13][j] = ( 4'b1101 * latinsquare[1][j] ) % (lslen + 1);
        end
        for (j=0; j<lslen; j=j+1) begin
            latinsquare[14][j] = ( 4'b1110 * latinsquare[1][j] ) % (lslen + 1);
        end
        for (j=0; j<lslen; j=j+1) begin
            latinsquare[15][j] = ( 4'b1111 * latinsquare[1][j] ) % (lslen + 1);
        end
    end

endmodule