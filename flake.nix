{
  description = "Virtual AI Patient — documentation dev shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            ruby_3_4
            gcc
            gnumake
            zlib
            libffi
            openssl
            pkg-config
          ];

          shellHook = ''
            export BUNDLE_PATH="$PWD/docs/vendor/bundle"
            export GEM_HOME="$PWD/docs/vendor/bundle"
            cd docs
            bundle config set --local path 'vendor/bundle'
            bundle install --quiet
            echo ""
            echo "Docs dev shell ready. Commands:"
            echo "  bundle exec jekyll serve --livereload   # live-reload dev server"
            echo "  bundle exec jekyll build                # one-shot build to _site/"
            echo ""
            echo "Site will be at: http://localhost:4000/platform/"
          '';
        };
      }
    );
}
