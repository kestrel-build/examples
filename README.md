# Kestrel Example Programs

[![Verify examples](https://github.com/kestrel-build/examples/actions/workflows/verify.yml/badge.svg)](https://github.com/kestrel-build/examples/actions/workflows/verify.yml)
[![Style](https://github.com/kestrel-build/examples/actions/workflows/style.yml/badge.svg)](https://github.com/kestrel-build/examples/actions/workflows/style.yml)

Example programs written in [Kestrel](https://kestrel-build.github.io), a memory-safe, taint-aware systems programming language.

## Verified vs. teaching examples

- **`verified/`** is the canonical, CI-tested set. Every program there is
  compiled **and run** against each published release binary by the
  [verify workflow](.github/workflows/verify.yml); its output is asserted
  against a `.expected` file (and exit code against `.exitcode`). Files under
  `verified/compile-fail/` must be *rejected* by the compiler. This is the
  public proof that a release actually works — it exercises the shipped binary,
  not the source. Run it yourself: `KESTREL=kestrel ./verified/verify.sh`.
- The category folders below (`basics/`, `control_flow/`, …) are the broader
  teaching set. Some are marked `Status: designed` and demonstrate planned
  syntax that does not compile yet.

## Running examples

Install Kestrel, then:

```bash
kestrel run basics/hello.kst
kestrel run basics/fibonacci.kst
kestrel run showcase/web_server.kst
```

## Directory Structure

| Directory | Description |
|-----------|-------------|
| `basics/` | Hello world, types, constants, math, functions, checked overflow |
| `control_flow/` | If/else, loops, match/case, break/continue |
| `data/` | Arrays, strings, tuples, enums, structs, classes |
| `ownership/` | Move semantics, borrowing, discard, const enforcement |
| `casting/` | Safe casts, const_cast, unsafe_cast |
| `concurrency/` | Flights (green threads), channels, atomics, mutex, rwlock |
| `error_handling/` | try/catch/finally, with blocks, defer |
| `security/` | Taint tracking, effects, capabilities, constant-time, crypto |
| `advanced/` | Unsafe, FFI, generics, traits, closures, modules, annotations, contracts, nullable, pattern matching |
| `showcase/` | Web server, Linux kernel module, Raspberry Pi bare-metal OS, ML pipeline, CLI app |
| `errors/` | Intentional compile failures showing what the compiler catches |

## Status

Examples marked `Status: implemented` work with the current compiler.
Examples marked `Status: designed` demonstrate planned features and serve as the language specification.

## License

Dual-licensed under MIT and Apache 2.0.
