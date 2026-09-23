{
  description = "My doom emacs config";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-doom-emacs-unstraightened = {
      url = "github:marienz/nix-doom-emacs-unstraightened";
      inputs = {
        # If you use the home-manager module, you can set your doomdir here.
        # If your Doom configuration is in this flake:
        #doomdir.follows = "self";
        nixpkgs.follows = "nixpkgs";
      };
    };
  };
  outputs =
    {
      nixpkgs,
      nix-doom-emacs-unstraightened,
      self,
    }:
    let
      lib = nixpkgs.lib;
      mkDoom =
        {
          pkgs,
          emacs,
          localDir,
        }:
        let
          extraPackages = epkgs: [
            (epkgs.treesit-grammars.with-grammars (grammars: [
              grammars.tree-sitter-c
              grammars.tree-sitter-cpp
              grammars.tree-sitter-json
              grammars.tree-sitter-java
              grammars.tree-sitter-javascript
              grammars.tree-sitter-typescript
              grammars.tree-sitter-nix
              grammars.tree-sitter-bash
              grammars.tree-sitter-html
              grammars.tree-sitter-css
              grammars.tree-sitter-yaml
              grammars.tree-sitter-typst
              grammars.tree-sitter-nu
              grammars.tree-sitter-graphql
            ]))
          ];
          extraBinPackages = [
            pkgs.emacs-lsp-booster
            pkgs.zig
            pkgs.hunspell
            pkgs.aspell
            pkgs.dockfmt
            pkgs.sqlite
            pkgs.clang-tools
            pkgs.csharpier
            pkgs.libxml2
            pkgs.graphviz
            pkgs.go-grip
            pkgs.nixfmt
            pkgs.gnuplot
            pkgs.rust-analyzer
            pkgs.rustc
            pkgs.cargo
            pkgs.rustfmt
            pkgs.shfmt
            pkgs.shellcheck
            pkgs.fd
            pkgs.black
            pkgs.pipenv
            pkgs.python314Packages.pytest
            pkgs.html-tidy
            pkgs.stylelint
            pkgs.js-beautify
            pkgs.nixd
          ];
          args = {
            doomDir = ./.;
            doomLocalDir = localDir;
            profileName = "nix";
            experimentalFetchTree = true;
            inherit extraPackages extraBinPackages emacs;
            tangleArgs = null;
            emacsPackageOverrides = eself: esuper: { };
          };
        in
        (nix-doom-emacs-unstraightened.lib.doomFromPackages pkgs args).emacsWithDoom;
    in
    {
      hmModule = { config, ... }: {
        nixpkgs.overlays = [
          (final: prev: {
            doom-emacs = mkDoom {
              pkgs = final;
              emacs = final.emacs;
              localDir = "${config.xdg.dataHome}/nix-doom";
            };
            doom-emacs-nox = mkDoom {
              pkgs = final;
              emacs = final.emacs-nox;
              localDir = "${config.xdg.dataHome}/nix-doom";
            };
            doom-emacs-gtk = mkDoom {
              pkgs = final;
              emacs = final.emacs-gtk;
              localDir = "${config.xdg.dataHome}/nix-doom";
            };
            doom-emacs-pgtk = mkDoom {
              pkgs = final;
              emacs = final.emacs-pgtk;
              localDir = "${config.xdg.dataHome}/nix-doom";
            };
          })
        ];
      };
      packages = lib.genAttrs lib.systems.flakeExposed (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          doom-emacs = mkDoom {
            inherit pkgs;
            emacs = pkgs.emacs;
            localDir = "~/.local/share/nix-doom-unstraightened";
          };
          doom-emacs-nox = mkDoom {
            inherit pkgs;
            emacs = pkgs.emacs-nox;
            localDir = "~/.local/share/nix-doom-unstraightened";
          };
          doom-emacs-gtk = mkDoom {
            inherit pkgs;
            emacs = pkgs.emacs-gtk;
            localDir = "~/.local/share/nix-doom-unstraightened";
          };
          doom-emacs-pgtk = mkDoom {
            inherit pkgs;
            emacs = pkgs.emacs-pgtk;
            localDir = "~/.local/share/nix-doom-unstraightened";
          };
        }
      );
    };
}
