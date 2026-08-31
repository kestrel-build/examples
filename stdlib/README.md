# Standard-library examples

Short, runnable demos of the batteries in Kestrel's standard library.

| File | Module(s) | Shows |
|------|-----------|-------|
| [`sorting.kst`](sorting.kst) | `std.sort` | value-semantic sort (returns a new list), binary search |
| [`hashing.kst`](hashing.kst) | `std.hash` | FNV-1a, CRC-32, djb2 non-cryptographic hashes |
| [`encoding.kst`](encoding.kst) | `std.hex`, `std.base64` | encode/decode byte buffers, round-trips |
| [`formatting.kst`](formatting.kst) | `std.fmt` | radix, padding, thousands separators |
| [`random_demo.kst`](random_demo.kst) | `std.random` | seeded, reproducible PRNG |

Run one with the installed toolchain:

```bash
kestrel run sorting.kst
```

## Proving a program is leak-free — the memory ledger

Any Kestrel binary can report whether its heap balanced, with no valgrind needed
(works on release builds and other architectures too). Set `KESTREL_MEMLOG`:

```bash
KESTREL_MEMLOG=1 kestrel run sorting.kst
# ... program output ...
# MEMLOG: allocs=93 frees=93 live=0 alloc_bytes=1740 — CLEAN (all matched)
```

`live=0` means every allocation was freed. Use `KESTREL_MEMLOG=2` to also log each
`ALLOCATED <ptr> <size>` / `DEALLOCATED <ptr>` event for per-pointer matching.

> These demos `import std.*`; they run against a toolchain whose bundled standard
> library includes these modules.
