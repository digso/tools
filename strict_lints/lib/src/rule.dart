import 'package:html/dom.dart';
import 'package:strict_lints/src/utils.dart';

class Rule {
  const Rule(this.name, {this.status = Status.stable, this.tags = const {}});

  final String name;
  final Status status;
  final Set<Tag> tags;

  @override
  String toString() {
    final status = this.status.isStable ? '' : '(${this.status.name})';
    final tags = this.tags.isEmpty ? '' : ': ${this.tags.join(', ')}';
    return '$name$status$tags';
  }

  @override
  bool operator ==(Object other) =>
      other is Rule &&
      other.name == name &&
      other.status == status &&
      other.tags == tags;

  @override
  int get hashCode => Object.hash(Rule, name, status, tags);
}

/// https://dart.dev/tools/linter-rules#status
enum Status {
  stable,
  experimental,
  deprecated,
  removed,
  unreleased;

  bool get isStable => this == stable;

  /// ```html
  /// <em>(Name)</em>
  /// ```
  static Status? parse(Element element) {
    if (element.localName != 'em') return null;

    String text = element.text.trim();
    if (!text.hasParentheses) return null;

    text = text.removeParentheses.trim();
    for (final status in Status.values) {
      if (text == status.name.capitalCase) return status;
    }
    return null;
  }
}

/// https://dart.dev/tools/linter-rules#sets
enum Tag {
  fix('has-fix', 'quick-fixes'),
  core('style-core', 'lints'),
  flutter('style-flutter', 'flutter_lints'),
  recommended('style-recommended', 'lints');

  const Tag(this.filename, this.docsTitle);

  final String filename;
  final String docsTitle;

  /// ```html
  /// <a href="/tools/linter-rules#docs-title">
  ///   <img src="/assets/img/tools/linter/filename.svg" alt="xxx">
  /// </a>
  /// ```
  static Tag? parse(Element element) {
    if (element.localName != 'a' ||
        element.children.firstOrNull?.localName != 'img') return null;

    final href = element.attributes['href'];
    final path = element.children.firstOrNull?.attributes['src'];
    if (href == null || path == null) return null;

    for (final tag in Tag.values) {
      if (href == '/tools/linter-rules#${tag.docsTitle}' &&
          path == '/assets/img/tools/linter/${tag.filename}.svg') return tag;
    }
    return null;
  }
}
