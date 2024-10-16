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
          total runs:  7 984 597   
          total time:     2.0000  s
         average run:          0 μs
         runs/second:   Infinity
               units:        100   
        units/second:   Infinity
       time per unit:     0.0000 μs

PrimitiveEquatable
          total runs:  1 349 110   
          total time:     2.0000  s
         average run:          1 μs
         runs/second:  1 000 000   
               units:        100   
        units/second: 100 000 000   
       time per unit:     0.0100 μs

CollectionEquatable (static, small)
          total runs:     54 582   
          total time:     2.0000  s
         average run:         36 μs
         runs/second:     27 778   
               units:        100   
        units/second:  2 777 778   
       time per unit:     0.3600 μs

CollectionEquatable (static, medium)
          total runs:     46 839   
          total time:     2.0000  s
         average run:         42 μs
         runs/second:     23 810   
               units:        100   
        units/second:  2 380 952   
       time per unit:     0.4200 μs

CollectionEquatable (static, large)
          total runs:     20 867   
          total time:     2.0001  s
         average run:         95 μs
         runs/second:     10 526   
               units:        100   
        units/second:  1 052 632   
       time per unit:     0.9500 μs

CollectionEquatable (dynamic, small)
          total runs:    629 974   
          total time:     2.0000  s
         average run:          3 μs
         runs/second:    333 333   
               units:        100   
        units/second: 33 333 333   
       time per unit:     0.0300 μs

CollectionEquatable (dynamic, medium)
          total runs:    628 191   
          total time:     2.0000  s
         average run:          3 μs
         runs/second:    333 333   
               units:        100   
        units/second: 33 333 333   
       time per unit:     0.0300 μs

CollectionEquatable (dynamic, large)
          total runs:    632 540   
          total time:     2.0000  s
         average run:          3 μs
         runs/second:    333 333   
               units:        100   
        units/second: 33 333 333   
       time per unit:     0.0300 μs
```

_Last Updated: October 15, 2024 using `1316d20a576e6601687a5ecb672adee3f7723935`_

_MacBook Pro (M1 Pro, 16GB RAM)_

Dart SDK version: 3.5.3 (stable) (Wed Sep 11 16:22:47 2024 +0000) on "macos_arm64"
