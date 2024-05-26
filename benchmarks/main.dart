import 'package:benchmarking/benchmarking.dart';
import 'package:equatable/equatable.dart';

class EmptyEquatable extends Equatable {
  @override
  List<Object> get props => [];
}

class PrimitiveEquatable extends Equatable {
  const PrimitiveEquatable({
    required this.integer,
    required this.string,
    required this.boolean,
  });

  final int integer;
  final String string;
  final bool boolean;

  @override
  List<Object> get props => [integer, string, boolean];
}

class CollectionEquatable extends Equatable {
  const CollectionEquatable({
    required this.list,
    required this.map,
    required this.set,
  });

  final List<int> list;
  final Map<String, int> map;
  final Set<int> set;

  @override
  List<Object> get props => [list, map, set];
}

void main() {
  _runBenchmark('EmptyEquatable', (_) => EmptyEquatable());

  _runBenchmark(
    'PrimitiveEquatable',
    (index) => PrimitiveEquatable(
      integer: index,
      string: '$index',
      boolean: index.isEven,
    ),
  );

  _runBenchmark(
    'CollectionEquatable (small)',
    (index) => CollectionEquatable(
      list: List.generate(1, (i) => index + i),
      map: Map.fromEntries(
        List.generate(1, (i) => MapEntry('${index + i}', index + i)),
      ),
      set: Set.from(List.generate(1, (i) => index + i)),
    ),
  );

  _runBenchmark(
    'CollectionEquatable (medium)',
    (index) => CollectionEquatable(
      list: List.generate(10, (i) => index + i),
      map: Map.fromEntries(
        List.generate(10, (i) => MapEntry('${index + i}', index + i)),
      ),
      set: Set.from(List.generate(10, (i) => index + i)),
    ),
  );

  _runBenchmark(
    'CollectionEquatable (large)',
    (index) => CollectionEquatable(
      list: List.generate(100, (i) => index + i),
      map: Map.fromEntries(
        List.generate(100, (i) => MapEntry('${index + i}', index + i)),
      ),
      set: Set.from(List.generate(100, (i) => index + i)),
    ),
  );
}

void _runBenchmark(String name, Object Function(int index) create) {
  const poolSize = 100;
  final pool = List.generate(poolSize, create);
  final poolA = [...pool]..shuffle();
  final poolB = [...pool]..shuffle();
  bool? result; // so that the loop isn't optimized out
  syncBenchmark(name, () {
    for (var i = 0; i < poolSize; i++) {
      result = poolA[i] == poolB[i];
    }
  }).report(units: poolSize);
  assert(result != null, 'result should be defined.');
}
