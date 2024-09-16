import 'package:args/command_runner.dart';
import 'package:monorepo/monorepo.dart';

void main(List<String> arguments) async {
  final cmd = CommandRunner('monorepo', 'A monorepo manager for Dart/Flutter.')
    ..addCommand(ReviewCommand())
    ..addCommand(TestCommand());

  await cmd.run(arguments);
}
