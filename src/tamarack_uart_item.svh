`ifndef TAMARACK_UART_ITEM_SVH
`define TAMARACK_UART_ITEM_SVH

typedef enum bit {
	TAMARACK_UART_VIP_DIR_TRANSMIT = 1'b0,
	TAMARACK_UART_VIP_DIR_RECEIVE = 1'b1
} tamarack_uart_dir;

typedef enum bit {
	TAMARACK_UART_VIP_DATA_ORDER_LSB_FIRST = 1'b0,
	TAMARACK_UART_VIP_DATA_ORDER_MSB_FIRST = 1'b1
} tamarack_uart_data_order;

class tamarack_uart_item extends uvm_sequence_item;

	function new(string name = "tamarack_uart_item");
		super.new(name);
	endfunction // new

	rand bit [15:0]   data;
	tamarack_uart_dir direction;
	integer           length;
	bit               parity_error;

	`uvm_object_utils_begin(tamarack_uart_item)
		`uvm_field_int(data, UVM_DEFAULT)
		`uvm_field_enum(tamarack_uart_dir, direction, UVM_DEFAULT)
		`uvm_field_int(length, UVM_DEFAULT)
		`uvm_field_int(parity_error, UVM_DEFAULT)
	`uvm_object_utils_end

	constraint c_data_mask {
		(data >> length) == 0;
	}

endclass // tamarack_uart_item

`endif
