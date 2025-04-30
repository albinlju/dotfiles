{
  packageOverrides = pkgs: with pkgs; {
    myPackages = pkgs.buildEnv {
      name = "albinlju-packages";
      paths = [
        zsh-completions
        (pkgs.neovim.overrideAttrs {
          version = "0.10.4";
          src = pkgs.fetchFromGitHub {
            owner = "neovim";
            repo = "neovim";
            rev = "v0.10.4";
            sha256 = "TAuoa5GD50XB4OCHkSwP1oXfedzVrCBRutNxBp/zGLY";
          };
        })
        dwt1-shell-color-scripts
        pure-prompt
        starship
        nodejs
        tmux
        fd
        ripgrep
        fzf
        lazygit
        ascii-image-converter
      ];
    };
  };
}
