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
          total runs:  7 741 659   
          total time:     2.0000  s
         average run:          0 μs
         runs/second:   Infinity
               units:        100   
        units/second:   Infinity
       time per unit:     0.0000 μs

PrimitiveEquatable
          total runs:  1 347 013   
          total time:     2.0000  s
         average run:          1 μs
         runs/second:  1 000 000   
               units:        100   
        units/second: 100 000 000   
       time per unit:     0.0100 μs

CollectionEquatable (static, small)
          total runs:     54 740   
          total time:     2.0000  s
         average run:         36 μs
         runs/second:     27 778   
               units:        100   
        units/second:  2 777 778   
       time per unit:     0.3600 μs

CollectionEquatable (static, medium)
          total runs:     45 852   
          total time:     2.0000  s
         average run:         43 μs
         runs/second:     23 256   
               units:        100   
        units/second:  2 325 581   
       time per unit:     0.4300 μs

CollectionEquatable (static, large)
          total runs:     20 328   
          total time:     2.0001  s
         average run:         98 μs
         runs/second:     10 204   
               units:        100   
        units/second:  1 020 408   
       time per unit:     0.9800 μs

CollectionEquatable (dynamic, small)
          total runs:    623 140   
          total time:     2.0000  s
         average run:          3 μs
         runs/second:    333 333   
               units:        100   
        units/second: 33 333 333   
       time per unit:     0.0300 μs

CollectionEquatable (dynamic, medium)
          total runs:    618 821   
          total time:     2.0000  s
         average run:          3 μs
         runs/second:    333 333   
               units:        100   
        units/second: 33 333 333   
       time per unit:     0.0300 μs

CollectionEquatable (dynamic, large)
          total runs:    627 611   
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
