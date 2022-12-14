ROOT_DIR = $(dir $(realpath $(firstword $(MAKEFILE_LIST))))
UI_DIR = $(ROOT_DIR)ui
FIRMWARE_DIR = $(ROOT_DIR)firmware

.PHONY: firmware
firmware:
	@echo MIX_ENV=$(MIX_ENV)
	@echo MIX_TARGET=$(MIX_TARGET)	
	@echo THERMALCAM_SSID=$(THERMALCAM_SSID)
	@echo THERMALCAM_PSK=$(THERMALCAM_PSK)
	cd $(UI_DIR); mix deps.get
	cd $(UI_DIR); mix assets.deploy
	cd $(FIRMWARE_DIR); mix deps.get; mix firmware

.PHONY: firmware.burn
firmware.burn:
	@echo MIX_ENV=$(MIX_ENV)
	@echo MIX_TARGET=$(MIX_TARGET)	
	@echo THERMALCAM_SSID=$(THERMALCAM_SSID)
	@echo THERMALCAM_PSK=$(THERMALCAM_PSK)
	cd $(FIRMWARE_DIR); mix firmware.burn
