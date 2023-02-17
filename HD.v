module HD(
	code_word1,
	code_word2,
	out_n
);
input  [6:0]code_word1, code_word2;
output reg signed[5:0] out_n;

wire a1,a2,a3;
wire A1,A2,A3;
wire [2:0] B1,B2;
wire signed [3:0] c1,c2;
wire [1:0] opt;
reg signed [4:0] x1,x2;

assign a1=code_word1[6]^code_word1[3]^code_word1[2]^code_word1[1];
assign a2=code_word1[5]^code_word1[3]^code_word1[2]^code_word1[0];
assign a3=code_word1[4]^code_word1[3]^code_word1[1]^code_word1[0];
assign B1={a1,a2,a3};

assign A1=code_word2[6]^code_word2[3]^code_word2[2]^code_word2[1];
assign A2=code_word2[5]^code_word2[3]^code_word2[2]^code_word2[0];
assign A3=code_word2[4]^code_word2[3]^code_word2[1]^code_word2[0];
assign B2={A1,A2,A3};

assign {c1,opt[1],c2,opt[0]}={x1,x2};

always@(*)
begin
	case(B1)
	3'b011:x1={code_word1[3] ,code_word1[2] ,code_word1[1] ,~code_word1[0],code_word1[0]};	
	3'b101:x1={code_word1[3] ,code_word1[2] ,~code_word1[1],code_word1[0] ,code_word1[1]};
	3'b110:x1={code_word1[3] ,~code_word1[2],code_word1[1] ,code_word1[0] ,code_word1[2]};
	3'b111:x1={~code_word1[3],code_word1[2] ,code_word1[1] ,code_word1[0] ,code_word1[3]};
	3'b001:x1={code_word1[3] ,code_word1[2] ,code_word1[1] ,code_word1[0] ,code_word1[4]};
	3'b010:x1={code_word1[3] ,code_word1[2] ,code_word1[1] ,code_word1[0] ,code_word1[5]};
	3'b100:x1={code_word1[3] ,code_word1[2] ,code_word1[1] ,code_word1[0] ,code_word1[6]};
	default:x1={code_word1[3],code_word1[2] ,code_word1[1] ,code_word1[0] ,code_word1[0]};
	endcase
    
	case(B2)
	3'b011:x2={code_word2[3] ,code_word2[2] ,code_word2[1] ,~code_word2[0],code_word2[0]};
	3'b101:x2={code_word2[3] ,code_word2[2] ,~code_word2[1],code_word2[0] ,code_word2[1]};
	3'b110:x2={code_word2[3] ,~code_word2[2],code_word2[1] ,code_word2[0] ,code_word2[2]};
	3'b111:x2={~code_word2[3],code_word2[2] ,code_word2[1] ,code_word2[0] ,code_word2[3]};
	3'b001:x2={code_word2[3] ,code_word2[2] ,code_word2[1] ,code_word2[0] ,code_word2[4]};
	3'b010:x2={code_word2[3] ,code_word2[2] ,code_word2[1] ,code_word2[0] ,code_word2[5]};
	3'b100:x2={code_word2[3] ,code_word2[2] ,code_word2[1] ,code_word2[0] ,code_word2[6]};
	default:x2={code_word2[3],code_word2[2] ,code_word2[1] ,code_word2[0] ,code_word2[0]};
	endcase

	case(opt)
	2'b00:out_n=(c1<<<1)+c2;
	2'b01:out_n=(c1<<<1)-c2;
	2'b10:out_n=c1-(c2<<<1);
	default:out_n=c1+(c2<<<1);
	endcase
end

endmodule
