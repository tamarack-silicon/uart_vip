package uart_vip_dual_simple_driver_test_pkg;

	`include "uvm_macros.svh"

	import uvm_pkg::*;
	import tamarack_uart_agent_pkg::*;
	import uart_vip_tests_env_pkg::*;
	import uart_vip_dual_base_test_pkg::*;

	class uart_vip_dual_simple_driver_test_seq extends uvm_sequence#(tamarack_uart_item);

		`uvm_object_utils(uart_vip_dual_simple_driver_test_seq)

		function new(string name = "uart_vip_dual_simple_driver_test_seq");
			super.new(name);
		endfunction // new

		virtual task body();
			tamarack_uart_item m_item;

			repeat(100) begin
				m_item = tamarack_uart_item::type_id::create("m_item");

				start_item(m_item);

				m_item.direction = TRANSMIT;
				m_item.length = 8;
				m_item.parity_error = 1'b0;
				if(!m_item.randomize()) begin
					`uvm_error("UART_VIP_DUAL_SIMPLE_DRIVER_TEST", "Randomization Failed")
				end

				finish_item(m_item);

				#1ms;

			end
		endtask // body

	endclass

	class uart_vip_dual_simple_driver_test extends uart_vip_dual_base_test;

		`uvm_component_utils(uart_vip_dual_simple_driver_test)

		function new(string name = "uart_vip_dual_simple_driver_test", uvm_component parent = null);
			super.new(name, parent);
		endfunction // new

		virtual task run_phase(uvm_phase phase);
			uart_vip_dual_simple_driver_test_seq m_seq;
			m_seq = uart_vip_dual_simple_driver_test_seq::type_id::create("m_seq");

			phase.raise_objection(phase);

			#1ms;
			m_seq.start(m_env.m_uart_agent_a.sequencer);

			phase.drop_objection(phase);
		endtask // run_phase

	endclass

endpackage // uart_vip_dual_simple_driver_test_pkg
