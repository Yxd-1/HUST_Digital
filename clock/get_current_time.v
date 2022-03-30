//得到时间
module get_current_time (count,mode,hour1,hour0,min1,min0,sec1,sec0,alarm_en,count_alarm);
    input [20:0] count;
    input [20:0] count_alarm;
    input mode;
    input alarm_en;
    output [3:0] hour1,hour0,min1,min0,sec1,sec0;
    reg [3:0] hour1,hour0,min1,min0,sec1,sec0;
    reg [20:0] count_12;//用于最终显示时间

    initial
    begin
        hour1=0;hour0=0;min1=0;min0=0;sec1=0;sec0=0;
    end
    //如果是在调整闹钟，就显示闹钟的时间，如果是12进制，就显示12进制的时间，其他情况就显示总时间
    always @(mode,alarm_en)
    begin
        if (alarm_en==1) count_12 <= count_alarm;
        else if(mode==1) count_12 <= count %20'd43200;
        else count_12 <= count;
    end
    //通过该运算可以得到时分秒的十位个位
    always @(count) 
    begin
        sec0 <= count_12%60%10;
		sec1 <= count_12%60/10;
		min0 <= count_12/60%60%10;
		min1 <= count_12/60%60/10;
		hour0 <= count_12/3600%10;
		hour1 <= count_12/3600/10;
    end
endmodule