# StrictLints

[English](./README.md) | [中文](./README.zh.md)

A strict linter config that enable as much rules as possible,
and this package also contains the infrastructure to spider all latest APIs
from the official documentation website of dart lints.

A strict coding rule will help you to prevent 💩 from your code.
Although there are existing official linter options such as
the packages [lints](https://pub.dev/packages/lints)
and [flutter_lints](https://pub.dev/packages/flutter_lints),
those rules are too loose to be productive.
That's why this package exists,
which enables as much rules as possible.

## Principle

This package copies all possible options from the API
on the [official site](https://pub.dev/packages/lints)
except they are deprecated, conflicted,
or already enabled in the `flutter_lints` package,
which is already a dependency of current package.

You can read the documentation
on the [official site](https://pub.dev/packages/lints) carefully.
And you can click into the option titles,
which are links to the more detailed doc with examples.
All the linter options are well designed and useful.
So that the author of this package is willing to enable them
as much as possible.

## How to Use the Linter Options

First, add the package as a dev dependency of your repository.
In such case, there's no need introduce the code into your codebase directly,
and this will also prevent potential conflicts.

```yaml
# pubspec.yaml
dev_dependencies:
  strict_lints: ^a.b.c # Here a.b.c means the current latest version.
```

Then, you need to introduce such options into your `analysis_options.yaml` file.
If you are using Flutter, you can config like this:

```yaml
# analysis_options.yaml
include: package:strict_lints/flutter.yaml
```

If you are using Dart, it's more recommended to use another include like this:

```yaml
# analysis_options.yaml
include: package:strict_lints/dart.yaml
```

Because there are some differences between Dart and Flutter:
Some necessary annotations specified by the linter are in the FlutterSDK,
that when using Dart, they are not available,
and your code will always have linter warnings.
So please choose the right one for your repos.

## License and Contributors

This package is released under the [MIT License](LICENSE.txt).
As a contributor, you are welcomed to add your name into the
[Contributor's list file](./CONTRIBUTORS).
And please follow the specification in the root README.md file of the monorepo.
