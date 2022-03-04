#!/bin/bash

# @cmd
rust() {
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh   
    sudo apt install -y llvm-10
}

# @cmd
sgx_driver() {
    sudo apt-get install -y build-essential ocaml automake autoconf libtool wget python libssl-dev dkms
    wget -O /tmp/sgx_linux_x64_driver_1.41.bin https://download.01.org/intel-sgx/sgx-linux/2.14/distro/ubuntu20.04-server/sgx_linux_x64_driver_1.41.bin
    chmod +x /tmp/sgx_linux_x64_driver_1.41.bin
    sudo /tmp/sgx_linux_x64_driver_1.41.bin
}

# @cmd
sgx_pws() {
    echo 'deb [arch=amd64] https://download.01.org/intel-sgx/sgx_repo/ubuntu focal main' | sudo tee /etc/apt/sources.list.d/intel-sgx.list
    wget -qO - https://download.01.org/intel-sgx/sgx_repo/ubuntu/intel-sgx-deb.key | sudo apt-key add
    sudo apt update
    sudo apt install -y libsgx-dcap-ql libsgx-quote-ex libsgx-urts
    sudo apt install -y libsgx-dcap-ql-dev libsgx-quote-ex-dev
}

# @cmd
sgx_sdk() {
    sudo apt-get -y install build-essential python 
    wget -O /tmp/sgx_linux_x64_sdk_2.14.100.2.bin https://download.01.org/intel-sgx/sgx-linux/2.14/distro/ubuntu20.04-server/sgx_linux_x64_sdk_2.14.100.2.bin
    chmod +x /tmp/sgx_linux_x64_sdk_2.14.100.2.bin
    echo -e 'no\n/opt' | sudo /tmp/sgx_linux_x64_sdk_2.14.100.2.bin
}

eval "$(argc -e $0 "$@")"