# Equatable Lint

Official lint rules for development when using the Equatable package.

This package is built to work with:

- [equatable](https://pub.dev/packages/equatable)

---

## Quick Start

1. Install the [equatable_lint](https://pub.dev/packages/equatable_lint) package

   ```sh
   dart pub add --dev equatable_lint
   ```

2. Add an `analysis_options.yaml` to the root of your project with the
   recommended rules

   ```yaml
   analyzer:
      plugins:
         - equatable_lint
   ```

3. Run the linter

   ```sh
   dart analyze
   ```

## Dart Versions

- Dart 3: >= 3.10.0

## Maintainers

- [Felix Angelov](https://github.com/felangel)
