# StrictLints

Strict linter options and its parser for Dart's official docs.

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
