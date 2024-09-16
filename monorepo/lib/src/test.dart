import 'package:args/command_runner.dart';

class TestCommand extends Command {
  TestCommand() {
    argParser
      ..addOption(
        'root',
        abbr: 'r',
        help: 'Define root path of the monorepo.',
        defaultsTo: '.',
      )
      ..addFlag(
        'recursive',
        help: 'Whether to find all child repos and test recursively.',
        defaultsTo: true,
      );
  }

  @override
  final String name = 'test';

  @override
  final String description = 'Test the monorepo, run all unit tests.';

  @override
  void run() {}
}
