<img src="https://github.com/felangel/equatable/raw/master/doc/assets/equatable_logo_full.png" width="100%" alt="logo" />
<h2 align="center">
  Simplify Equality Comparisons
</h2>

<p align="center">
  <a href="https://github.com/felangel/equatable/actions">
    <img alt="Build Status" src="https://github.com/felangel/equatable/workflows/build/badge.svg">
  </a>
  <a href="https://github.com/felangel/equatable/actions">
    <img alt="Code Coverage" src="https://raw.githubusercontent.com/felangel/equatable/master/coverage_badge.svg">
  </a>
  <a href="https://pub.dartlang.org/packages/equatable">
    <img alt="Pub Package" src="https://img.shields.io/pub/v/equatable.svg">
  </a>
  <br/>
  <a href="https://github.com/felangel/equatable">
    <img src="https://img.shields.io/github/stars/felangel/equatable.svg?style=flat&logo=github&colorB=deeppink&label=stars" alt="Star on GitHub">
  </a>
  <a href="https://github.com/tenhobi/effective_dart">
    <img alt="style: effective dart" src="https://img.shields.io/badge/style-effective_dart-40c4ff.svg">
  </a>  
  <a href="https://discord.gg/Hc5KD3g">
    <img src="https://img.shields.io/discord/649708778631200778.svg?logo=discord&color=blue" alt="Discord">
  </a>
  <a href="https://opensource.org/licenses/MIT">
    <img alt="MIT License" src="https://img.shields.io/badge/License-MIT-blue.svg">
  </a>
</p>

---

## Overview

Being able to compare objects in `Dart` often involves having to override the `==` operator as well as `hashCode`.

Not only is it verbose and tedious, but failure to do so can lead to inefficient code which does not behave as we expect.

By default, `==` returns true if two objects are the same instance.

Let's say we have the following class:

```dart
class Person {
  const Person(this.name);

  final String name;
}
```

We can create instances of `Person` like so:

```dart
void main() {
  final Person bob = Person("Bob");
}
```

Later if we try to compare two instances of `Person` either in our production code or in our tests we will run into a problem.

```dart
print(bob == Person("Bob")); // false
```

For more information about this, you can check out the official [Dart Documentation](https://www.dartlang.org/guides/language/effective-dart/design#equality).

In order to be able to compare two instances of `Person` we need to change our class to override `==` and `hashCode` like so:

```dart
class Person {
  const Person(this.name);

  final String name;

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    other is Person &&
    runtimeType == other.runtimeType &&
    name == other.name;

  @override
  int get hashCode => name.hashCode;
}
```

Now if we run the following code again:

```dart
print(bob == Person("Bob")); // true
```

it will be able to compare different instances of `Person`.

You can see how this can quickly become a hassle when dealing with complex classes. This is where `Equatable` comes in!

## What does Equatable do?

`Equatable` overrides `==` and `hashCode` for you so you don't have to waste your time writing lots of boilerplate code.

## Usage

First, we need to do add `equatable` to the dependencies of the `pubspec.yaml`

```yaml
dependencies:
  equatable: ^3.0.0
```

Next, we need to install it:

```sh
# Dart
pub get

# Flutter
flutter packages get
```

Lastly, we need to add the `@Equatable` annotation.

```dart
import 'package:equatable/equatable.dart';

@Equatable()
class Person {
  const Person(this.name);
  final String name;
}
```

We can now compare instances of `Person` just like before without the pain of having to write all of that boilerplate.
**Note:** Equatable is designed to only work with immutable objects so all member variables must be final (This is not just a feature of `Equatable` - [overriding a `hashCode` with a mutable value can break hash-based collections](https://dart.dev/guides/language/effective-dart/design#avoid-defining-custom-equality-for-mutable-classes)).

Equatable also supports `const` constructors:

```dart
import 'package:equatable/equatable.dart';

@Equatable()
class Person extends Equatable {
  const Person(this.name);
  final String name;
}
```

Equatable also supports nullable props:

```dart
import 'package:equatable/equatable.dart';

@Equatable()
class Person {
  const Person(this.name, [this.age]);
  final String name;
  final int? age;
}
```

## Recap

### Without Equatable

```dart
class Person {
  const Person(this.name);

  final String name;

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    other is Person &&
    runtimeType == other.runtimeType &&
    name == other.name;

  @override
  int get hashCode => name.hashCode;
}
```

### With Equatable

```dart
import 'package:equatable/equatable.dart';

@Equatable()
class Person {
  const Person(this.name);

  final String name;
}
```

## Benchmarks

You can check out and run performance benchmarks by heading over to [benchmarks](./benchmarks);

## Maintainers

- [Felix Angelov](https://github.com/felangel)
