{
  description = "Flake for rofi-launchers";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
  in {
    packages.${system}.default = pkgs.stdenvNoCC.mkDerivation {
      pname = "rofi-launchers";
      version = "unstable";

      src = self + "/files";

      buildInputs = [pkgs.rofi-wayland];

      postPatch = ''
        # Fix shell paths
        files=$(find -type l)
        for file in $files; do
          substituteInPlace $file \
            --replace-fail "$HOME/.config/rofi" "$out/share" \
            --replace-fail "rofi " "${pkgs.lib.getExe pkgs.rofi-wayland} "
        done

        # Fix style paths
        files=$(find -type f -name "*.rasi")
        for file in $files; do
          substituteInPlace "$file" \
            --replace-quiet "~/.config/rofi" "$out/share"
        done
      '';

      installPhase = ''
        runHook preInstall

        # Copy all files
        mkdir -p "$out/share"
        cp -r * "$out/share"

        # Install shell binary
        mkdir -p $out/bin
        install -Dm755 $out/share/rofi-launch.sh $out/bin/rofi-launch

        # Move fonts
        mkdir -p "$out/share/fonts/truetype"
        mv "$out/share/assets/fonts/"* "$out/share/fonts/truetype/"
        rmdir "$out/share/assets/fonts"

        runHook postInstall
      '';

      meta = {
        description = "A collection of rofi launchers";
        homepage = "https://github.com/BinaryQuantumSoul/rofi-launchers-nix";
        maintainers = with pkgs.lib.maintainers; [];
        platforms = pkgs.lib.platforms.linux;
      };
    };

    devShell.${system} = pkgs.mkShell {
      buildInputs = [self.packages.${system}.default];

      shellHook = ''
        export PATH=${self.packages.${system}.default}/bin:$PATH
        echo "rofi-launcher script in PATH"

        export XDG_DATA_DIRS="${self.packages.${system}.default}/share:$XDG_DATA_DIRS"
        export FONTCONFIG_PATH="${self.packages.${system}.default}/etc/fonts"

        fc-cache -v -f "${self.packages.${system}.default}/share/fonts/truetype"
        echo "Fonts cache updated"
      '';
    };
  };
}
