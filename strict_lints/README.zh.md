# StrictLints

[English](./README.md) | [中文](./README.zh.md)

严格的代码检查配置，尽可能多的启用代码规范规则，
这个库还包含了从 Dart 官方文档网站爬取所有最新 API 的工具。
严格的编码规则将帮助您防止 💩 山和技术债。
尽管 Dart 和 Flutter 官方提供了代码检查选项的模板，
如 [lints](https://pub.dev/packages/lints)
和 [flutter_lints](https://pub.dev/packages/flutter_lints)，
但这些规则过于宽松，无法提高生产力。
因此作者才写了这个库来进行更严格的代码规范检查。

## 原则

这个库复制了 [官方站点](https://pub.dev/packages/lints) 上尽可能多的选项，
除非它们已经过时、存在冲突，或者已经在 `flutter_lints` 库中启用。
`flutter_lints` 库也是当前库的依赖之一。

您可以仔细阅读 [官方站点](https://pub.dev/packages/lints) 上的文档。
您可以点击选项标题，它们是链接到带有示例的更详细文档的链接。
所有的代码检查选项都是精心设计且有用的。
因此这个库的作者希望尽可能地启用它们。

## 如何使用代码检查选项

首先，将该库作为您的仓库的开发依赖项(dev-dependencies)添加。
您不需要直接将代码引入到您的代码库中，这也将防止潜在的冲突。

```yaml
# pubspec.yaml
dev_dependencies:
  strict_lints: ^a.b.c # 这里的 a.b.c 推荐使用当前最新版本。
```

随后您需要将这些选项引入到您的 `analysis_options.yaml` 文件中。
如果您使用 Flutter，您可以这样配置：

```yaml
# analysis_options.yaml
include: package:strict_lints/flutter.yaml
```

如果您使用 Dart，更推荐使用另一种配置：

```yaml
# analysis_options.yaml
include: package:strict_lints/dart.yaml
```

因为在 Dart 和 Flutter 之间存在一些差异：
由代码检查工具指定的一些必要的标注(annotation)在 Flutter SDK 中，
当使用 Dart 时，它们是不可用的，这样您的代码将始终有代码检查警告。
所以请为您根据实际情况来配置。

## 开源协议和贡献者列表

本项目采用 [MIT 协议](LICENSE.txt)。
作为贡献者，欢迎您将您的名字添加到[贡献者名单文件](./CONTRIBUTORS)中。
并请遵循根目录 README.md 文件中所述的规范。
