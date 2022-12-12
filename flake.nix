{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    tools.url = "git+https://git.pleshevski.ru/mynix/tools";
  };

  outputs = { self, nixpkgs, flake-utils, tools, ... }:
    let
      inherit (builtins) readFile;

      mkWd2 = { writeShellApplication, symlinkJoin, d2, ... }:
        writeShellApplication {
          name = "wd2";
          runtimeInputs = [ d2 ];
          text = (readFile ./wd2);
        };
    in
    {
      overlays = {
        default = final: prev: {
          wd2 = prev.callPackage mkWd2 { };
        };
      };
    } //
    flake-utils.lib.eachDefaultSystem (system:
      let
        inherit (builtins) mapAttrs;
        pkgs = import nixpkgs { inherit system; };

        wd2 = pkgs.callPackage mkWd2 {
          d2 = tools.packages.${system}.d2;
        };

        mkApp = drv: flake-utils.lib.mkApp { inherit drv; };
        packages = {
          inherit wd2;
          default = wd2;
        };
      in
      {
        check = packages;

        inherit packages;

        apps = mapAttrs (name: mkApp) packages;
      });
}
