//闹钟
module alarm (clk_1hz,count,count_alarm,led3);
    input clk_1hz;
    input [20:0] count;
    input [20:0] count_alarm;
    output led3;
    reg led3;
    reg [5:0] count_led3;//用于翻转灯用

    initial begin  led3=0;count_led3=0;      end
    //当闹钟时间等于总时间时(count)，给count_led3赋值，之后自减并让灯翻转
    always @(posedge clk_1hz ) 
    begin
        if (count+2==count_alarm)  count_led3 <= 60;//这个因为莫名其妙的时延问题，所以要count+2
        if (count_led3>0) 
        begin
            led3 <= ~led3;
            count_led3 <= count_led3 - 1;
        end
    end

endmodule