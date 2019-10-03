module fa(
  input a, b, c,
  output reg s, co);
 always@(*) 
  begin
    assign s = a ^ b ^ c;
    assign co = (a & b) | (a & c) | (b & c);
  end
endmodule
  
module bit(
  input [31:0] a,
  input [31:0] b,
  input cin,
  output [31:0] sum,
  output cout);
     wire c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16, c17, c18, c19, c20, c21, c22, c23, c24, c25, c26, c27, c28, c29, c30, c31;
  begin
     fa aaa(a[0], b[0], cin, sum[0], c0);
     fa bbb(a[1], b[1], c0, sum[1], c1);
     fa c(a[2], b[2], c1, sum[2], c2);
     fa d(a[3], b[3], c2, sum[3], c3);
     fa e(a[4], b[4], c3, sum[4], c4);
     fa f(a[5], b[5], c4, sum[5], c5);
     fa g(a[6], b[6], c5, sum[6], c6);
     fa h(a[7], b[7], c6, sum[7], c7);
     fa i(a[8], b[8], c7, sum[8], c8);
     fa j(a[9], b[9], c8, sum[9], c9);
     fa k(a[10], b[10], c9, sum[10], c10);
     fa l(a[11], b[11], c10, sum[11], c11);
     fa m(a[12], b[12], c11, sum[12], c12);
     fa n(a[13], b[13], c12, sum[13], c13);
     fa o(a[14], b[14], c13, sum[14], c14);
     fa p(a[15], b[15], c14, sum[15], c15);
     fa q(a[16], b[16], c15, sum[16], c16);
     fa r(a[17], b[17], c16, sum[17], c17);
     fa s(a[18], b[18], c17, sum[18], c18);
     fa t(a[19], b[19], c18, sum[19], c19);
     fa u(a[20], b[20], c19, sum[20], c20);
     fa v(a[21], b[21], c20, sum[21], c21);
     fa w(a[22], b[22], c21, sum[22], c22);
     fa x(a[23], b[23], c22, sum[23], c23);
     fa y(a[24], b[24], c23, sum[24], c24);
     fa z(a[25], b[25], c24, sum[25], c25);
     fa aa(a[26], b[26], c25, sum[26], c26);
     fa bb(a[27], b[27], c26, sum[27], c27);
     fa cc(a[28], b[28], c27, sum[28], c28);
     fa dd(a[29], b[29], c28, sum[29], c29);
     fa ee(a[30], b[30], c29, sum[30], c30);
     fa ff(a[31], b[31], c30, sum[31], cout);
   end
 endmodule
 
 module alu(input [31:0] a, b,
   input [2:0] f,
   output reg [31:0] y,
   output reg zero);
   wire [31:0] newb, holdy;
   wire carry, c;
   assign newb = ((f == 3'b110) || (f == 3'b111)) ? ~b : b;
   assign carry = ((f == 3'b110) || (f == 3'b111)) ? 1'b1 : 1'b0; 
   bit sum(a, newb, carry, holdy, c);
   
   always@(*)
   begin
     //$display("%b", f);
     case(f)
       3'd0: y = a & b;
       3'd1: y = a | b;
       3'd2: y = holdy;
       3'd4 : y = a & ~b;
       3'd5 : y = a | ~b;
       3'd6: y = holdy;  
       3'd7: begin
         if(holdy[31] == 1)
           begin
              y = 32'd1;
            end
            else begin
              y = 32'd0;
            end
          end
      default : y[31:0] = 32'bx;
    endcase
      if(y == 32'b0) begin
        zero = 1;
      end
      else begin
        zero = 0;
      end
    end
  endmodule    
          