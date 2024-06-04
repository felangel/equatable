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
          total runs:  2 064 037   
          total time:     2.0000  s
         average run:          0 μs
         runs/second:   Infinity
               units:        100   
        units/second:   Infinity
       time per unit:     0.0000 μs

PrimitiveEquatable
          total runs:    729 555   
          total time:     2.0000  s
         average run:          2 μs
         runs/second:    500 000   
               units:        100   
        units/second: 50 000 000   
       time per unit:     0.0200 μs

CollectionEquatable (static, small)
          total runs:     51 944   
          total time:     2.0000  s
         average run:         38 μs
         runs/second:     26 316   
               units:        100   
        units/second:  2 631 579   
       time per unit:     0.3800 μs

CollectionEquatable (static, medium)
          total runs:     44 572   
          total time:     2.0000  s
         average run:         44 μs
         runs/second:     22 727   
               units:        100   
        units/second:  2 272 727   
       time per unit:     0.4400 μs

CollectionEquatable (static, large)
          total runs:     21 027   
          total time:     2.0001  s
         average run:         95 μs
         runs/second:     10 526   
               units:        100   
        units/second:  1 052 632   
       time per unit:     0.9500 μs

CollectionEquatable (dynamic, small)
          total runs:    400 934   
          total time:     2.0000  s
         average run:          4 μs
         runs/second:    250 000   
               units:        100   
        units/second: 25 000 000   
       time per unit:     0.0400 μs

CollectionEquatable (dynamic, medium)
          total runs:    400 408   
          total time:     2.0000  s
         average run:          4 μs
         runs/second:    250 000   
               units:        100   
        units/second: 25 000 000   
       time per unit:     0.0400 μs

CollectionEquatable (dynamic, large)
          total runs:    400 966   
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
