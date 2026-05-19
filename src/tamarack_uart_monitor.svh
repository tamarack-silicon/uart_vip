`ifndef TAMARACK_UART_MONITOR_SVH
`define TAMARACK_UART_MONITOR_SVH

class tamarack_uart_monitor extends uvm_monitor;

	`uvm_component_utils(tamarack_uart_monitor)

	uvm_analysis_port#(tamarack_uart_item) mon_analysis_port;
	virtual tamarack_uart_if uart_vif;
	integer	baud_rate;
	tamarack_uart_data_order data_order;
	integer data_bits;
	integer	stop_bits;

	function new(string name = "tamarack_uart_monitor", uvm_component parent = null);
		super.new(name, parent);
	endfunction // new

	function void update_config();
		if(!uvm_config_db#(integer)::get(null, get_parent().get_full_name(), "baud_rate", baud_rate)) begin
			`uvm_fatal("TAMARACK_UART_MONITOR", "Could not get baud_rate from config_db")
		end
		if(!uvm_config_db#(tamarack_uart_data_order)::get(null, get_parent().get_full_name(), "data_order", data_order)) begin
			`uvm_fatal("TAMARACK_UART_MONITOR", "Could not get data_order from config_db")
		end
		if(!uvm_config_db#(integer)::get(null, get_parent().get_full_name(), "data_bits", data_bits)) begin
			`uvm_fatal("TAMARACK_UART_MONITOR", "Could not get data_bits from config_db")
		end
		if(!uvm_config_db#(integer)::get(null, get_parent().get_full_name(), "stop_bits", stop_bits)) begin
			`uvm_fatal("TAMARACK_UART_MONITOR", "Could not get stop_bits from config_db")
		end
	endfunction // update_config

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("TAMARACK_UART_MONITOR", $sformatf("Tamarack Silicon Project UART Monitor %s", get_full_name()), UVM_HIGH)

		if(!uvm_config_db#(virtual tamarack_uart_if)::get(null, get_parent().get_full_name(), "uart_vif", uart_vif)) begin
			`uvm_fatal("TAMARACK_UART_MONITOR", "Could not get virtual interface from config_db")
		end
		update_config();

		mon_analysis_port = new("mon_analysis_port", this);
	endfunction // build_phase

	virtual task run_phase(uvm_phase phase);
		tamarack_uart_item m_item;

		super.run_phase(phase);

		forever begin
			update_config();

			m_item = tamarack_uart_item::type_id::create("uart_item");
			m_item.direction = TAMARACK_UART_VIP_DIR_RECEIVE;
			m_item.length = data_bits;
			m_item.parity_error = 1'b0;

			// Start bit
			#(1s/baud_rate);
			if(uart_vif.rx == 1'b1) begin
				continue;
			end
			`uvm_info("TAMARACK_UART_MONITOR", "Start bit detected, rx = 0", UVM_HIGH)

			// Data bits
			if(data_order == TAMARACK_UART_VIP_DATA_ORDER_LSB_FIRST) begin
				for(integer i = 0; i < data_bits; i++) begin
					#(1s/baud_rate);
					m_item.data[i] = uart_vif.rx;
					`uvm_info("TAMARACK_UART_MONITOR", $sformatf("Data bit %0d received, rx = %0d", i, m_item.data[i]), UVM_HIGH)
				end
			end else begin
				for(integer i = data_bits-1; i >=0 ; i--) begin
					#(1s/baud_rate);
					m_item.data[i] = uart_vif.rx;
					`uvm_info("TAMARACK_UART_MONITOR", $sformatf("Data bit %0d received, rx = %0d", i, m_item.data[i]), UVM_HIGH)
				end
			end

			// Stop bits
			for(integer i = 0; i < stop_bits; i++) begin
				#(1s/baud_rate);
				if(uart_vif.rx != 1'b1) begin
					`uvm_error("TAMARACK_UART_MONITOR", $sformatf("Stop bit %0d not detected, rx = 0", i))
				end else begin
					`uvm_info("TAMARACK_UART_MONITOR", $sformatf("Stop bit %0d detected, rx = 1", i), UVM_HIGH)
				end
			end

			`uvm_info("TAMARACK_UART_MONITOR", "Received item:", UVM_HIGH)
			m_item.print();

			mon_analysis_port.write(m_item);

		end

	endtask // run_phase

endclass // tamarack_uart_monitor

`endif //  `ifndef TAMARACK_UART_MONITOR_SVH
