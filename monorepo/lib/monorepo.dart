import 'dart:io';

class Monorepo {
  const Monorepo(this.root);

  final Directory root;

  Future<void> test() async {}

  Future<void> review() async {}

  Future<void> publish() async {}

  Future<void> pubIgnore() async {}

  Future<void> resolveVersions() async {}
}
