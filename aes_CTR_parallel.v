//Pipelined 128-bit key AES CTR mode using https://opencores.org/projects/tiny_aes
module aes_CTR_mode_alternative #(
			parameter keylen = 128
	)
	(
		input clk, encNotDec,
		input rst,
		input [keylen-1:0] key, messageIn1, cipherIn1,
        input [keylen-1:0] messageIn2, cipherIn2,
        input [keylen-1:0] messageIn3, cipherIn3,
        input [keylen-1:0] messageIn4, cipherIn4,
		input [(keylen/2)-1:0] nonce1, counterIn1,
        input [(keylen/2)-1:0] nonce2, counterIn2,
        input [(keylen/2)-1:0] nonce3, counterIn3,
        input [(keylen/2)-1:0] nonce4, counterIn4,
		output reg [keylen-1:0] messageOut1, cipherOut1,
        output reg [keylen-1:0] messageOut2, cipherOut2,
        output reg [keylen-1:0] messageOut3, cipherOut3,
        output reg [keylen-1:0] messageOut4, cipherOut4
	);

	reg  [(keylen/2)-1:0] counter; 
	reg  [keylen-1:0] messageInReg, cipherInReg;
	wire [keylen-1:0] blockInput1, blockOutput1;
    wire [keylen-1:0] blockInput2, blockOutput2;
    wire [keylen-1:0] blockInput3, blockOutput3;
    wire [keylen-1:0] blockInput4, blockOutput4;
	wire encrypterClock;

	assign encrypterClock = clk & !rst;
	assign blockInput1 = {nonce1, counter1};
    assign blockInput2 = {nonce2, counter2};
    assign blockInput3 = {nonce3, counter3};
    assign blockInput4 = {nonce4, counter4};

	aes_128 encrypter_block1(
		.clk(encrypterClock),
		.state(blockInput1),
		.key(key),
		.out(blockOutput1)
		);
        
    aes_128 encrypter_block2(
		.clk(encrypterClock),
		.state(blockInput2),
		.key(key),
		.out(blockOutput2)
		);

    aes_128 encrypter_block3(
		.clk(encrypterClock),
		.state(blockInput3),
		.key(key),
		.out(blockOutput3)
		);    

    aes_128 encrypter_block4(
		.clk(encrypterClock),
		.state(blockInput4),
		.key(key),
		.out(blockOutput4)
		);

    

	always @(posedge clk)
	begin
		if(rst == 1'b1) begin
//			counter = counterIn;
//			messageOut = 0;
//			cipherOut = 0;
		end
	end

	always @(negedge clk)
	begin
		if (rst == 1'b0) begin
			counter = counter + 1;
		end
	end

	always @(posedge clk)
	begin
		if (rst == 1'b0) begin
			if(encNotDec == 1'b1) begin
				cipherOut1 = blockOutput1 ^ messageIn1;
                cipherOut2 = blockOutput2 ^ messageIn2;
                cipherOut3 = blockOutput3 ^ messageIn3;
                cipherOut4 = blockOutput4 ^ messageIn4;
			end
			else begin
				messageOut1 = blockOutput1 ^ cipherIn1;
                messageOut2 = blockOutput2 ^ cipherIn2;
                messageOut3 = blockOutput3 ^ cipherIn3;
                messageOut4 = blockOutput4 ^ cipherIn4;
			end
		end
	end


endmodule
