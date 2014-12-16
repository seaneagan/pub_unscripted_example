
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
      bool all: false,
      @Option(help: 'Version constraint.')
      String version
  }) {
    var versions = all ? "all versions" : 'version "$version"';
    print('Added $versions of package "$package" to the cache.');
  }

  @SubCommand(help: 'Reinstall cached packages.')
  repair() {
    print('Repaired the cache.');
  }
}