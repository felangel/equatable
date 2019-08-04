import 'package:meta/meta.dart';
import './equatable_utils.dart';

@immutable
abstract class Equatable {
  /// The [List] of `props` (properties) which will be used to determine whether
  /// two [Equatables] are equal.
  final List props;

  /// A class that helps implement equality
  /// without needing to explicitly override == and [hashCode].
  /// Equatables override their own == and [hashCode] based on
  /// the provided `properties`.
  ///
  /// The constructor takes an optional [List] of `props` (properties) which
  /// will be used to determine whether two [Equatables] are equal.
  /// If no properties are provided, `props` will be initialized to
  /// an empty [List].
  Equatable([this.props = const []]);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Equatable &&
          runtimeType == other.runtimeType &&
          equals(props, other.props);

  @override
  int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode(props);

  @override
  String toString() => '$runtimeType';
}
