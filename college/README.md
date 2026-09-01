# College examples

Classic computer-science programs — the kind you meet in a first or second
programming course — written in Kestrel. Each is self-contained and runs on the
shipped toolchain.

| File | Concept |
|------|---------|
| [`fibonacci.kst`](fibonacci.kst) | iteration, recursion, and memoization (with `int64` for the big terms) |
| [`sieve.kst`](sieve.kst) | Sieve of Eratosthenes over a `List[bool]` |
| [`quicksort.kst`](quicksort.kst) | in-place quicksort (Lomuto partition, recursion) |
| [`towers_of_hanoi.kst`](towers_of_hanoi.kst) | the classic recursion exercise |
| [`linked_list.kst`](linked_list.kst) | a singly linked list via an index arena (no raw pointers needed) |
| [`hash_map.kst`](hash_map.kst) | a hash map by hand — open addressing with linear probing |

```bash
kestrel run fibonacci.kst
```

A note on style: Kestrel collections are value types, so these examples either
return new data or pass a `List` directly to a helper that updates it in place
(`.set()`/`.get()`), rather than mutating a collection wrapped inside a struct.
