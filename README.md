<img src="https://github.com/felangel/equatable/raw/master/doc/assets/equatable_logo_full.png" width="100%" alt="logo" />
<h2 align="center">
  Simplify Equality Comparisons
</h2>
<p align="center">
  <a href="https://travis-ci.org/felangel/equatable">
    <img alt="Build Status" src="https://travis-ci.org/felangel/equatable.svg?branch=master">
  </a>
  <a href="https://codecov.io/gh/felangel/equatable">
    <img alt="Code Coverage" src="https://codecov.io/gh/felangel/equatable/branch/master/graph/badge.svg">
  </a>
  <a href="https://pub.dartlang.org/packages/equatable">
    <img alt="Pub Package" src="https://img.shields.io/pub/v/equatable.svg">
  </a>
  <br/>
  <a href="https://opensource.org/licenses/MIT">
    <img alt="MIT License" src="https://img.shields.io/badge/License-MIT-blue.svg">
  </a>
  <a href="https://gitter.im/equatable_package/community">
    <img alt="Gitter" src="https://img.shields.io/badge/gitter-equatable-yellow.svg">
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
  final String name;

  const Person(this.name);
}
```

We can create create instances of `Person` like so:

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
  final String name;

  const Person(this.name);

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

There are other packages that will actually generate the boilerplate for you; however, you still have to run the code generation step which is not ideal.

With `Equatable` there is no code generation needed and we can focus more on writing amazing applications and less on mundane tasks.

## Usage

First, we need to do add `equatable` to the dependencies of the `pubspec.yaml`

```yaml
dependencies:
  equatable: ^0.3.0
```

Next, we need to install it:

```sh
# Dart
pub get

# Flutter
flutter packages get
```

Lastly, we need to extend `Equatable`

```dart
import 'package:equatable/equatable.dart';

class Person extends Equatable {
  final String name;

  Person(this.name) : super([name]);
}
```

When working with json:

```dart
import 'package:equatable/equatable.dart';

class Person extends Equatable {
  final String name;

  Person(this.name) : super([name]);

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(json['name']);
  }
}
```

We can now compare instances of `Person` just like before without the pain of having to write all of that boilerplate.
**Note:** Equatable is designed to only work with immutable objects so all member variables must be final.

## Recap

### Without Equatable

```dart
class Person {
  final String name;

  const Person(this.name);

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

class Person extends Equatable {
  final String name;

  Person(this.name) : super([name]);
}
```

## EquatableMixin

Sometimes it isn't possible to extend `Equatable` because your class already has a superclass.
In this case, you can still get the benefits of `Equatable` by using the `EquatableMixin`.

### Usage

Let's say we want to make an `EquatableDateTime` class, we can use `EquatableMixinBase` and `EquatableMixin` like so:

```dart
class EquatableDateTime extends DateTime
    with EquatableMixinBase, EquatableMixin {
  EquatableDateTime(
    int year, [
    int month = 1,
    int day = 1,
    int hour = 0,
    int minute = 0,
    int second = 0,
    int millisecond = 0,
    int microsecond = 0,
  ]) : super(year, month, day, hour, minute, second, millisecond, microsecond);

  @override
  List get props {
    return [year, month, day, hour, minute, second, millisecond, microsecond];
  }
}
```

Now if we want to create a subclass of `EquatableDateTime`, we can continue to just use the `EquatableMixin` and override `props`.

```dart
class EquatableDateTimeSubclass extends EquatableDateTime with EquatableMixin {
  final int century;

  EquatableDateTime(
    this.century,
    int year,[
    int month = 1,
    int day = 1,
    int hour = 0,
    int minute = 0,
    int second = 0,
    int millisecond = 0,
    int microsecond = 0,
  ]) : super(year, month, day, hour, minute, second, millisecond, microsecond);

  @override
  List get props => super.props..addAll([century]);
}
```

## Performance

You might be wondering what the performance impact will be if you use `Equatable`.

[Performance Tests](https://github.com/felangel/equatable/raw/master/performance_tests) have been written to test how `Equatable` stacks up to manually overriding `==` and `hashCode` in terms of class instantiation as well as equality comparison.

### Results (average over 10 runs)

#### Equality Comparison A == A

| Class              | Runtime (microseconds) |
| ------------------ | ---------------------- |
| RAW                | 0.143                  |
| Empty Equatable    | 0.124                  |
| Hydrated Equatable | 0.126                  |

#### Instantiation A()

| Class              | Runtime (microseconds) |
| ------------------ | ---------------------- |
| RAW                | 0.099                  |
| Empty Equatable    | 0.121                  |
| Hydrated Equatable | 0.251                  |
