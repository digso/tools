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
  fix,
  core,
  flutter,
  recommended;
}
