Enclave_Name := ipfsenclave
Rust_Enclave_Name := libenclave.a
Rust_Enclave_Files := $(wildcard src/*.rs)
Rust_Target_Path := $(CURDIR)/../rust-sgx-sdk/xargo

Rust_Build_Mode ?= release
Rust_Build_Flags ?= --release
ifeq ($(SGX_DEBUG), 1)
	Rust_Build_Mode := debug
	Rust_Build_Flags := 
endif

ifeq ($(MITIGATION-CVE-2020-0551), LOAD)
export MITIGATION_CVE_2020_0551=LOAD
else ifeq ($(MITIGATION-CVE-2020-0551), CF)
export MITIGATION_CVE_2020_0551=CF
endif

.PHONY: all

all: $(Rust_Enclave_Name)

$(Rust_Enclave_Name): $(Rust_Enclave_Files)
ifeq ($(XARGO_SGX), 1)
	RUST_TARGET_PATH=$(Rust_Target_Path) xargo build --target x86_64-unknown-linux-sgx $(Rust_Build_Flags)
	cp ../target/x86_64-unknown-linux-sgx/$(Rust_Build_Mode)/lib$(Enclave_Name).a ../lib/$(Rust_Enclave_Name)
else
	cargo build $(Rust_Build_Flags)
	cp ../target/$(Rust_Build_Mode)/lib$(Enclave_Name).a ../lib/$(Rust_Enclave_Name)
endif