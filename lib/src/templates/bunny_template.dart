import 'package:flutter_bunny/src/common/logger_extension.dart';
import 'package:flutter_bunny/src/common/template.dart';
import 'package:flutter_bunny/src/templates/bunny_binary_template.dart';
import 'package:flutter_bunny/src/templates/post_generate_actions.dart';
import 'package:mason/mason.dart';
import 'package:path/path.dart' as path;
import 'package:universal_io/io.dart';

/// {@template very_good_core_template}
/// A core Flutter app template.
/// {@endtemplate}
class VeryGoodCoreTemplate extends Template {
  /// {@macro very_good_core_template}
  VeryGoodCoreTemplate()
      : super(
          name: 'core',
          bundle: veryGoodCoreBundle,
          help: 'Generate a Very Good Flutter application.',
        );

  @override
  Future<void> onGenerateComplete(Logger logger, Directory outputDir) async {
    if (await installFlutterPackages(logger, outputDir)) {
      await applyDartFixes(logger, outputDir);
    }
    _logSummary(logger, outputDir);
  }

  void _logSummary(Logger logger, Directory outputDir) {
    final relativePath = path.relative(
      outputDir.path,
      from: Directory.current.path,
    );

    final projectPath = relativePath;
    final projectPathLink =
        link(uri: Uri.parse(projectPath), message: projectPath);

    final readmePath = path.join(relativePath, 'README.md');
    final readmePathLink =
        link(uri: Uri.parse(readmePath), message: readmePath);

    final details = '''
  • To get started refer to $readmePathLink
  • Your project code is in $projectPathLink
''';

    logger
      ..info('\n')
      ..create('Created a Very Good App! 🦄')
      ..info(details)
      ..info(
        lightGray.wrap(
          '''
+----------------------------------------------------+
| Looking for more features?                         |
| We have an enterprise-grade solution for companies |
| called Very Good Start.                            |
|                                                    |
| For more info visit:                               |
| https://verygood.ventures/solution/very-good-start |
+----------------------------------------------------+''',
        ),
      );
  }
}
