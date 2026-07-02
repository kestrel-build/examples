# Kestrel Example Programs

Example programs written in [Kestrel](https://kestrel-build.github.io), a memory-safe, taint-aware systems programming language.

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
| `basics/` | Hello world, types, constants, math, functions |
| `control_flow/` | If/else, loops, match/case, break/continue |
| `data/` | Arrays, strings, tuples, enums, structs, classes |
| `ownership/` | Move semantics, borrowing, discard, const enforcement |
| `casting/` | Safe casts, const_cast, unsafe_cast |
| `concurrency/` | Flights (green threads), channels, atomics, mutex, rwlock |
| `error_handling/` | try/catch/finally, with blocks, defer |
| `security/` | Taint tracking, effects, capabilities, constant-time, crypto |
| `advanced/` | Unsafe, FFI, generics, traits, closures, modules, annotations, contracts, nullable, pattern matching |
| `showcase/` | Web server, kernel module, bare metal OS, ML pipeline, CLI app |
| `errors/` | Intentional compile failures showing what the compiler catches |

## Status

Examples marked `Status: implemented` work with the current compiler.
Examples marked `Status: designed` demonstrate planned features and serve as the language specification.

## License

Dual-licensed under MIT and Apache 2.0.
