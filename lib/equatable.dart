/// A mixin that helps implement equality without needing to explicitly override
/// `==` operators or `hashCode`s.
library equatable;

import 'package:collection/collection.dart'
    show DeepCollectionEquality, IterableExtension;

export './src/equatable.dart' show Equatable;

/// Deep collection equality.
final deepEquals = const DeepCollectionEquality.unordered().equals;

/// Returns a `hashCode` for [fields].
int jenkinsHash(Iterable<Object?>? fields) {
  return _finish(fields == null ? 0 : fields.fold(0, _combine));
}

/// Jenkins Hash Functions
/// https://en.wikipedia.org/wiki/Jenkins_hash_function
int _combine(int hash, Object? object) {
  if (object is Map) {
    object.keys
        .sorted((Object? a, Object? b) => a.hashCode - b.hashCode)
        .forEach((Object? key) {
      hash = hash ^ _combine(hash, [key, (object! as Map)[key]]);
    });
    return hash;
  }
  if (object is Set) {
    object = object.sorted((Object? a, Object? b) => a.hashCode - b.hashCode);
  }
  if (object is Iterable) {
    for (final value in object) {
      hash = hash ^ _combine(hash, value);
    }
    return hash ^ object.length;
  }

  hash = 0x1fffffff & (hash + object.hashCode);
  hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
  return hash ^ (hash >> 6);
}

int _finish(int hash) {
  hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
  hash = hash ^ (hash >> 11);
  return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
}
