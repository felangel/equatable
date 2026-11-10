import 'package:benchmarking/benchmarking.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class EmptyEquatable extends Equatable {
  @override
  List<Object?> get props => const [];
}

class PrimitiveEquatable extends Equatable {
  const PrimitiveEquatable(this.integer, this.string, this.boolean);

  final int integer;
  final String string;
  final bool boolean;

  @override
  List<Object?> get props => [integer, string, boolean];
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
  List<Object?> get props => [list, map, set];
}

class SingleCollectionEquatable extends Equatable {
  const SingleCollectionEquatable(this.value);

  final Object value;

  @override
  List<Object?> get props => [value];
}

@immutable
class _CollidingKey {
  const _CollidingKey(this.value);

  final int value;

  @override
  bool operator ==(Object other) =>
      other is _CollidingKey && other.value == value;

  @override
  int get hashCode => 1;
}

void main() {
  _runBenchmark(
    'EmptyEquatable',
    (_) => EmptyEquatable(),
    supportsUnequal: false,
  );
  _runBenchmark(
    'PrimitiveEquatable',
    (index) => PrimitiveEquatable(index, '$index', index.isEven),
  );

  for (final size in [1, 10, 100]) {
    _runBenchmark(
      'CollectionEquatable ($size items per collection)',
      (index) => CollectionEquatable(
        list: List.generate(size, (i) => index + i),
        map: {for (var i = 0; i < size; i++) '$i': index + i},
        set: {for (var i = 0; i < size; i++) index + i},
      ),
    );
    _runBenchmark(
      'SetEquatable ($size items)',
      (index) => SingleCollectionEquatable(
        {for (var i = 0; i < size; i++) index + i},
      ),
    );
    _runBenchmark(
      'LazyIterableEquatable ($size items)',
      (index) => SingleCollectionEquatable(
        Iterable<int>.generate(size, (i) => index + i),
      ),
    );
    _runBenchmark(
      'MapEquatable ($size items)',
      (index) => SingleCollectionEquatable({
        for (var i = 0; i < size; i++) '$i': index + i,
      }),
    );
  }

  // Ensure that equal-key hash collisions and nested Sets are represented
  // without making every benchmark operation quadratic at size 100.
  _runBenchmark(
    'CollidingMapEquatable (16 items)',
    (index) => SingleCollectionEquatable({
      for (var i = 0; i < 16; i++) _CollidingKey(i): index + i,
    }),
  );
  _runBenchmark(
    'NestedSetEquatable (10 lists)',
    (index) => SingleCollectionEquatable(<List<int>>{
      for (var i = 0; i < 10; i++) [index + i, i],
    }),
  );
}

/// Pairs are independently constructed, never identical. The equal benchmark
/// must traverse the whole props list; the unequal benchmark has an early exit.
/// Hashing is benchmarked separately so cost is not hidden by that early exit.
void _runBenchmark(
  String name,
  Equatable Function(int index) create, {
  bool supportsUnequal = true,
}) {
  const poolSize = 100;
  final left = List<Equatable>.generate(poolSize, create);
  final equalRight = List<Equatable>.generate(poolSize, create);
  final unequalRight = List<Equatable>.generate(
    poolSize,
    (index) => create(index + poolSize),
  );

  // Check the scenario, rather than reporting misleading throughput for
  // accidentally-identical references or accidentally-unequal fixtures.
  for (var index = 0; index < poolSize; index++) {
    if (identical(left[index], equalRight[index]) ||
        left[index] != equalRight[index]) {
      throw StateError('$name: equal fixture is invalid at $index');
    }
    if (supportsUnequal && left[index] == unequalRight[index]) {
      throw StateError('$name: unequal fixture is invalid at $index');
    }
  }

  var equalMatches = 0;
  syncBenchmark('$name — equal', () {
    for (var i = 0; i < poolSize; i++) {
      if (left[i] == equalRight[i]) equalMatches++;
    }
  }).report(units: poolSize);

  var unequalMatches = 0;
  if (supportsUnequal) {
    syncBenchmark('$name — unequal', () {
      for (var i = 0; i < poolSize; i++) {
        if (left[i] != unequalRight[i]) unequalMatches++;
      }
    }).report(units: poolSize);
  }

  var hashSink = 0;
  syncBenchmark('$name — hashCode', () {
    for (final value in left) {
      hashSink = 0x1fffffff & (hashSink + value.hashCode);
    }
  }).report(units: poolSize);

  assert(equalMatches > 0, 'Equal scenario was not exercised');
  assert(
    !supportsUnequal || unequalMatches > 0,
    'Unequal scenario was not exercised',
  );
  assert(hashSink >= 0, 'Hash result must be observable');
}
