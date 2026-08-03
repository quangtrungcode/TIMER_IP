task run_test;
	reg [31:0] read_data;
	integer error_count;
	begin
		error_count = 0;
		$display("\n===============================");
		$display("[%0t] [TEST START] PATTERN: reg_init_chk", $time);
		$display("=================================");

		$display("[%0t] [INFO] Waiting for syste reset to be released", $time);
		wait (sys_rst_n == 1'b1);
		@(posedge sys_clk);
		$display("[%0t] [INFO] System reset released", $time);
		$display("===================================");

		$display("[%0t] [STEP 1] Check reset value of TCR (Offset: 12'h0)", $time);
		apb_read(12'h0, read_data);

		if (read_data === 32'h0000_0100) begin
			$display("[%0t] [PASS] TCR matches expected value (Actual: 32'h%08h)", $time, read_data);
		end else begin
			$display("[%0t] [FAIL] TCR mismatch! Expected: 32'h0000_0100, Actual: 32'h%08h", $time, read_data);
			error_count = error_count + 1;
		end
		$display("=================================");
		if (error_count == 0) begin
			$display("[%0t] [TEST SUMMARY] PATTERN: reg_init_chk ---> PASSED", $time);
		end else begin
			$display("[%0t] [TEST SUMMARY] PATTERN: reg_init_chk ---> FAILED (Total errors: %0d)", $time, error_count);
		end	
		$display("=================================");
	end
endtask

