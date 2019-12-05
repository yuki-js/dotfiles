#!/bin/bash

curl https://sh.rustup.rs -sSf | sh
rustup toolchain add nightly
rustup component add rust-src
cargo +nightly install racer
