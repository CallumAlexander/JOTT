# Makefile to install JOTT and its config file

# DIRS
SCRIPT_DIR := $(HOME)/.local/bin
CONFIG_DIR := $(HOME)/.config/jott

# VARS
SCRIPT := jott
CONFIG := jott.cfg

# Default target
all: check_dependencies install

check_dependencies:
	@echo "[*] Checking for required dependencies..."
	@command -v awk >/dev/null 2>&1 || { echo >&2 "awk is required but it's not installed. Please install awk and try again."; exit 1; }
	@command -v curl >/dev/null 2>&1 || { echo >&2 "curl is required but it's not installed. Please install curl and try again."; exit 1; }
	@command -v timeout >/dev/null 2>&1 || { echo >&2 "timeout is required but it's not installed. Please install timeout and try again."; exit 1; }
	@command -v sed >/dev/null 2>&1 || { echo >&2 "sed is required but it's not installed. Please install sed and try again."; exit 1; }
	@command -v grep >/dev/null 2>&1 || { echo >&2 "grep is required but it's not installed. Please install grep and try again."; exit 1; }
	@command -v tr >/dev/null 2>&1 || { echo >&2 "tr is required but it's not installed. Please install tr and try again."; exit 1; }
	@command -v fold >/dev/null 2>&1 || { echo >&2 "fold is required but it's not installed. Please install fold and try again."; exit 1; }
	@echo "[+] All dependencies are met."

install:
	@echo "[*] Installing JOTT and its configuration file..."
	@mkdir -p $(SCRIPT_DIR)
	@echo "[+] JOTT directory created at "$(SCRIPT_DIR)""
	@cp $(SCRIPT) $(SCRIPT_DIR)
	@echo "[+] JOTT file copied to "$(SCRIPT_DIR)""
	@chmod +x $(SCRIPT_DIR)/$(SCRIPT)
	@echo "[+] Execute modifiers changed for "$(SCRIPT)""
	@mkdir -p $(CONFIG_DIR)
	@echo "[+] Config directory created at "$(CONFIG_DIR)""
	@cp $(CONFIG) $(CONFIG_DIR)
	@echo "[+] Configuration file copied to "$(CONFIG_DIR)""
	@echo "[+] Installation completed."

uninstall:
	@rm -f $(SCRIPT_DIR)/$(SCRIPT)
	@echo -e "[+] Uninstalled "$(SCRIPT_DIR)"/"$(SCRIPT)""
	@rm -f $(CONFIG_DIR)/$(CONFIG)
	@echo -e "[+] Uninstalled "$(CONFIG_DIR)"/"$(CONFIG)""
	@echo "[+] Uninstalled all JOTT files."

.PHONY: all check_dependencies install uninstall