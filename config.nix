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
            sha256 = "116knnhv4znak5gczr2r93bs8w5sz2cfnnknxmpdn58lc0g9jhv9";
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
