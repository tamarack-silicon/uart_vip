package uart_vip_tests_env_pkg;

	`include "uvm_macros.svh"

	import uvm_pkg::*;
	import tamarack_uart_agent_pkg::*;

	class uart_vip_single_tests_env extends uvm_env;

		`uvm_component_utils(uart_vip_single_tests_env)

		tamarack_uart_agent m_uart_agent_a;

		function new(string name = "uart_vip_single_tests_env", uvm_component parent = null);
			super.new(name, parent);
		endfunction // new

		virtual function void build_phase(uvm_phase phase);
			super.build_phase(phase);

			m_uart_agent_a = tamarack_uart_agent::type_id::create("m_uart_agent_a", this);
		endfunction // build_phase

		virtual function void connect_phase(uvm_phase phase);
			super.connect_phase(phase);
		endfunction // connect_phase

	endclass // uart_vip_single_tests_env

	class uart_vip_dual_tests_env extends uvm_env;

		`uvm_component_utils(uart_vip_dual_tests_env)

		tamarack_uart_agent m_uart_agent_a;
		tamarack_uart_agent m_uart_agent_b;

		function new(string name = "uart_vip_dual_tests_env", uvm_component parent = null);
			super.new(name, parent);
		endfunction // new

		virtual function void build_phase(uvm_phase phase);
			super.build_phase(phase);

			m_uart_agent_a = tamarack_uart_agent::type_id::create("m_uart_agent_a", this);
			m_uart_agent_b = tamarack_uart_agent::type_id::create("m_uart_agent_b", this);
		endfunction // build_phase

		virtual function void connect_phase(uvm_phase phase);
			super.connect_phase(phase);
		endfunction // connect_phase

	endclass // uart_vip_dual_tests_env

endpackage
