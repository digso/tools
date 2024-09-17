import 'package:strict_lints/strict_lints.dart';
import 'package:test/test.dart';

void main() {
  test('all combinations', () {
    final values = {1, 2, 3, 4};
    final allCombinations = <Set<int>>{
      {},
      {1},
      {2},
      {3},
      {4},
      {1, 2},
      {1, 3},
      {1, 4},
      {2, 3},
      {2, 4},
      {3, 4},
      {1, 2, 3},
      {1, 2, 4},
      {1, 3, 4},
      {2, 3, 4},
      {1, 2, 3, 4},
    };
    expect(values.allCombinations, allCombinations);
  });
}
