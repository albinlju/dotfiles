{
  packageOverrides = pkgs: with pkgs; {
    myPackages = pkgs.buildEnv {
      name = "albinlju-packages";
      paths = [
        zsh-completions
        neovim
        nodejs_22
        dwt1-shell-color-scripts
        pure-prompt
        fd
        ripgrep
        fzf
        lazygit
        ascii-image-converter
      ];
    };
  };
}
