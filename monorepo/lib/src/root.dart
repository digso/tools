import 'dart:io';

class Monorepo {
  const Monorepo(this.root, {this.ignores = const []});

  final Directory root;
  final List<RegExp> ignores;

  static Future<Monorepo> init(Directory root) async => Monorepo(root);
}
