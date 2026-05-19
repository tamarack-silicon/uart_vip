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
		uvm_pkg::uvm_config_db#(integer)::set(null, "uvm_test_top.m_env.m_uart_agent_a", "baud_rate", 115200);		
		uvm_pkg::uvm_config_db#(integer)::set(null, "uvm_test_top.m_env.m_uart_agent_b", "baud_rate", 115200);
		uvm_pkg::uvm_config_db#(tamarack_uart_agent_pkg::tamarack_uart_data_order)::set(null, "uvm_test_top.m_env.m_uart_agent_a", "data_order", tamarack_uart_agent_pkg::TAMARACK_UART_VIP_DATA_ORDER_LSB_FIRST);
		uvm_pkg::uvm_config_db#(tamarack_uart_agent_pkg::tamarack_uart_data_order)::set(null, "uvm_test_top.m_env.m_uart_agent_b", "data_order", tamarack_uart_agent_pkg::TAMARACK_UART_VIP_DATA_ORDER_LSB_FIRST);
		uvm_pkg::uvm_config_db#(integer)::set(null, "uvm_test_top.m_env.m_uart_agent_a", "data_bits", 8);
		uvm_pkg::uvm_config_db#(integer)::set(null, "uvm_test_top.m_env.m_uart_agent_b", "data_bits", 8);
		uvm_pkg::uvm_config_db#(integer)::set(null, "uvm_test_top.m_env.m_uart_agent_a", "stop_bits", 1);
		uvm_pkg::uvm_config_db#(integer)::set(null, "uvm_test_top.m_env.m_uart_agent_b", "stop_bits", 1);
		uvm_pkg::run_test();
	end

	initial begin
		$dumpfile("wave.vcd");
		$dumpvars;
	end

endmodule // uart_vip_tests_top
