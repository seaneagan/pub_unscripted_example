pub_unscripted_example
======================

Example of implementing pub with unscripted

## Installation
```shell
pub global activate -sgit https://github.com/seaneagan/pub_unscripted_example
```

## Usage
```shell
# Semantically highlighted help output
pub_unscripted -h

# Positional args
pub_unscripted help build

# Deeply nested commands
pub_unscripted cache add -h

# Install tab completion
pub_unscripted completion install
. ~/.bashrc

# Use tab completion
pub_unscripted --verbosity [TAB] -> all io normal solver
pub_unscripted cache [TAB] -> add repair
pub_unscripted b[TAB] -> build
pub_unscripted build --f[TAB] -> format
```