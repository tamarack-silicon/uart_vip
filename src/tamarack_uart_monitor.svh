`ifndef TAMARACK_UART_MONITOR_SVH
`define TAMARACK_UART_MONITOR_SVH

class tamarack_uart_monitor extends uvm_monitor;

	`uvm_component_utils(tamarack_uart_monitor)

	function new(string name = "tamarack_uart_monitor", uvm_component parent = null);
		super.new(name, parent);
	endfunction // new

	uvm_analysis_port#(tamarack_uart_item) mon_analysis_port;
	virtual tamarack_uart_if uart_vif;

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("TAMARACK_UART_MONITOR", $sformatf("Tamarack Silicon Project UART Monitor %s", get_full_name()), UVM_HIGH)

		if(!uvm_config_db#(virtual tamarack_uart_if)::get(null, get_parent().get_full_name(), "uart_vif", uart_vif)) begin
			`uvm_fatal("TAMARACK_UART_MONITOR", "Could not get virtual interface from config_db")
		end

		mon_analysis_port = new("mon_analysis_port", this);
	endfunction // build_phase

	virtual task run_phase(uvm_phase phase);
		tamarack_uart_item m_item;

		super.run_phase(phase);

/*
		forever begin
			m_item = tamarack_uart_item::type_id::create("uart_item");

			// TODO

			`uvm_info("TAMARACK_UART_MONITOR", "Received item:", UVM_HIGH)
			m_item.print();

			mon_analysis_port.write(m_item);

		end
 */
	endtask // run_phase

endclass // tamarack_uart_monitor

`endif //  `ifndef TAMARACK_UART_MONITOR_SVH
