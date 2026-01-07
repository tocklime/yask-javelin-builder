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
      pico-sdk-subs = pkgs.pico-sdk.tests.withSubmodules;
      deps = with pkgs; [ cmake gcc-arm-embedded pico-sdk-subs python3 picotool elf2uf2-rs ];
      my_yask_file = ./yask.h;
    in rec { 
      packages.default = pkgs.stdenv.mkDerivation {
        name = "javelin-rp2040";
        src = javelin-rp2040;
        nativeBuildInputs = deps;
        env = {
          PICO_SDK_PATH = "${pico-sdk-subs}/lib/pico-sdk";
          PICO_TOOLCHAIN_PATH = "${pkgs.gcc-arm-embedded}";
        };
        postUnpack = ''
          cp -r "${javelin}" source/javelin
          ln -s source/javelin javelin-steno
          cp "${my_yask_file}" source/config/yask.h
          chmod a+w source/javelin
        '';
        configurePhase = ''
          mkdir build
          cd build
          cmake .. -D JAVELIN_BOARD=yask
        '';
        #patches = [ ./0001_uk_keyboard.patch ];
        installPhase = ''
          mkdir $out
          elf2uf2-rs javelin-steno-pico.elf $out/javelin-steno-pico.uf2
        '';
      };
      devShells.default = pkgs.mkShell {
        buildInputs = deps;
        env = {
          PICO_SDK_PATH = "${pico-sdk-subs}/lib/pico-sdk";
          PICO_TOOLCHAIN_PATH = "${pkgs.gcc-arm-embedded}";
          JAVELIN = "${javelin}";
          JAVELIN_RP2040 = "${javelin-rp2040}";
        };
      };
    }
  );
}
