module uart_vip_tests_top;

	tamarack_uart_if uart_if_a();
	tamarack_uart_if uart_if_b();

	assign uart_if_a.rx = uart_if_b.tx;
	assign uart_if_b.rx = uart_if_a.tx;
	assign uart_if_a.cts = uart_if_b.rts;
	assign uart_if_b.cts = uart_if_a.rts;

	initial begin
		uvm_pkg::uvm_config_db#(virtual tamarack_uart_if)::set(null, "uvm_test_top.m_env.m_uart_agent_a", "uart_vif", uart_if_a);
		uvm_pkg::uvm_config_db#(virtual tamarack_uart_if)::set(null, "uvm_test_top.m_env.m_uart_agent_b", "uart_vif", uart_if_b);
		uvm_pkg::run_test();
	end

	initial begin
		$dumpfile("wave.vcd");
		$dumpvars;
	end

endmodule // uart_vip_tests_top
