module alu_tb();
  
reg [31:0] data [0:104];   //16 memory words (lines), 8 bits wide
	reg [2:0] f;
	reg [31:0] a, b, ycheck;
	reg zerocheck;
	integer i, j;

	initial $readmemh("alu.txt", data);
	wire [31:0] y;
	wire zero;
  alu v(a, b, f, y, zero);
	initial begin
	  a = 32'b0;
	  b= 32'b0;
	  f = 3'b0;
	  #200
        	for (i=0; i < 104; i=i+5) begin
			f = data[i];
			a = data[i+1];
			b = data[i+2];
			#200
			ycheck = data[i+3];
			zerocheck = data[i+4]; 
			$display("F: %d, A: %h, B: %h, Y: %h, ZERO: %d, CALCULATED Y: %h, CALCULATED ZERO: %d", f, a, b, ycheck, zerocheck, y, zero);
		end
	end     
endmodule