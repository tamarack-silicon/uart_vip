package uart_vip_dual_base_test_pkg;

	`include "uvm_macros.svh"

	import uvm_pkg::*;
	import uart_vip_tests_env_pkg::*;

	class uart_vip_dual_base_test extends uvm_test;

		`uvm_component_utils(uart_vip_dual_base_test)

		uart_vip_dual_tests_env m_env;

		function new(string name = "uart_vip_dual_base_test", uvm_component parent = null);
			super.new(name, parent);
		endfunction // new

		virtual function void build_phase(uvm_phase phase);
			super.build_phase(phase);

			m_env = uart_vip_dual_tests_env::type_id::create("m_env", this);
		endfunction // build_phase

		virtual function void end_of_elaboration_phase(uvm_phase phase);
			super.end_of_elaboration_phase(phase);

			`uvm_info("UART_VIP_DUAL_BASE_TEST", "Test topology:", UVM_HIGH)
			this.print();
		endfunction // end_of_elaboration_phase

		virtual task run_phase(uvm_phase phase);
			phase.raise_objection(phase);

			phase.drop_objection(phase);
		endtask // run_phase

	endclass // uart_vip_dual_base_test

endpackage // uart_vip_dual_base_test_pkg
