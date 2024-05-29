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
          total runs:  2 076 295
          total time:     2.0000  s
         average run:          0 μs
         runs/second:   Infinity
               units:        100
        units/second:   Infinity
       time per unit:     0.0000 μs

PrimitiveEquatable
          total runs:    810 588
          total time:     2.0000  s
         average run:          2 μs
         runs/second:    500 000
               units:        100
        units/second: 50 000 000
       time per unit:     0.0200 μs

CollectionEquatable (small)
          total runs:    443 978
          total time:     2.0000  s
         average run:          4 μs
         runs/second:    250 000
               units:        100
        units/second: 25 000 000
       time per unit:     0.0400 μs

CollectionEquatable (medium)
          total runs:    442 368
          total time:     2.0000  s
         average run:          4 μs
         runs/second:    250 000
               units:        100
        units/second: 25 000 000
       time per unit:     0.0400 μs

CollectionEquatable (large)
          total runs:    450 915
          total time:     2.0000  s
         average run:          4 μs
         runs/second:    250 000
               units:        100
        units/second: 25 000 000
       time per unit:     0.0400 μs
```

_Last Updated: May 26, 2024 using `725b76c9ef072695f3ae4f036c4fa5e015528f13`_

_MacBook Pro (M1 Pro, 16GB RAM)_

_Dart SDK version: 3.3.4 (stable) (Tue Apr 16 19:56:12 2024 +0000) on "macos_arm64"_
