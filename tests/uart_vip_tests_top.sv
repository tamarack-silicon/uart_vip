module uart_vip_tests_top;

	tamarack_uart_if uart_if_a();
	tamarack_uart_if uart_if_b();

	assign uart_if_a.rx = uart_if_b.tx;
	assign uart_if_b.rx = uart_if_a.tx;
	assign uart_if_a.cts = uart_if_b.rts;
	assign uart_if_b.cts = uart_if_a.rts;

	initial begin
		automatic integer baud_rate;
		automatic tamarack_uart_agent_pkg::tamarack_uart_data_order data_order;
		automatic tamarack_uart_agent_pkg::tamarack_uart_parity_type parity_type;
		automatic integer data_bits;
		automatic integer stop_bits;

		if(!$value$plusargs("baud_rate=%0d", baud_rate)) begin
			baud_rate = 115200;
		end
		if(!$value$plusargs("data_order=%0d", data_order)) begin
			data_order = tamarack_uart_agent_pkg::TAMARACK_UART_VIP_DATA_ORDER_LSB_FIRST;
		end
		if(!$value$plusargs("parity_type=%0d", parity_type)) begin
			parity_type = tamarack_uart_agent_pkg::TAMARACK_UART_VIP_PARITY_ODD;
		end
		if(!$value$plusargs("data_bits=%0d", data_bits)) begin
			data_bits = 8;
		end
		if(!$value$plusargs("stop_bits=%0d", stop_bits)) begin
			stop_bits = 1;
		end

		uvm_pkg::uvm_config_db#(virtual tamarack_uart_if)::set(null, "uvm_test_top.m_env.m_uart_agent_a", "uart_vif", uart_if_a);
		uvm_pkg::uvm_config_db#(virtual tamarack_uart_if)::set(null, "uvm_test_top.m_env.m_uart_agent_b", "uart_vif", uart_if_b);
		uvm_pkg::uvm_config_db#(integer)::set(null, "uvm_test_top.m_env.m_uart_agent_a", "baud_rate", baud_rate);		
		uvm_pkg::uvm_config_db#(integer)::set(null, "uvm_test_top.m_env.m_uart_agent_b", "baud_rate", baud_rate);
		uvm_pkg::uvm_config_db#(tamarack_uart_agent_pkg::tamarack_uart_data_order)::set(null, "uvm_test_top.m_env.m_uart_agent_a", "data_order", data_order);
		uvm_pkg::uvm_config_db#(tamarack_uart_agent_pkg::tamarack_uart_data_order)::set(null, "uvm_test_top.m_env.m_uart_agent_b", "data_order", data_order);
		uvm_pkg::uvm_config_db#(tamarack_uart_agent_pkg::tamarack_uart_parity_type)::set(null, "uvm_test_top.m_env.m_uart_agent_a", "parity_type", parity_type);
		uvm_pkg::uvm_config_db#(tamarack_uart_agent_pkg::tamarack_uart_parity_type)::set(null, "uvm_test_top.m_env.m_uart_agent_b", "parity_type", parity_type);
		uvm_pkg::uvm_config_db#(integer)::set(null, "uvm_test_top.m_env.m_uart_agent_a", "data_bits", data_bits);
		uvm_pkg::uvm_config_db#(integer)::set(null, "uvm_test_top.m_env.m_uart_agent_b", "data_bits", data_bits);
		uvm_pkg::uvm_config_db#(integer)::set(null, "uvm_test_top.m_env.m_uart_agent_a", "stop_bits", stop_bits);
		uvm_pkg::uvm_config_db#(integer)::set(null, "uvm_test_top.m_env.m_uart_agent_b", "stop_bits", stop_bits);
		uvm_pkg::run_test();
	end

	initial begin
		$dumpfile("wave.vcd");
		$dumpvars;
	end

endmodule // uart_vip_tests_top
