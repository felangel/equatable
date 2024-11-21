# Equatable Benchmarks

Benchmarks used to measure the performance of equality comparisons using `package:equatable`.

## Quick Start

1. Install dependencies
   `dart pub get`
1. Run the benchmarks
   `dart run main.dart`

## Results

**JIT**

```
EmptyEquatable
          total runs:  2 729 471
          total time:     2.0000  s
         average run:          0 μs
         runs/second:   Infinity
               units:        100
        units/second:   Infinity
       time per unit:     0.0000 μs

PrimitiveEquatable
          total runs:    669 972
          total time:     2.0000  s
         average run:          2 μs
         runs/second:    500 000
               units:        100
        units/second: 50 000 000
       time per unit:     0.0200 μs

CollectionEquatable (static, small)
          total runs:    144 932
          total time:     2.0000  s
         average run:         13 μs
         runs/second:     76 923
               units:        100
        units/second:  7 692 308
       time per unit:     0.1300 μs

CollectionEquatable (static, medium)
          total runs:     84 533
          total time:     2.0000  s
         average run:         23 μs
         runs/second:     43 478
               units:        100
        units/second:  4 347 826
       time per unit:     0.2300 μs

CollectionEquatable (static, large)
          total runs:     16 457
          total time:     2.0001  s
         average run:        121 μs
         runs/second:    8 264.5
               units:        100
        units/second:    826 446
       time per unit:     1.2100 μs

CollectionEquatable (dynamic, small)
          total runs:    388 236
          total time:     2.0000  s
         average run:          5 μs
         runs/second:    200 000
               units:        100
        units/second: 20 000 000
       time per unit:     0.0500 μs

CollectionEquatable (dynamic, medium)
          total runs:    382 155
          total time:     2.0000  s
         average run:          5 μs
         runs/second:    200 000
               units:        100
        units/second: 20 000 000
       time per unit:     0.0500 μs

CollectionEquatable (dynamic, large)
          total runs:    390 713
          total time:     2.0000  s
         average run:          5 μs
         runs/second:    200 000
               units:        100
        units/second: 20 000 000
       time per unit:     0.0500 μs
```

**AOT**

```
EmptyEquatable
          total runs:  1 615 534
          total time:     2.0000  s
         average run:          1 μs
         runs/second:  1 000 000
               units:        100
        units/second: 100 000 000
       time per unit:     0.0100 μs

PrimitiveEquatable
          total runs:    928 013
          total time:     2.0000  s
         average run:          2 μs
         runs/second:    500 000
               units:        100
        units/second: 50 000 000
       time per unit:     0.0200 μs

CollectionEquatable (static, small)
          total runs:    128 224
          total time:     2.0000  s
         average run:         15 μs
         runs/second:     66 667
               units:        100
        units/second:  6 666 667
       time per unit:     0.1500 μs

CollectionEquatable (static, medium)
          total runs:    104 624
          total time:     2.0000  s
         average run:         19 μs
         runs/second:     52 632
               units:        100
        units/second:  5 263 158
       time per unit:     0.1900 μs

CollectionEquatable (static, large)
          total runs:     33 653
          total time:     2.0000  s
         average run:         59 μs
         runs/second:     16 949
               units:        100
        units/second:  1 694 915
       time per unit:     0.5900 μs

CollectionEquatable (dynamic, small)
          total runs:    483 177
          total time:     2.0000  s
         average run:          4 μs
         runs/second:    250 000
               units:        100
        units/second: 25 000 000
       time per unit:     0.0400 μs

CollectionEquatable (dynamic, medium)
          total runs:    488 550
          total time:     2.0000  s
         average run:          4 μs
         runs/second:    250 000
               units:        100
        units/second: 25 000 000
       time per unit:     0.0400 μs

CollectionEquatable (dynamic, large)
          total runs:    494 041
          total time:     2.0000  s
         average run:          4 μs
         runs/second:    250 000
               units:        100
        units/second: 25 000 000
       time per unit:     0.0400 μs
```

_Last Updated: November 20, 2024 using `29e6c77a2e6b25e35cce66276bc2afeab1c805bd`_

_MacBook Pro (M1 Pro, 16GB RAM)_

Dart SDK version: Dart SDK version: 3.5.4 (stable) (Wed Oct 16 16:18:51 2024 +0000) on "macos_arm64"
