module clock (clk_100Mhz,minute_change,hour_change,mode,select,number,led1,led2,alarm_en,led3);
    input clk_100Mhz;//板子时钟
    input minute_change,hour_change,mode;//校分钟、小时，12、24小时模式改变
	input alarm_en;//调整闹钟用
    output [7:0] select,number;//片选，数字显示
    output led1,led2,led3;//led1亮表示12小时进制下午，led2表示整点报时，led3表示闹钟
    wire [20:0] count;//记录当前时间，以秒为单位
	wire [20:0] count_alarm;//闹钟对应的时间
    wire led1;//上午及24小时制灭，下午亮
    wire led2;//正点报时
	wire led3;//闹钟，亮一分钟
    wire clk_1khz,clk_1hz,clk_100Mhz;
    reg [7:0] select;//选数码管
    reg [7:0] number;//数码管上的数字
    wire [3:0] hour1,hour0,min1,min0,sec1,sec0;//时分秒
    
    
    //分频，1khz用于显示，1hz用于计时
    frequency_diver fre(clk_100Mhz,clk_1khz,clk_1hz);

    //进位+进制转换的灯
	time_change change(clk_1hz,count,mode,led1,hour_change,minute_change,alarm_en,count_alarm);

    //得到当前时间
    get_current_time get(count,mode,hour1,hour0,min1,min0,sec1,sec0,alarm_en,count_alarm);

    //数码管片选及应显示的数字
    wire [7:0] number0,number1,number2,number3,number4,number5;
    get_number s0(sec0,number0);
    get_number s1(sec1,number1);
    get_number m0(min0,number2);
    get_number m1(min1,number3);
    get_number h0(hour0,number4);
    get_number h1(hour1,number5);

    //显示数字（这个不知道为啥不能放进子函数）
    reg [2:0] flag;//用于循环

    initial begin select=0;number=0;flag=0; end
    //依次亮数码管
    always @(posedge clk_1khz) flag <= flag+1;
    always@(flag)
	begin
		if(flag == 3'd0)
			begin
				select <= 8'b1111_1110;
				number <= number0;
			end
		if(flag == 3'd1)
			begin
				select <= 8'b1111_1101;
				number <= number1;
			end
		if(flag == 3'd2)
			begin
				select <= 8'b1111_1011;
				number <= number2;
			end
		if(flag == 3'd3)
			begin
				select <= 8'b1111_0111;
				number <= number3;
			end
		if(flag == 3'd4)
			begin
				select <= 8'b1110_1111;
				number <= number4;
			end
		if(flag == 3'd5)
			begin
				select <= 8'b1101_1111;
				number <= number5;
			end
		if(flag == 3'd6)
			begin
				select <= 8'b1011_1111;
				number <= 8'b1111_1111;
			end
		if(flag == 3'd7)
			begin
				select <= 8'b0111_1111;
				number <= 8'b1111_1111;
			end
	end


    //正点报时
    zhengdian shan(clk_1hz, count, led2);

	//闹钟
	alarm zhong(clk_1hz,count,count_alarm,led3);

endmodule