#!/bin/bash

curl https://sh.rustup.rs -sSf | sh
rustup toolchain add nightly
cargo +nightly install racer
