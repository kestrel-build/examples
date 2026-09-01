# Algorithm examples

Real-world programs that exercise Kestrel across nested collections, `int64`
arithmetic beyond 2³¹, structs/enums, and recursion.

| File | What it shows |
|------|---------------|
| [`bfs.kst`](bfs.kst) | breadth-first search over a `List[List[int32]]` adjacency graph with a list-as-queue |
| [`dijkstra.kst`](dijkstra.kst) | shortest paths with `List[int64]` distances (weights exceed 2³¹) |
| [`histogram.kst`](histogram.kst) | bucketing `int64` measurements into a `HashMap[int32, int64]` |
| [`matrix.kst`](matrix.kst) | `int64` matrix multiply over `List[List[int64]]`, plus the trace |
| [`stats.kst`](stats.kst) | descriptive statistics (sum/min/max/mean/median) over a `List[int64]` including negatives |

Run one with the installed toolchain:

```bash
kestrel run bfs.kst
```

Every program here compiles, runs, and is valgrind-clean on the Kestrel
self-hosted compiler (the shipped toolchain), and each was written during the
compiler's own dogfooding — several surfaced and fixed real `int64`-in-collections
bugs along the way.
