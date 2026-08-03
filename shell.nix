{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    # Build Infrastructure & Header Discovery
    pkg-config
    gcc
    gnumake

    # Ruby Environment
    ruby_3_3
    bundler

    # Database & C Libraries
    sqlite
    libyaml
    zlib
    libffi
    openssl
    readline

    # JS / Asset Tooling (Using updated Node LTS)
    nodejs
    yarn

    # Version Control
    git
  ];

  shellHook = ''
    echo "=== Ruby on Rails Development Environment ==="
    echo "Ruby version:   $(ruby -v)"
    echo "Bundler:        $(bundle -v)"
    echo "SQLite3:        $(sqlite3 --version | cut -d' ' -f1,2)"
    echo "Node.js:        $(node -v)"
    echo "============================================="

    # Isolate installed gems inside the project directory
    export GEM_HOME="$PWD/vendor/bundle"
    export PATH="$GEM_HOME/bin:$PATH"
    export BUNDLE_PATH="$GEM_HOME"
  '';
}
