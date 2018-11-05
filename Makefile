ROOT_DIR = $(dir $(realpath $(firstword $(MAKEFILE_LIST))))
UI_DIR = $(ROOT_DIR)ui
FIRMWARE_DIR = $(ROOT_DIR)firmware

.PHONY: firmware
firmware:
	@echo MIX_ENV=$(MIX_ENV)
	@echo MIX_TARGET=$(MIX_TARGET)	
	@echo NERVES_NETWORK_SSID=$(NERVES_NETWORK_SSID)
	@echo NERVES_NETWORK_PSK=$(NERVES_NETWORK_PSK)
	cd $(UI_DIR); mix deps.get
	cd $(UI_DIR)/assets; npm install; node_modules/.bin/brunch build --production
	cd $(UI_DIR); mix phx.digest
	cd $(FIRMWARE_DIR); mix deps.get; mix firmware

.PHONY: firmware.burn
firmware.burn:
	@echo MIX_ENV=$(MIX_ENV)
	@echo MIX_TARGET=$(MIX_TARGET)	
	@echo NERVES_NETWORK_SSID=$(NERVES_NETWORK_SSID)
	@echo NERVES_NETWORK_PSK=$(NERVES_NETWORK_PSK)
	cd $(FIRMWARE_DIR); mix firmware.burn
