{
  packageOverrides = pkgs: with pkgs; {
    myPackages = pkgs.buildEnv {
      name = "albinlju-packages";
      paths = [
        zsh-completions
        neovim
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
