#!/usr/bin/env dart

import 'package:unscripted/unscripted.dart';

import 'commands/build.dart';
import 'commands/cache.dart';

main(arguments) => declare(Pub).execute(arguments);

class Pub extends Object with BuildCommand {

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

  @SubCommand(help: 'Work with the system cache.')
  CacheCommand cache() => new CacheCommand(this);

  // ...
}
