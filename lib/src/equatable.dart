/// A class that helps implement determine equality
/// without needing to explicitly override == and [hashCode].
/// Equatables override their own == and [hashCode] based on
/// the provided `properties`.
abstract class Equatable {
  /// The [Set] of properties which will be used to determine whether
  /// two [Equatables] are equal.
  final Set props;

  /// The constructor takes an optional [Iterable] of `props` which
  /// will be used to determine whether two [Equatables] are equal.
  /// If no properties are provided, `props` will be initialized to
  /// `Iterable.empty()`.
  Equatable([Iterable props])
      : this.props = Set.from(props ?? Iterable.empty());

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Equatable &&
          runtimeType == other.runtimeType &&
          this.props.containsAll(other.props);

  @override
  int get hashCode => _hashCode();

  int _hashCode() {
    int hashCode = runtimeType.hashCode;

    props.forEach((prop) {
      hashCode = hashCode ^ prop.hashCode;
    });

    return hashCode;
  }
}
