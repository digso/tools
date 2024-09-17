# StrictLints

[English](./README.md) | [中文](./README.zh.md)

严格的代码检查配置及其从官网文档中爬取配置的程序。

## 如何使用代码检查选项

首先，将该包作为您的仓库的开发依赖项(dev-dependencies)添加。
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
作为贡献者，欢迎你将你的名字添加到[贡献者名单文件](./CONTRIBUTORS)中。
并请遵循根目录 README.md 文件中所述的规范。
