## 0.3.0

- This version had been refactored that the APIs are
  completely different from the previous versions.
- Spider to parse Dart's Official API docs and write into config files.
- Linter rules data structure and configurable options overrides.
- Support for Chinese(`zh` locale) documentation.
- CI/CD is removed from current repo and moved to its outer monorepo.
- This version had been maintained by the DigSo Organization rather than
  only James Aprosail, the previous maintainer, himself. Stilled MIT Licensed.

## 0.2.0

- This version had been refactored that the APIs are
  completely different from the previous versions.
- Basic structure and elementary linter rules.
- CI/CD for publish onto [pub.dev](https://pub.dev).

## 0.1.1

- Disable require message in asserts.

## 0.1.0

- Basic lint options, setup manually.
- Also apply those lint options to this repo itself.

## 0.0.0

- Initial version as placeholder.
- The exact options had not been finished yet in this version.
- Spider get all APIs from [official site](https://dart.dev/tools/linter-rules),
  and parse the status of those rules, including:
  - Recommended by core, [dart lints](https://pub.dev/packages/lints)
    or [flutter lints](https://pub.dev/packages/flutter_lints).
  - Whether removed.
  - Whether unreleased.
  - Whether experimental.
