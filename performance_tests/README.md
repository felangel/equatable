# Equatable Performance Tests

Benchmarks to measure how using `Equatable` will impact performance.


## Running the Performance Tests

```sh
dart main.dart
```

## Results (average over 10 runs)

### Equality Comparison A == A

| Class              | Runtime (microseconds) |
| ------------------ | ---------------------- |
| RAW                | 0.143                  |
| Empty Equatable    | 0.124                  |
| Hydrated Equatable | 0.126                  |

### Instantiation A()

| Class              | Runtime (microseconds) |
| ------------------ | ---------------------- |
| RAW                | 0.099                  |
| Empty Equatable    | 0.251                  |
| Hydrated Equatable | 0.121                  |