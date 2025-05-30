`timescale 1ns/100ps

module lab6_tb;
    logic clk;
    logic reset;
    logic [4:0] result;

    //���������� �������� ������
    lab6 uut (
        .clk(clk),
        .reset(reset),
        .result(result)
    );

    always #50 clk = ~clk;  //���� ���� ������ 100 ��

    initial begin
        // �������������
        $dumpfile("lab6.vcd");       // VCD-���� ��� ��������� � GTKWave
        $dumpvars(0, lab6_tb);       // ��������� ��� �������

        clk = 0;
        reset = 1;
        #20;                         // 20 �� ������ �����
        reset = 0;

        #6000;                       // ������ 6000 ��
        $finish;
    end
endmodule
