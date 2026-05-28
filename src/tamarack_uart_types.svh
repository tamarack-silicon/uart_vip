`ifndef TAMARACK_UART_TYPES_SVH
`define TAMARACK_UART_TYPES_SVH

typedef enum bit {
	TAMARACK_UART_VIP_DIR_TRANSMIT = 1'b0,
	TAMARACK_UART_VIP_DIR_RECEIVE = 1'b1
} tamarack_uart_dir;

typedef enum bit {
	TAMARACK_UART_VIP_DATA_ORDER_LSB_FIRST = 1'b0,
	TAMARACK_UART_VIP_DATA_ORDER_MSB_FIRST = 1'b1
} tamarack_uart_data_order;

typedef enum bit [1:0] {
	TAMARACK_UART_VIP_PARITY_NONE = 2'b00,
	TAMARACK_UART_VIP_PARITY_EVEN = 2'b01,
	TAMARACK_UART_VIP_PARITY_ODD = 2'b10
} tamarack_uart_parity_type;

`endif //  `ifndef TAMARACK_UART_TYPES_SVH
