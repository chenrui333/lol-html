#!/bin/sh

set -e

echo "===  Running library tests... ==="
cargo clippy --features=integration_test --all-targets -- -Dwarnings
cargo test --features=integration_test "$@"

echo "=== Running C API tests... ==="
prove -e 'cargo' run ::  --manifest-path=./c-api/c-tests/Cargo.toml

echo "=== Building fuzzing test case code to ensure that it uses current API... ==="
cargo check --manifest-path=./fuzz/test_case/Cargo.toml

echo "=== Building the tooling test case code to ensure it uses the current API... ==="
cargo check --manifest-path=./tools/parser_trace/Cargo.toml
cargo check --manifest-path=./tools/selectors_ast/Cargo.toml
