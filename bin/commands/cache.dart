
library pub.commands.cache;

import 'package:unscripted/unscripted.dart';

import '../pub_unscripted.dart';

class CacheCommand {
  final Pub pub;

  CacheCommand(this.pub);

  @SubCommand(help: 'Install a package.')
  add(
      @Positional(help: 'The package to install.')
      String package,
      {
      @Flag(help: 'Install all matching versions.')
      bool all,
      @Option(help: 'Version constraint.')
      String version
  }) {
    // Add to the cache.
  }

  @SubCommand(help: 'Reinstall cached packages.')
  repair() {
    // Repair the cache.
  }
}