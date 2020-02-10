# 1.1.0

- Fix `hashCode` error when `props` is null
- Added `stringify` feature (optional `toString` override)

# 1.0.3

- Fix `hashCode` collisions for lists within props ([#53](https://github.com/felangel/equatable/pull/53))

# 1.0.2

- Fix internal lint warnings

# 1.0.1

- Fix `hashCode` collisions with `Map` properties ([#43](https://github.com/felangel/equatable/issues/43))

# 1.0.0

- Update hashCode implementation to use `Jenkins Hash` ([#39](https://github.com/felangel/equatable/issues/39))
- Documentation Updates

# 0.6.1

- Minor documentation updates

# 0.6.0

- The `props` getter override is required for both `Equatable` and `EquatableMixin`
- Performance Improvements

# 0.5.1

- Allow const constructors on `Equatable` class

# 0.5.0

- Removed `EquatableMixinBase` (now covered by `EquatableMixin`).
- Typed `EquatableMixin` from `List<dynamic>` to `List<Object>` to fix linter
  issues with `implicit-dynamic: false`.

# 0.4.0

Update `toString` to default to `runtimeType` ([#27](https://github.com/felangel/equatable/issues/27))

# 0.3.0

Enforce Immutability ([#25](https://github.com/felangel/equatable/issues/25))

# 0.2.6

Improved support for collection types ([#19](https://github.com/felangel/equatable/issues/19))

# 0.2.5

Improved support for `Iterable`, `List`, `Map`, and `Set` props ([#17](https://github.com/felangel/equatable/issues/17))

# 0.2.4

Additional Minor Documentation Updates

# 0.2.3

Documentation Updates

# 0.2.2

Bug Fixes:

- `Equatable` instances that are equal now have the same `hashCode` ([#8](https://github.com/felangel/equatable/issues/8))

# 0.2.1

Update Dart support to `>=2.0.0 <3.0.0`

# 0.2.0

Add `EquatableMixin` and `EquatableMixinBase`

# 0.1.10

Enhancements to `toString` override

# 0.1.9

equatable has 0 dependencies

# 0.1.8

Support `Iterable` props

# 0.1.7

Added `toString` override

# 0.1.6

Documentation Updates

- Performance Tests

# 0.1.5

Additional Performance Optimizations & Documentation Updates

# 0.1.4

Performance Optimizations

# 0.1.3

Bug Fixes

# 0.1.2

Additional Updates to Documentation.

- Logo Added

# 0.1.1

Minor Updates to Documentation.

# 0.1.0

Initial Version of the library.

- Includes the ability to extend `Equatable` and not have to override `==` and `hashCode`.
