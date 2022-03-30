//分频得到1khz和1hz
module frequency_diver (clk_100Mhz,clk_1khz,clk_1hz);
    input clk_100Mhz;
    output clk_1hz,clk_1khz;
    reg [20:0] count_temp1,count_temp2;
    reg clk_1hz,clk_1khz;

    initial 
    begin
        clk_1khz=0;clk_1hz=0;count_temp1=0;count_temp2=0;
    end
    //得到1khz后用1khz分1hz
    always @(posedge clk_100Mhz ) 
    begin
        count_temp1 <= count_temp1 + 1;
        if (count_temp1==20'd50000) 
        begin
            clk_1khz <= ~clk_1khz;
            count_temp1 <= 0;
        end
    end

    always @(posedge clk_1khz ) 
    begin
        count_temp2 <= count_temp2 + 1;
        if (count_temp2==10'd500) 
        begin
            clk_1hz <= ~clk_1hz;
            count_temp2 <= 0;
        end
    end
endmodule