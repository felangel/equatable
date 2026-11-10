# Equatable benchmarks

These microbenchmarks measure **equal**, **unequal**, and **hashCode** operations
separately for primitive props and for lists, maps, sets, and lazy iterables.
Every equality comparison uses **two distinct objects**, even when their props
match. This is important because `identical(a, b)` bypasses value comparison.
Equal pairs must examine the full collection; unequal pairs may exit early.

## Run locally

From the `benchmarks/` directory:

```sh
dart pub get
dart run main.dart
dart compile exe main.dart -o equatable_benchmark
./equatable_benchmark
```

For comparison across commits, use the same machine, SDK version, compilation
mode, and power/performance settings. Run each version multiple times, compare
the **units/second** field for the same benchmark case, and report both median
and spread. Higher units/second is better.

Do not compare the previous published results with the new cases: the old harness
shuffled reference pools independently. Many comparisons exited on the first
unequal property and did not exercise the deeper collection algorithms.
Similarly, the old "static medium/large" maps always had one key because the
generated map entries all reused `'42'`.

## Coverage

- `EmptyEquatable`: no properties.
- `PrimitiveEquatable`: integer, string and boolean.
- `CollectionEquatable`: list, map, set, each of 1/10/100 values.
- `SetEquatable`: isolates set comparison/hash cost.
- `MapEquatable`: isolates Map lookups and hashing.
- `LazyIterableEquatable`: covers generic Iterable traversal.
- `FilteredIterableEquatable`: covers lazy traversal without efficient indexed access.
- `CollidingMapEquatable`: 16 entries whose keys share a hash code.
- `NestedSetEquatable`: 10 lists in a Set, exercising structural matching.

Every fixture is validated before timing begins, so an accidental identity
match or an unexpectedly unequal case cannot silently bias measurements.

Benchmarks provide comparative evidence, **not correctness validation**.
Run `dart test` at the package root and `dart analyze` as well.
