# Cargo Cult

Part of the [Ex Nihilo: Fragmenta Mentis (Out of Nothing: Fragments of the Mind)](https://flakehub.com/flake/BaseLayer-AI/ex-nihilo-fragmenta-mentis-000?view=readme) series.

[Full AI transcript](https://nix-ontouchstart.github.io/nix-ontouchstart-llama_cpp-sessions/2026-11-02_17-34-33_cargo-cult)

### 1. What is Cargo Cult?

The term originates from the observation of communities who attempted to receive "cargo" by mimicking the behaviors of the soldiers and planes who had delivered it (building mock runways and watching towers). They replicated the **form** (the ritual) while remaining ignorant of the **function** (the logistics and technology).

In software engineering, **Cargo Cult Programming** occurs when developers use libraries, copy-paste boilerplate, or adopt architectures because "that's how it's done," without understanding the underlying logic. The result is "magic" code: it works, but no one knows why, making it difficult to debug or scale.

### 2. The `cargo new` Trap

The Rust command `cargo new` is a masterpiece of abstraction, but it provides a perfect entry point for Cargo Culting. 

With one command, it generates a directory structure, a `Cargo.toml` manifest, and a boilerplate source file. For a beginner, this feels like magic. However, if a developer treats this output as a sacred template—copying the files without understanding how the dependency graph is resolved, how the compiler optimizes the binary, or what the manifest actually declares—they are building a "mock runway." They have the project structure, but they lack the architectural understanding.

### 3. The Ritual in Code

The following Nix Flake is a piece of "performance art" that codifies this concept. It is a literal Cargo Cult: it automates the ritual of starting and running a project, then destroys the evidence.

**The Ritual:**
1.  **The Runway:** It creates a unique temporary directory.
2.  **The Ceremony:** It runs `cargo new`, then performs the standard sequence of `cargo check`, `build`, `test`, and `run`.
3.  **The Revelation:** It prints the contents of the "sacred texts" (`Cargo.toml` and `main.rs`) to the terminal.
4.  **The Purification:** It deletes the entire project folder immediately after completion.

The project is ephemeral. The "cargo" (the successful execution) is delivered, and the runway is wiped clean.

### 4. The Implementation (Hermetic & Robust)

This version of the Flake uses a `trap` to ensure the ritual site is cleaned up even if the "ceremony" fails.

```nix
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

# Create a unique temporary directory
TMP_DIR=$( ${pkgs.coreutils}/bin/mktemp -d )

# Ensure cleanup on exit (success or failure)
trap 'rm -rf "$TMP_DIR"' EXIT

# Execute the ritual in a subshell
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
```

### Add a non-cargo-cult version without magic

```nix

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

      hello = { pkgs } : pkgs.writeTextFile { name = "cargo-cult"; executable = true; destination = "/bin/hello";
        text = ''#!${pkgs.stdenv.shell}
set -e

# Create a unique temporary directory using Nix coreutils
TMP_DIR=$( ${pkgs.coreutils}/bin/mktemp -d )

# Set a trap to ensure the directory is removed on exit, no matter what happens
trap 'rm -rf "$TMP_DIR"' EXIT

# Non-cargo-cult version without magic
(
  cd "$TMP_DIR"
  cat > Cargo.toml <<'EOF'
[package]
name = "hello"
version = "0.1.0"
edition = "2024"

[dependencies]
EOF
  mkdir src
  cat > src/main.rs <<'EOF'
fn main() {
  println!("Hello, world!");
}
EOF
  ${pkgs.cargo}/bin/cargo build --release --quiet
)

# Run the final binary
# source code will be deleted after exit
$TMP_DIR/target/release/hello 
rm ./hello
        '';};

    in {
      packages.aarch64-darwin.default = readme { pkgs = aarch64-darwin; };
      packages.aarch64-linux.default = readme { pkgs = aarch64-linux; };
      packages.x86_64-linux.default = readme { pkgs = x86_64-linux; };

      packages.aarch64-darwin.cargo-cult = cargo-cult { pkgs = aarch64-darwin; };
      packages.aarch64-linux.cargo-cult = cargo-cult { pkgs = aarch64-linux; };
      packages.x86_64-linux.cargo-cult = cargo-cult { pkgs = x86_64-linux; };

      packages.aarch64-darwin.hello = hello { pkgs = aarch64-darwin; };
      packages.aarch64-linux.hello = hello { pkgs = aarch64-linux; };
      packages.x86_64-linux.hello = hello { pkgs = x86_64-linux; };
    };
}

```
