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
          total runs:  2 042 216
          total time:     2.0000  s
         average run:          0 μs
         runs/second:   Infinity
               units:        100
        units/second:   Infinity
       time per unit:     0.0000 μs

PrimitiveEquatable
          total runs:    720 108
          total time:     2.0000  s
         average run:          2 μs
         runs/second:    500 000
               units:        100
        units/second: 50 000 000
       time per unit:     0.0200 μs

CollectionEquatable (static, small)
          total runs:    405 148
          total time:     2.0000  s
         average run:          4 μs
         runs/second:    250 000
               units:        100
        units/second: 25 000 000
       time per unit:     0.0400 μs

CollectionEquatable (static, medium)
          total runs:    412 849
          total time:     2.0000  s
         average run:          4 μs
         runs/second:    250 000
               units:        100
        units/second: 25 000 000
       time per unit:     0.0400 μs

CollectionEquatable (static, large)
          total runs:    402 613
          total time:     2.0000  s
         average run:          4 μs
         runs/second:    250 000
               units:        100
        units/second: 25 000 000
       time per unit:     0.0400 μs

CollectionEquatable (dynamic, small)
          total runs:    405 483
          total time:     2.0000  s
         average run:          4 μs
         runs/second:    250 000
               units:        100
        units/second: 25 000 000
       time per unit:     0.0400 μs

CollectionEquatable (dynamic, medium)
          total runs:    402 934
          total time:     2.0000  s
         average run:          4 μs
         runs/second:    250 000
               units:        100
        units/second: 25 000 000
       time per unit:     0.0400 μs

CollectionEquatable (dynamic, large)
          total runs:    408 285
          total time:     2.0000  s
         average run:          4 μs
         runs/second:    250 000
               units:        100
        units/second: 25 000 000
       time per unit:     0.0400 μs
```

_Last Updated: June 3, 2024 using `725b76c9ef072695f3ae4f036c4fa5e015528f13`_

_MacBook Pro (M1 Pro, 16GB RAM)_

Dart SDK version: 3.5.0-218.0.dev (dev) (Mon Jun 3 13:02:57 2024 -0700) on "macos_arm64"
