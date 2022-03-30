//得到数字
module get_number (temp,numbers);
    input [3:0] temp;
    output [7:0] numbers;
    reg [7:0] number_s;

    assign numbers = number_s;
    always @(temp) 
        case(temp)
            4'd0: number_s <= 8'b00000011;
			4'd1: number_s <= 8'b10011111;
			4'd2: number_s <= 8'b00100101;
			4'd3: number_s <= 8'b00001101;
			4'd4: number_s <= 8'b10011001;
			4'd5: number_s <= 8'b01001001;
			4'd6: number_s <= 8'b01000001;
			4'd7: number_s <= 8'b00011111;
			4'd8: number_s <= 8'b00000001;
			4'd9: number_s <= 8'b00011001;
        endcase
endmodule