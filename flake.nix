{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    javelin = {
      url = "github:jthlim/javelin-steno";
      flake = false;
    };
    javelin-rp2040 = {
      url = "github:jthlim/javelin-steno-rp2040";
      flake = false;
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, javelin, javelin-rp2040 }: 
    flake-utils.lib.eachDefaultSystem (system: 
    let 
      pkgs = import nixpkgs {
        inherit system;
      };
      local-pico-sdk = pkgs.pico-sdk.overrideDerivation (oldAttrs: {
        src = pkgs.fetchFromGitHub {
          owner = "raspberrypi";
          repo = "pico-sdk";
          rev = "1.5.1";
          fetchSubmodules = true;
          hash = "sha256-GY5jjJzaENL3ftuU5KpEZAmEZgyFRtLwGVg3W1e/4Ho=";
        };
      });
      deps = with pkgs; [ cmake gcc-arm-embedded local-pico-sdk python3];
    in rec { 
      packages.default = pkgs.stdenv.mkDerivation {
        name = "javelin-rp2040";
        src = javelin-rp2040;
        nativeBuildInputs = deps;
        env = {
          PICO_SDK_PATH = "${local-pico-sdk}/lib/pico-sdk";
        };
        configurePhase = ''
          ln -s "${javelin}" javelin
          cmake -DJAVELIN_BOARD=uni_v4
        '';
        installPhase = ''
          mkdir $out
          mv javelin-steno-rp2040.uf2 $out
        '';
      };
      devShells.default = pkgs.mkShell {
        buildInputs = deps;
        env = {
          PICO_SDK_PATH = "${local-pico-sdk}/lib/pico-sdk";
          JAVELIN = "${javelin}";
          JAVELIN_RP2040 = "${javelin-rp2040}";
        };
      };
    }
  );
}
