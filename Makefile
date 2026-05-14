# Verification IP dependency in 'ip' folder
IP_DEP := 

# Verification IP dependency in same folder as current ip
REPO_DEP := 

# Testbench top level module name
TESTS_TOP_NAME := uart_vip_tests_top

# Default UVM test name
TEST := uart_vip_base_test

include ip/flows/verification-ip.mk
