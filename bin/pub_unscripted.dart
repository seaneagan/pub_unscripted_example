#!/usr/bin/env dart

import 'dart:io';

import 'package:unscripted/unscripted.dart';

import 'commands/build.dart';
import 'commands/cache.dart';

main(arguments) => declare(Pub).execute(arguments);

class Pub {

  final bool trace;
  String get verbosity => _verbosity;
  String _verbosity;

  @Command(help: 'Pub is a package manager for Dart.', plugins: const [const Completion()])
  Pub({
      @Flag(help: 'Print debugging information when an error occurs.', negatable: true)
      this.trace: false,
      @Option(help: 'Control output verbosity.', allowed: const {
          'all': 'Show all output including internal tracing messages.',
          'io': 'Also show IO operations.',
          'normal': 'Show errors, warnings, and user messages.',
          'solver': 'Show steps during version resolution.'
      })
      String verbosity,
      @Flag(abbr: 'v', help: 'Shortcut for "--verbosity=all".')
      bool verbose: false
  }) {
    _verbosity = verbosity == null ? (verbose ? 'all' : 'normal') : verbosity;
  }

  @SubCommand(help: 'Apply transformers to build a package.')
  build(
      @Rest(help: 'Directories to build')
      List<String> directories,
      {
      @Option(help: 'Mode to run transformers in.')
      String mode: 'release',
      @Flag(help: 'Use all default source directories.')
      bool all: false,
      @Option(help: 'How output should be displayed.', allowed: const ['text', 'json'])
      String format: 'text',
      @Option(abbr: 'o', help: 'Directory to write build outputs to.')
      String output: 'build'
      }) {
    var dirPaths = directories.isEmpty ? (all ? ['web'] : ['web']) : directories;
    var dirs = (dirPaths.toList()..add('lib').map((dirPath) => new Directory(dirPath)));
    var outputFormat = OutputFormat.values.singleWhere((OutputFormat outputFormat) {
      outputFormat.toString().endsWith(format);
    });
    var outputDir = new Directory(output);

    buildCommand(this, dirs, outputFormat, outputDir);
  }

  @SubCommand(help: 'Work with the system cache.')
  CacheCommand cache() => new CacheCommand(this);

  // ...
}

enum OutputFormat {text, json}
