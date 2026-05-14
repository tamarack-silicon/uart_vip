interface tamarack_uart_if;

	logic tx; // Transmit
	logic rx; // Receive
	logic cts; // Clear to send
	logic rts; // Request to send
	logic de; // RS-485 Drive Enable

	modport internal (
		input rx, cts,
		output tx, rts, de
	);

	modport external (
		input tx, rts, de,
		output rx, cts
	);

endinterface // tamarack_uart_if
