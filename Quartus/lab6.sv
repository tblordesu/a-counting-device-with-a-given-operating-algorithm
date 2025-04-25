module lab6 (
		input  logic clk,
		input  logic reset,
		output logic [4:0] result
	);
    logic [4:0] counter_out;
    logic [2:0] pause_counter;
    logic       in_pause, next_in_pause;

    //Основной счетчик до 20
    lpm_counter #(.WIDTH(5)) counter_inst (
        .clk(clk),
        .reset(reset | in_pause),  //сбрасываем, если пауза началась
        .q(counter_out)
    );

    //Регистр паузы (от 0 до 5)
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            pause_counter <= 3'd0;
        end else if (in_pause) begin
            pause_counter <= pause_counter + 3'd1;
        end else begin
            pause_counter <= 3'd0;
        end
    end

    //Логика перехода in_pause
    always_comb begin
        if (reset)
            next_in_pause = 1'b0;
        else if (!in_pause && counter_out == 5'd20)
            next_in_pause = 1'b1;
        else if (in_pause && pause_counter == 3'd5)
            next_in_pause = 1'b0;
        else
            next_in_pause = in_pause;
    end

    //Хранение in_pause через D-триггер
    d_flipflop pause_ff (
        .clk(clk),
        .reset(reset),
        .d(next_in_pause),
        .q(in_pause)
    );

    //Мультиплексор
    lpm_mux #(.WIDTH(5)) result_mux (
        .sel(in_pause),
        .data0(counter_out),
        .data1(5'd0),
        .result(result)
    );
endmodule