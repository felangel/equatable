# Equatable Benchmarks

Benchmarks used to measure the performance of equality comparisons using `package:equatable`.

## Quick Start

1. Install dependencies
   `dart pub get`
1. Run the benchmarks
   `dart run main.dart`

## Results

```
EmptyEquatable
          total runs:  2 042 513
          total time:     2.0000  s
         average run:          0 μs
         runs/second:   Infinity
               units:        100
        units/second:   Infinity
       time per unit:     0.0000 μs

PrimitiveEquatable
          total runs:    686 863
          total time:     2.0000  s
         average run:          2 μs
         runs/second:    500 000
               units:        100
        units/second: 50 000 000
       time per unit:     0.0200 μs

CollectionEquatable (static, small)
          total runs:    142 582
          total time:     2.0000  s
         average run:         14 μs
         runs/second:     71 429
               units:        100
        units/second:  7 142 857
       time per unit:     0.1400 μs

CollectionEquatable (static, medium)
          total runs:    111 556
          total time:     2.0000  s
         average run:         17 μs
         runs/second:     58 824
               units:        100
        units/second:  5 882 353
       time per unit:     0.1700 μs

CollectionEquatable (static, large)
          total runs:     35 227
          total time:     2.0000  s
         average run:         56 μs
         runs/second:     17 857
               units:        100
        units/second:  1 785 714
       time per unit:     0.5600 μs

CollectionEquatable (dynamic, small)
          total runs:    400 138
          total time:     2.0000  s
         average run:          4 μs
         runs/second:    250 000
               units:        100
        units/second: 25 000 000
       time per unit:     0.0400 μs

CollectionEquatable (dynamic, medium)
          total runs:    402 805
          total time:     2.0000  s
         average run:          4 μs
         runs/second:    250 000
               units:        100
        units/second: 25 000 000
       time per unit:     0.0400 μs

CollectionEquatable (dynamic, large)
          total runs:    407 055
          total time:     2.0000  s
         average run:          4 μs
         runs/second:    250 000
               units:        100
        units/second: 25 000 000
       time per unit:     0.0400 μs
```

_Last Updated: October 11, 2024 using `8d283b02f073d3a18e4f63aa528f7e0209826ac7`_

_MacBook Pro (M1 Pro, 16GB RAM)_

Dart SDK version: Dart SDK version: 3.5.3 (stable) (Wed Sep 11 16:22:47 2024 +0000) on "macos_arm64"
