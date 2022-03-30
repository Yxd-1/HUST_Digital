//进位+进制转换
module time_change (clk_1hz,count,mode,led1,hour_change,minute_change,alarm_en,count_alarm);
    input clk_1hz,mode,hour_change,minute_change,alarm_en;
    output led1;
    output [20:0] count;
    output [20:0] count_alarm;
    reg led1;
    reg [20:0] count;
    reg [20:0] count_alarm;
    reg [20:0] count_12;
    
    initial begin count=0;led1=0;count_alarm=0; end
    always @(posedge clk_1hz )
    begin
        count_12 <= count%43200;//12进制时用，这个好像没用了，但是不影响跑就没改
        case (alarm_en)
            1'b0: //不调闹钟
            begin
                case ({hour_change,minute_change})
                    2'b00://无校时
                        if (count < 20'd86400) count <= count+1;
                        else count <= 0;
                    2'b01://分钟校时
                        if(count < 20'd86400) count <= count + 6'd60;
                        else count <= count - 20'd86340;
                    2'b10://小时校时
                        if(count < 20'd82800) count <= count + 12'd3600;
                        else count <= count - 20'd82800;
                    2'b11://锁存
                        count <= count;
                endcase
            end
            1'b1: //调闹钟
            begin
                case ({hour_change,minute_change})
                    2'b00://无校时
                        if (count_alarm < 20'd86400) count_alarm <= count_alarm+1;
                        else count_alarm <= 0;
                    2'b01://分钟校时
                        if(count_alarm < 20'd86400) count_alarm <= count_alarm + 6'd60;
                        else count_alarm <= count_alarm - 20'd86340;
                    2'b10://小时校时
                        if(count_alarm < 20'd82800) count_alarm <= count_alarm + 12'd3600;
                        else count_alarm <= count_alarm - 20'd82800;
                    2'b11://锁存
                        count_alarm <= count_alarm;
                endcase
            end
        endcase
    end
    //如果是12进制并且count>12小时，说明是下午，led1亮
    always @(posedge clk_1hz)
    begin
        if (mode==1 && count>=20'd43200) led1<=1;
        else led1<=0; 
    end

endmodule