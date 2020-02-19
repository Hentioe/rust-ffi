#!/usr/bin/env bash

(cd ../core && cargo build --release)
mkdir lib -p
cp ../core/target/release/libcore.so lib/