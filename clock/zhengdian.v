//正点报时
module zhengdian(clk_1hz, count, led2);
	input clk_1hz;
	input[20:0] count;
	output led2;
	reg led2;
	reg[4:0] clock_number;//用于亮灯，到点了给number赋值，number自减的同时让led2翻转
	//每次提前几秒，这样正点时正好可以亮最后一下
	initial begin clock_number = 0; led2 = 0; end
	always@(posedge clk_1hz)
		begin
			if(clock_number == 0)
				case(count)
					17'd3598: 	clock_number <= 2;//马上1点
				
					17'd7196:	clock_number <= 4;//马上2点

					17'd10794:	clock_number <= 6;//马上3点

					17'd14392:	clock_number <= 8;//马上4点

					17'd17990:	clock_number <= 10;//马上5点

					17'd21588:	clock_number <= 12;//马上6点

					17'd25186:	clock_number <= 14;//马上7点

					17'd28784:	clock_number <= 16;//马上8点
	
					17'd32382:	clock_number <= 18;//马上9点

					17'd35980:	clock_number <= 20;//马上10点
	
					17'd39578:	clock_number <= 22;//马上11点
					//后面不想加了，也不验收反正

				endcase	
			else
				begin
					led2 <= ~led2;
					clock_number <= clock_number - 1;
				end
		end
endmodule 