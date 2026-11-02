{
  description = "Cargo Cult";
  inputs = { nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/*"; };

  outputs = { self, nixpkgs }:
    let
      aarch64-darwin = import nixpkgs { system = "aarch64-darwin"; };
      aarch64-linux = import nixpkgs { system = "aarch64-linux"; };
      x86_64-linux = import nixpkgs { system = "x86_64-linux"; };

      readme = { pkgs } : pkgs.writeTextFile { name = "readme"; executable = true; destination = "/bin/readme";
        text = ''#!${pkgs.stdenv.shell}
cat ${self}/README.md
        '';};

      cargo-cult = { pkgs } : pkgs.writeTextFile { name = "cargo-cult"; executable = true; destination = "/bin/cargo-cult";
        text = ''#!${pkgs.stdenv.shell}
set -e

# Create a unique temporary directory using Nix coreutils
TMP_DIR=$( ${pkgs.coreutils}/bin/mktemp -d )

# Set a trap to ensure the directory is removed on exit, no matter what happens
trap 'rm -rf "$TMP_DIR"' EXIT

# Run the ritual in a subshell to isolate directory changes
(
  cd "$TMP_DIR"
  ${pkgs.cargo}/bin/cargo new --bin hello --verbose
  cd hello
  pwd

  # The Ritual
  ls -lR .
  cat -n Cargo.toml
  cat -n src/main.rs
  ${pkgs.cargo}/bin/cargo check --verbose
  ${pkgs.cargo}/bin/cargo build --verbose
  ${pkgs.cargo}/bin/cargo test  --verbose
  ${pkgs.cargo}/bin/cargo run --verbose
)
        '';};

    in {
      packages.aarch64-darwin.default = readme { pkgs = aarch64-darwin; };
      packages.aarch64-linux.default = readme { pkgs = aarch64-linux; };
      packages.x86_64-linux.default = readme { pkgs = x86_64-linux; };

      packages.aarch64-darwin.cargo-cult = cargo-cult { pkgs = aarch64-darwin; };
      packages.aarch64-linux.cargo-cult = cargo-cult { pkgs = aarch64-linux; };
      packages.x86_64-linux.cargo-cult = cargo-cult { pkgs = x86_64-linux; };
    };
}

