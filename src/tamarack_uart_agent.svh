`ifndef TAMARACK_UART_AGENT_SVH
`define TAMARACK_UART_AGENT_SVH

class tamarack_uart_agent extends uvm_agent;

	`uvm_component_utils(tamarack_uart_agent)

	tamarack_uart_driver driver;
	tamarack_uart_monitor monitor;
	uvm_sequencer#(tamarack_uart_item) sequencer;

	function new(string name = "tamarack_uart_agent", uvm_component parent = null);
		super.new(name, parent);
	endfunction // new

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		`uvm_info("TAMARACK_UART_AGENT", $sformatf("Tamarack Silicon Project UART Agent %s , is_active = %s", get_full_name(), get_is_active().name()), UVM_HIGH)

		if(get_is_active() == UVM_ACTIVE) begin
			sequencer = uvm_sequencer#(tamarack_uart_item)::type_id::create("uart_sequencer", this);
			driver = tamarack_uart_driver::type_id::create("uart_driver", this);
		end

		monitor = tamarack_uart_monitor::type_id::create("uart_monitor", this);
	endfunction // build_phase

	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		if(get_is_active() == UVM_ACTIVE) begin
			driver.seq_item_port.connect(sequencer.seq_item_export);
		end
	endfunction // connect_phase
	
endclass // tamarack_uart_agent

`endif //  `ifndef TAMARACK_UART_AGENT_SVH
