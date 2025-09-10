SHELL := /bin/bash

###########################################################################
# Detect OS                                                               #
###########################################################################
ifeq ($(OS),Windows_NT)
	detected_OS := Windows
else
	detected_OS := $(shell uname)
endif

###########################################################################
# GLOBALS                                                                 #
###########################################################################

EXEC_NAME = rust_sorting
DOCLEAR =
BUILD_VERSION := 1.1.0
BUILD_NAME := $(EXEC_NAME)_$(BUILD_VERSION)_$(detected_OS)_$(detected_CPUArch)

###########################################################################
# OS Specifics                                                            #
###########################################################################
detected_OS := undefined
detected_CPUArch := undefined
UNAME_P := undefined

ifeq ($(OS),Windows_NT)
	detected_OS = Windows
	ifeq ($(PROCESSOR_ARCHITECTURE),AMD64)
		detected_CPUArch = x64
	else
		ifeq ($(PROCESSOR_ARCHITECTURE),x86)
			detected_CPUArch = x86
		else
			detected_CPUArch = UNK
		endif
	endif
else
	detected_OS := $(shell uname)
	UNAME_P := $(shell uname -p)
	ifeq ($(UNAME_P),x86_64)
		detected_CPUArch = x64
	else
		ifneq ($(filter %86,$(UNAME_P)),)
			detected_CPUArch = x86
		else
			ifneq ($(filter arm%,$(UNAME_P)),)
				detected_CPUArch = ARM
			else
				detected_CPUArch = UNK
			endif
		endif
	endif
endif

###########################################################################
# COMMANDS                                                                #
###########################################################################
.PHONY: info build-dbg build-rel run-dbg run-rel help

info: ## Information about the environemnt
	@echo Environment Informations
	@echo   * Detected OS: $(detected_OS)

clearterminal:
ifneq ($(DOCLEAR),)
ifeq ($(detected_OS),Windows)
	@cls
else
	@clear
endif
endif

build-dbg: ## Build app in debug mode
	@$(MAKE) clearterminal
	@cargo build

build-rel: ## Build app in release mode
	@$(MAKE) clearterminal
	@cargo build -r

release-mac-aarch64: ## Build for MAC ARM64
ifneq ($(filter %Darwin,$(detected_OS)),)
	@$(MAKE) clearterminal
	@echo This has not been tested
	@rustup target add aarch64-apple-darwin
	@cargo build -r --target=aarch64-apple-darwin
	@cp -f -v build/aarch64-apple-darwin/release/$(EXEC_NAME) release/$(EXEC_NAME)_$(BUILD_VERSION)_Mac_AARCH64
else
	@echo Cannot cross-build for MAC from $(detected_OS)
endif

release-linux-x64: ## Build for Linux
	@$(MAKE) clearterminal
	@rustup target add x86_64-unknown-linux-musl
	@cargo build -r --target=x86_64-unknown-linux-musl
ifeq ($(detected_OS),Windows)
	@xcopy /v /f /y build\x86_64-unknown-linux-musl\release\$(EXEC_NAME) release\$(EXEC_NAME)_$(BUILD_VERSION)_Linux_x64
else
	@echo This has not been tested
	@cp -f -v build/x86_64-unknown-linux-musl/release/$(EXEC_NAME) release/$(EXEC_NAME)_$(BUILD_VERSION)_Linux_x64
endif

release-win-x64: ## Build for Windows
	@$(MAKE) clearterminal
ifeq ($(detected_OS),Windows)
	@rustup target add x86_64-pc-windows-msvc
	@cargo build -r --target=x86_64-pc-windows-msvc
	@xcopy /v /f /y build\x86_64-pc-windows-msvc\release\$(EXEC_NAME).exe release\$(EXEC_NAME)_$(BUILD_VERSION)_Windows_x64.exe
else
	@$(MAKE) clearterminal
	@echo This has not been tested
	@rustup target add x86_64-pc-windows-gnu
	@cargo build -r --target=x86_64-pc-windows-gnu
	@cp -f -v build/x86_64-pc-windows-gnu/release/$(EXEC_NAME) release/$(EXEC_NAME)_$(BUILD_VERSION)_Windows_x64
endif

release-all: ## Release all builds possible on current platform
	@$(MAKE) release-mac-aarch64
	@echo ==================================
	@echo ==================================
	@echo ==================================
	@echo ==================================
	@$(MAKE) release-linux-x64
	@echo ==================================
	@echo ==================================
	@echo ==================================
	@echo ==================================
	@$(MAKE) release-win-x64

run-dbg: ## Run app in debug mode
	@$(MAKE) clearterminal
	@cargo run

run-rel: ## Run app in release mode
	@$(MAKE) clearterminal
	@cargo run -r

help: ## Show this help
ifeq ($(detected_OS),Windows)
	@grep -E "^[a-zA-Z0-9_-]+:.*?## .*$$" $(MAKEFILE_LIST) | sort
#| awk "BEGIN {FS = \":.*?## \"}; {printf \"\033[36m%-30s\033[0m %s\n\", $$1, $$2}"
else
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; \
	{printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
endif

.DEFAULT_GOAL := help
