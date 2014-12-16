
library pub.commands.build;

import 'dart:io';

import 'package:unscripted/unscripted.dart';

import '../pub_unscripted.dart';

class BuildCommand {
  @SubCommand(help: 'Apply transformers to build a package.')
  build(
      @Rest(help: 'Directories to build')
      List<String> directories,
      {
      @Option(help: 'Mode to run transformers in.')
      String mode: 'release',
      @Flag(help: 'Use all default source directories.')
      bool all: false,
      @Option(help: 'How output should be displayed.', allowed: const ['text', 'json'], parser: parseOutputFormat)
      OutputFormat format: OutputFormat.text,
      @Option(abbr: 'o', help: 'Directory to write build outputs to.')
      String output: 'build'
      }) {
    var dirPaths = directories.isEmpty ? (all ? ['web'] : ['web']) : directories;
    var dirs = ((dirPaths.toList()..add('lib')).map((dirPath) => new Directory(dirPath))).toList();
    var outputDir = new Directory(output);
    _run(this, dirs, format, outputDir);
  }

  _run(
    Pub pub,
    List<Directory> directories,
    OutputFormat format,
    Directory out) {
    directories.forEach((dir) {
      if (pub.trace) {
        print('Building directory: ${dir.path}');
      }
    });
    var dirs = directories.map((directory) => directory.path).join(', ');
    print('Built directories "$dirs"');
    print('Build output sent to: "${out.path}"');
  }

}

enum OutputFormat {text, json}

parseOutputFormat(String format) =>
    OutputFormat.values.firstWhere(
        (OutputFormat outputFormat) => enumName(outputFormat) == format,
        orElse: () => throw 'Invalid output format "$format"');

enumName(enumValue) {
  var s = enumValue.toString();
  return s.substring(s.indexOf('.') + 1);
}
