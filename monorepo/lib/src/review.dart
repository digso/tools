import 'package:args/command_runner.dart';

class ReviewCommand extends Command {
  ReviewCommand() {
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
  final String name = 'review';

  @override
  final String description = 'Review the monorepo, including test and analyze.';

  @override
  void run() {}
}
