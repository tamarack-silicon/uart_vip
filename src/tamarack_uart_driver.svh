`ifndef TAMARACK_UART_DRIVER_SVH
`define TAMARACK_UART_DRIVER_SVH

class tamarack_uart_driver extends uvm_driver#(tamarack_uart_item);

	`uvm_component_utils(tamarack_uart_driver)

	virtual tamarack_uart_if uart_vif;
	integer	baud_rate;
	tamarack_uart_data_order data_order;
	tamarack_uart_parity_type parity_type;
	integer data_bits;
	integer	stop_bits;

	function new(string name = "tamarack_uart_driver", uvm_component parent = null);
		super.new(name, parent);
	endfunction // new

	function void update_config();
		if(!uvm_config_db#(integer)::get(null, get_parent().get_full_name(), "baud_rate", baud_rate)) begin
			`uvm_fatal("TAMARACK_UART_DRIVER", "Could not get baud_rate from config_db")
		end
		if(!uvm_config_db#(tamarack_uart_data_order)::get(null, get_parent().get_full_name(), "data_order", data_order)) begin
			`uvm_fatal("TAMARACK_UART_DRIVER", "Could not get data_order from config_db")
		end
		if(!uvm_config_db#(tamarack_uart_parity_type)::get(null, get_parent().get_full_name(), "parity_type", parity_type)) begin
			`uvm_fatal("TAMARACK_UART_DRIVER", "Could not get parity_type from config_db")
		end
		if(!uvm_config_db#(integer)::get(null, get_parent().get_full_name(), "data_bits", data_bits)) begin
			`uvm_fatal("TAMARACK_UART_DRIVER", "Could not get data_bits from config_db")
		end
		if(!uvm_config_db#(integer)::get(null, get_parent().get_full_name(), "stop_bits", stop_bits)) begin
			`uvm_fatal("TAMARACK_UART_DRIVER", "Could not get stop_bits from config_db")
		end
	endfunction // update_config

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("TAMARACK_UART_DRIVER", $sformatf("Tamarack Silicon Project UART Driver %s", get_full_name()), UVM_HIGH)
		if(!uvm_config_db#(virtual tamarack_uart_if)::get(null, get_parent().get_full_name(), "uart_vif", uart_vif)) begin
			`uvm_fatal("TAMARACK_UART_DRIVER", "Could not get virtual interface from config_db")
		end
		update_config();
	endfunction // build_phase

	virtual task run_phase(uvm_phase phase);
		tamarack_uart_item m_item;
		automatic bit parity;

		super.run_phase(phase);

		uart_vif.tx = 1'b1;

		forever begin
			update_config();

			seq_item_port.get_next_item(m_item);
			`uvm_info("TAMARACK_UART_DRIVER", "Driving item:", UVM_HIGH)
			m_item.print();
			if(m_item.data_bits != data_bits) begin
				`uvm_error("TAMARACK_UART_DRIVER", $sformatf("m_item.data_bits != data_bits, m_item.data_bits = %0d, data_bits = %0d", m_item.data_bits, data_bits))
			end

			// Start bit
			`uvm_info("TAMARACK_UART_DRIVER", "Driving start bit, tx = 0", UVM_HIGH)
			uart_vif.tx = 1'b0;
			#(1s/baud_rate);

			// Data bits
			if(parity_type == TAMARACK_UART_VIP_PARITY_EVEN) begin
				parity = 1'b1;
			end else begin
				parity = 1'b0;
			end

			if(data_order == TAMARACK_UART_VIP_DATA_ORDER_LSB_FIRST) begin
				for(integer i = 0; i < data_bits; i++) begin
					`uvm_info("TAMARACK_UART_DRIVER", $sformatf("Driving data bit %0d, tx = %0d", i, m_item.data[i]), UVM_HIGH)
					uart_vif.tx = m_item.data[i];
					parity = parity ^ m_item.data[i];
					#(1s/baud_rate);
				end
			end else begin
				for(integer i = data_bits-1; i >= 0; i--) begin
					`uvm_info("TAMARACK_UART_DRIVER", $sformatf("Driving data bit %0d, tx = %0d", i, m_item.data[i]), UVM_HIGH)
					uart_vif.tx = m_item.data[i];
					parity = parity ^ m_item.data[i];
					#(1s/baud_rate);
				end
			end

			// Parity bit
			if(parity_type != TAMARACK_UART_VIP_PARITY_NONE) begin
				if(!m_item.parity_error) begin
					`uvm_info("TAMARACK_UART_DRIVER", $sformatf("Driving parity bit, tx = %0d, correct", parity), UVM_HIGH)
					uart_vif.tx = parity;
				end else begin
					`uvm_info("TAMARACK_UART_DRIVER", $sformatf("Driving parity bit, tx = %0d, incorrect", ~parity), UVM_HIGH)
					uart_vif.tx = ~parity;
				end
				#(1s/baud_rate);
			end

			// Stop bits
			for(integer i = 0; i < stop_bits; i++) begin
				`uvm_info("TAMARACK_UART_DRIVER", $sformatf("Driving stop bit %0d, tx = 1", i), UVM_HIGH)
				uart_vif.tx = 1'b1;
				#(1s/baud_rate);
			end

			seq_item_port.item_done();
		end
	endtask // run_phase

endclass // tamarack_uart_driver

`endif //  `ifndef TAMARACK_UART_DRIVER_SVH
