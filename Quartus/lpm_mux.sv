module lpm_mux #(
		parameter WIDTH = 5
	)(
		input logic sel,
		input logic [WIDTH-1:0] data0,
		input logic [WIDTH-1:0] data1,
		output logic [WIDTH-1:0] result
	);

    always_comb begin
        case (sel)
            1'b0: result = data0;
            1'b1: result = data1;
        endcase
    end

endmodule
