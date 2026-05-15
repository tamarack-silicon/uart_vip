`ifndef TAMARACK_UART_DRIVER_SVH
`define TAMARACK_UART_DRIVER_SVH

class tamarack_uart_driver extends uvm_driver#(tamarack_uart_item);

	`uvm_component_utils(tamarack_uart_driver)

	virtual tamarack_uart_if uart_vif;

	function new(string name = "tamarack_uart_driver", uvm_component parent = null);
		super.new(name, parent);
	endfunction // new

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("TAMARACK_UART_DRIVER", $sformatf("Tamarack Silicon Project UART Driver %s", get_full_name()), UVM_HIGH)
		if(!uvm_config_db#(virtual tamarack_uart_if)::get(null, get_parent().get_full_name(), "uart_vif", uart_vif)) begin
			`uvm_fatal("TAMARACK_UART_DRIVER", "Could not get virtual interface from config_db")
		end
	endfunction // build_phase

	virtual task run_phase(uvm_phase phase);
		tamarack_uart_item m_item;

		super.run_phase(phase);

		forever begin
			seq_item_port.get_next_item(m_item);
			`uvm_info("TAMARACK_UART_DRIVER", "Driving item:", UVM_HIGH)
			m_item.print();
			// TODO
			seq_item_port.item_done();
		end
	endtask // run_phase

endclass // tamarack_uart_driver

`endif //  `ifndef TAMARACK_UART_DRIVER_SVH
