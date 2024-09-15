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

extension AllCombinations<T> on Set<T> {
  Set<Set<T>> get allCombinations => {{}, ...allCombinationsWithoutEmpty};

  Set<Set<T>> get allCombinationsWithoutEmpty {
    final initValue = {
      for (final item in this) {item},
    };
    final handler = [initValue];
    var currentLayer = initValue;
    for (var i = 1; i < length; i++) {
      final nextLayer = <Set<T>>{};
      for (final items in currentLayer) {
        for (final item in this) {
          if (items.contains(item)) continue;
          final current = {...items, item};

          var repeat = false;
          for (final already in nextLayer) {
            if (already.containsAll(current)) {
              repeat = true;
              continue;
            }
          }
          if (!repeat) nextLayer.add(current);
        }
      }
      handler.add(nextLayer);
      currentLayer = nextLayer;
    }
    return {for (final layer in handler) ...layer};
  }
}
