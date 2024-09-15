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
      other.tags.length == tags.length &&
      other.tags.containsAll(tags);

  @override
  int get hashCode => Object.hashAll([Rule, name, status, ...tags]);

  /// ```html
  /// <p>
  ///   <!-- name -->
  ///   <a href="/tools/linter-rules/lint_rule_name">
  ///     <code>lint_rule_name</code>
  ///   </a>
  ///
  ///   <!-- status -->
  ///   <em>(Name)</em>
  ///   <br>
  ///
  ///   <!-- tags -->
  ///   <a href="/tools/linter-rules#docs-title-1">
  ///     <img src="/assets/img/tools/linter/filename-1.svg" alt="xxx">
  ///   </a>
  ///   <a href="/tools/linter-rules#docs-title-2">
  ///     <img src="/assets/img/tools/linter/filename-2.svg" alt="xxx">
  ///   </a>
  /// </p>
  /// ```
  static Rule? parse(Element element) {
    if (element.localName != 'p') return null;
    String? name;
    Status? status;
    final Set<Tag> tags = {};
    for (final child in element.children) {
      if (name == null) {
        name = parseName(child);
        continue;
      }
      if (status == null) {
        status = Status.parse(child);
        continue;
      }
      final tag = Tag.parse(child);
      if (tag != null) {
        tags.add(tag);
        continue;
      }
    }
    return name != null
        ? Rule(name, status: status ?? Status.stable, tags: tags)
        : null;
  }

  /// ```html
  /// <a href="/tools/linter-rules/lint_rule_name">
  ///   <code>lint_rule_name</code>
  /// </a>
  /// ```
  static String? parseName(Element element) {
    if (element.localName != 'a' ||
        element.children.firstOrNull?.localName != 'code') return null;

    final href = element.attributes['href']?.trim();
    if (href == null) return null;

    const prefix = '/tools/linter-rules/';
    if (!href.startsWith(prefix)) return null;
    final name = href.substring(prefix.length);
    return element.children.first.innerHtml.trim() == name ? name : null;
  }
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

    final href = element.attributes['href']?.trim();
    final path = element.children.firstOrNull?.attributes['src']?.trim();
    if (href == null || path == null) return null;

    for (final tag in Tag.values) {
      if (href == '/tools/linter-rules#${tag.docsTitle}' &&
          path == '/assets/img/tools/linter/${tag.filename}.svg') return tag;
    }
    return null;
  }
}
