extension StringUtils on String {
  String removePrefix(String prefix) =>
      startsWith(prefix) ? substring(prefix.length) : this;

  String removeSuffix(String suffix) =>
      endsWith(suffix) ? substring(0, length - suffix.length) : this;

  bool get hasParentheses => startsWith('(') && endsWith(')');

  String get removeParentheses => removePrefix('(').removeSuffix(')');

  String get capitalCase {
    if (isEmpty) return '';
    final first = substring(0, 1).toUpperCase();
    return length == 1 ? first : first + substring(1).toLowerCase();
  }
}
