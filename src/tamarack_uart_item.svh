`ifndef TAMARACK_UART_ITEM_SVH
`define TAMARACK_UART_ITEM_SVH

typedef enum bit {
	TRANSMIT = 1'b0,
	RECEIVE = 1'b1
} tamarack_uart_dir;

class tamarack_uart_item extends uvm_sequence_item;

	function new(string name = "tamarack_uart_item");
		super.new(name);
	endfunction // new

	rand bit [15:0]        data;
	rand tamarack_uart_dir dir;
	rand bit               parity;
	rand integer		   length;

	`uvm_object_utils_begin(tamarack_uart_item)
		`uvm_field_int(data, UVM_DEFAULT)
		`uvm_field_enum(tamarack_uart_dir, dir, UVM_DEFAULT)
		`uvm_field_int(parity, UVM_DEFAULT)
		`uvm_field_int(length, UVM_DEFAULT)
	`uvm_object_utils_end

endclass // tamarack_uart_item

`endif
