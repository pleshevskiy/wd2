# *W*rapped _d2_

A wrapper over [d2] which allows to use \`layout\`, \`theme\`, \`pad\`
attributes from d2 file. All arguments will be passed to the d2 cli, but these
additional configs overwrite cli arguments with the same name.

[d2]: https://github.com/terrastruct/d2

# Install

## Nix Flake

This repo is also packaged via Nix flakes, the package is available through the
default flake output `github:pleshevskiy/wd2` with the path `bin/wd2`.

You can enable flakes support in your nix configuration, and then run nix
profile install `github:pleshevskiy/wd2` to get `wd2` installed. You can also
use this repository as a flake input and add its output to your own
flake-managed systemwide or home configuration.

## Other

Copy `wd2` script to `/usr/local/bin` folder.

# Usage

Create a d2 file with additional configs at the top.

```d2
# layout: elk
# theme: 101
# pad: 5

x -> y -> z
```

Then run the `wd2` script

```sh
wd2 -w path/to/your/file.d2
```

You can also use inline style to configure d2

```d2
# layout: elk; theme: 101; pad: 5

x -> y -> z
```

# Limitation

You have to restart the watch server when you change the `layout` / `theme` /
`pad` attributes
